const fs = require('fs')
const bioparsers = require('bio-parsers')
const fetch = require('node-fetch')
const parseString = require('xml2js').parseStringPromise

const data = {}

// get metadata about the sequence
for (const group of [
  'avsunviroidae',
  //   'deltavirus',
  //   'pospiviroidae',
  //   'retrozymes',
  //   'satellites',
  //   'unclassified',
]) {
  let parsed = bioparsers
    .fastaToJson(fs.readFileSync(`db/${group}.fasta`, 'utf8'), {})
    .map((x) => x.parsedSequence)
    .map((x) => {
      return {
        accession: x.name.split(' ')[0],
        name: x.name.slice(x.name.indexOf(' ') + 1).split(',')[0],
        complete: x.name.includes('complete'),
        len: x.size,
        gc: (x.sequence.match(/[GgCc]/g) || []).length / x.sequence.length,
        ambiguous:
          [...x.sequence].filter(
            (y) => !['A', 'T', 'G', 'C'].includes(y.toUpperCase())
          ).length > 0,
      }
    })
  for (const sequence of parsed) {
    data[sequence.accession] = sequence
  }

  // parse the dbn
  let structures = fs.readFileSync(`db/${group}.dbn`, 'utf8').split('\n')
  for (let index = 0; index < structures.length - 2; index += 3) {
    let acc = structures[index].slice(1).split(' ')[0]
    let [dbn, mfe] = structures[index + 2].split(' ')
    data[acc].plus_paired = 1 - (dbn.match(/\./g) || []).length / dbn.length
    data[acc].plus_mfe = parseFloat(mfe.slice(1, -1))
  }
}

console.log(Object.values(data))
// for (const key of Object.keys(data)) {
//   fetch(
//     `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=${key}`
//   )
//     .then((res) => res.text())
//     .then((body) => {
//       console.log(body)
//       return parseString(body)
//     })
//     .then((result) => console.dir(result.eSearchResult.IdList))
// }
