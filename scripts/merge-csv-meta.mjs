/* eslint-disable no-console */
import fs from 'fs'
import csv from 'csvtojson'
import camelCase from 'camelcase'
import bioparsers from 'bio-parsers'

let metadata = {}

await Promise.all(
  [
    'avsunviroidae',
    'deltavirus',
    'pospiviroidae',
    // 'retrozymes',
    'satellites',
    'unclassified',
  ].map((element) => {
    return csv()
      .fromFile('db/raw/' + element + '.csv')
      .then((jsonObj) => {
        // convert keys to camelCase
        jsonObj = jsonObj.map((element) =>
          Object.fromEntries(
            Object.entries(element).map(([k, v]) => [camelCase(k), v])
          )
        )

        let x = Object.fromEntries(jsonObj.map((el) => [el.accession, el]))
        metadata = { ...x, ...metadata }
        /**
         * [
         * 	{a:"1", b:"2", c:"3"},
         * 	{a:"4", b:"5". c:"6"}
         * ]
         */
      })
  })
)

for (const group of [
  'avsunviroidae',
  'deltavirus',
  'pospiviroidae',
  'retrozymes',
  'satellites',
  'unclassified',
]) {
  const now = new Date()
  let parsed = bioparsers
    .fastaToJson(
      fs.readFileSync(
        `db/${now.toISOString().slice(0, 10)}/${group}.fasta`,
        'utf8'
      ),
      {}
    )
    .map((x) => x.parsedSequence)
    .map((x) => {
      return {
        [x.name.split(' ')[0]]: {
          displayTitle: x.name
            .split(' ')
            .slice(1)
            .join(' ')
            .replaceAll(', complete genome', '')
            .replaceAll(', complete sequence', ''),
          gc: (x.sequence.match(/[GgCc]/g) || []).length / x.sequence.length,
        },
      }
    })
  parsed.forEach((el) =>
    Object.entries(el).forEach(
      ([k, v]) => (metadata[k] = { ...metadata[k], ...v })
    )
  )
  console.log('Done with', group)
}

// Object.entries(computedMetadata).forEach(
//   ([k, v]) => console.log(k, { ...metadata[k] })
//   // console.log(metadata[k], v)
// )

console.log(metadata)
