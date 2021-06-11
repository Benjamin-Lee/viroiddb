/* eslint-disable no-console */
import fs from 'fs'
import path from 'path'
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

        metadata = {
          ...Object.fromEntries(jsonObj.map((el) => [el.accession, el])),
          ...metadata,
        }
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
  const dirName =
    process.argv[1] !== undefined
      ? process.argv[2]
      : new Date().toISOString().slice(0, 10)
  bioparsers
    .fastaToJson(
      fs.readFileSync(path.join(dirName, group + '.fasta'), 'utf8'),
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
          accession: x.name.split(' ')[0],
          length: x.sequence.length,
        },
      }
    })
    .forEach((el) =>
      Object.entries(el).forEach(
        ([k, v]) => (metadata[k] = { ...metadata[k], ...v })
      )
    )
  console.warn('Done with', group)
}

// Object.entries(computedMetadata).forEach(
//   ([k, v]) => console.log(k, { ...metadata[k] })
//   // console.log(metadata[k], v)
// )

Object.entries(metadata).forEach(([k, v]) => {
  metadata[k].type = v?.species?.includes('viroid')
    ? 'viroid'
    : v?.genus?.includes('virus')
    ? 'virus'
    : v?.species?.toLowerCase().includes('satellite')
    ? 'satellite RNA'
    : 'retrozyme'
  metadata[k].releaseDate = v.releaseDate?.slice(0, 10)
})

console.log(JSON.stringify(metadata, null, 2))
