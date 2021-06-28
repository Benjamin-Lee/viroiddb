/* eslint-disable no-console */
import fs from 'fs'
import path from 'path'
import csv from 'csvtojson'
import camelCase from 'camelcase'
import bioparsers from 'bio-parsers'

let metadata = {}

const dirName =
  process.argv[2] !== undefined
    ? process.argv[2]
    : new Date().toISOString().slice(0, 10)

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
  // derive metadata from the sequence itself
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
          sequence: x.sequence,
        },
      }
    })
    .forEach((el) =>
      Object.entries(el).forEach(
        ([k, v]) => (metadata[k] = { ...metadata[k], ...v })
      )
    )

  // add the identical group information
  Object.entries(
    JSON.parse(
      fs.readFileSync(path.join(dirName, group + '.groups.json'), 'utf8')
    )
  ).forEach(([k, v]) => {
    metadata[k.split(' ')[0]].identicalSeqs = v.map((x) => x.split(' ')[0])
  })
  // if no identical seqs, put an empty array
  Object.entries(metadata).forEach(
    ([k, v]) => (metadata[k] = { identicalSeqs: [], ...v })
  )

  // Add the secondary structure information
  const lines = fs
    .readFileSync(path.join(dirName, `${group}.dbn`))
    .toString()
    .split('\n')
  const structure = {
    ...lines.reduce((result, value, index, array) => {
      if (index % 3 === 0) {
        if (value === '') {
          return result
        }
        const [dbn, mfe] = array[index + 2].split(' ')
        result[value.split(' ')[0].slice(1)] = {
          plus: {
            // remove > and seq name
            dbn,
            mfe: Number(mfe.slice(1, -1)),
            basesPaired: 1 - (dbn.match(/\./g) || []).length / dbn.length,
          },
        }
      }
      return result
    }, {}),
  }
  fs.readFileSync(path.join(dirName, `${group}.rc.dbn`))
    .toString()
    .split('\n')
    .forEach((value, index, array) => {
      if (index % 3 === 0) {
        if (value === '') {
          return
        }
        const [dbn, mfe] = array[index + 2].split(' ')
        structure[value.split(' ')[0].slice(1)].minus = {
          dbn, // remove MFE
          mfe: Number(mfe.slice(1, -1)),
          basesPaired: 1 - (dbn.match(/\./g) || []).length / dbn.length,
        }
      }
    })
  Object.entries(structure).forEach(([accession, value]) => {
    metadata[accession] = {
      ...metadata[accession],
      ...{ structure: value },
    }
  })
  console.warn('Done with', group)
}

// infer the type of each sequence
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

// write the Infernal output into the metadata
const infernalOut = fs
  .readFileSync(path.join(dirName, 'ribozymes.txt'))
  .toString()
  .split('\n')
const ribozymes = {}
let currentAcc = ''
for (const line of infernalOut) {
  if (line.startsWith('Query:')) {
    currentAcc = line.split(/[ ,]+/)[1]
    continue
  }
  if (line === '') {
    continue
  }
  if (line.startsWith('#')) {
    continue
  }
  ribozymes[currentAcc] =
    currentAcc in ribozymes ? ribozymes[currentAcc] + '\n' + line : line
}
Object.entries(ribozymes).forEach(([k, v]) => {
  metadata[k] = { ...metadata[k], ribozymes: ribozymes[k] }
})

// console.log(metadata)

// fs.writeFileSync('static/meta.tmp.json', JSON.stringify(metadata, null, 2))
fs.writeFileSync(
  'static/meta.algolia.json',
  JSON.stringify(
    Object.values(metadata)
      .map(
        ({
          accession,
          displayTitle,
          isolationSource,
          geoLocation,
          host,
          species,
          genus,
          family,
          type,
          submitters,
        }) => ({
          accession,
          displayTitle,
          isolationSource,
          geoLocation,
          host,
          species,
          genus,
          family,
          type,
          submitters,
        })
      )
      .filter((x) => typeof x.displayTitle !== 'undefined')
  )
)
