import fs from 'fs'

let dbn = {}

for (const group of [
  'avsunviroidae',
  'deltavirus',
  'pospiviroidae',
  'retrozymes',
  'satellites',
  'unclassified',
]) {
  // eslint-disable-next-line no-console
  console.log('Generating JSON content for', group)
  const lines = fs
    .readFileSync(`db/2021-06-06/${group}.dbn`)
    .toString()
    .split('\n')

  dbn = {
    ...dbn,
    ...lines.reduce((result, value, index, array) => {
      if (index % 3 === 0) {
        if (value === '') {
          return result
        }
        result[value.split(' ')[0].slice(1)] = {
          // remove > and seq name
          sequence: array[index + 1],
          dbn: array[index + 2].split(' ')[0], // remove MFE
        }
      }
      return result
    }, {}),
  }

  fs.readFileSync(`db/2021-06-06/${group}.rc.dbn`)
    .toString()
    .split('\n')
    .forEach((value, index, array) => {
      if (index % 3 === 0) {
        if (value === '') {
          return
        }
        dbn[value.split(' ')[0].slice(1)].dbnRevComp =
          array[index + 2].split(' ')[0] // remove MFE
      }
    })
}

Object.entries(dbn).forEach(([k, v]) =>
  fs.writeFileSync('static/seqs/' + k + '.json', JSON.stringify(v, null, 2))
)
