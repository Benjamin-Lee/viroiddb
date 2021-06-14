const fs = require('fs')
const bioparsers = require('bio-parsers')
const { program } = require('commander')

function deduplicate(seqs) {
  const identicalGroups = {} // hold the list of canonical sequences and their groups
  for (const sequence of seqs) {
    seq = sequence.sequence.toUpperCase().replaceAll('U', 'T') // force to uppercase DNA just in *case*
    // ignore ambiguous sequences
    // TODO: enable users to include them in output?
    if (!new RegExp(/^[ATGCU]*$/).test(seq)) {
      console.warn(`Ambiguous sequence excluded from output: ${sequence.name}`)
      continue
    }
    let rc = seq
      .split('')
      .map((x) => {
        return { A: 'T', T: 'A', G: 'C', C: 'G' }[x]
      })
      .reverse()
      .join('')
    let canonical = seq // we'll start by assuming the assuming the sequence is already canonical
    for (const x of [seq, rc]) {
      for (let i = 0; i < x.length; i++) {
        let rotated = x.slice(i) + x.slice(0, i) // compute each rotation
        canonical = rotated < canonical ? rotated : canonical // check if it is lexicographically earlier
      }
    }
    identicalGroups[canonical] = identicalGroups[canonical]
      ? identicalGroups[canonical].concat([
          { name: sequence.name, sequence: sequence.sequence },
        ])
      : [{ name: sequence.name, sequence: sequence.sequence }]
  }
  return identicalGroups
}

program
  .version('0.0.1')
  .arguments('<files...>')
  .description('Deduplicate circular sequences with canonical rotations', {
    files:
      'One or more FASTA-formatted sequence files. Use "-" to denote stdin.',
  })
  .option(
    '-g, --groups <groupFile>',
    'Write the sequences names identical to the outputted sequence as a JSON file'
  )
  .action((files, options) => {
    // make a flat list of sequence objects from all the input files
    files = files.map((x) => (x === '-' ? 0 : x))
    let seqs = files
      .map((file) => {
        return bioparsers
          .fastaToJson(fs.readFileSync(file, 'utf8'), {})
          .map((x) => {
            // raise errors from the parser
            if (x.messages) {
              x.messages.forEach((message) =>
                console.warn(message + `. Sequence: ${x.parsedSequence.name}`)
              )
            }
            return x.parsedSequence
          })
      })
      .flat()

    // handle case where two seqs with same names and different sequences breaks groups
    if (
      options.groups &&
      new Set(seqs.map((x) => x.name + x.description)).size !==
        new Set(seqs).size
    ) {
      throw new Error(
        'Cannot have multiple FASTA entries with identical names but different sequences while using --groups since it would result in ambiguous output'
      )
    }

    // maps from the full name of the outputted sequence to the list of identical sequences
    let representativeToGroup = {}

    // deduplicate, output FASTA of representative sequences, and optionally output JSON of groups
    Object.entries(deduplicate(seqs)).map(([canonical, identicalGroup]) => {
      // find the index of any RefSeq seq or return -1
      // TODO: option for just using the first sequence
      let refseqIndex = identicalGroup.findIndex(
        (x) => x.name.slice(0, 3) === 'NC'
      )

      // identify the name of the representative sequence
      representative =
        refseqIndex === -1 ? identicalGroup[0] : identicalGroup[refseqIndex]

      // output to stdout
      console.log(`>${representative.name}\n${representative.sequence}`)

      // output the JSON object mapping representives to their idental sequences
      // we have to convert it to a set since
      if (options.groups && new Set(identicalGroup).size > 1) {
        representativeToGroup[representative.name] = identicalGroup
          .filter((x) => x !== representative)
          .map((x) => x.name)
      }
    })
    if (options.groups) {
      fs.writeFileSync(
        options.groups,
        JSON.stringify(representativeToGroup, null, 2)
      )
    }
  })
program.parse(process.argv)
