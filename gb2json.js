const bioparsers = require('bio-parsers')
const fetch = require('node-fetch')

fetch(
  'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=1896494130&rettype=gb&retmode=text'
)
  .then((x) => x.text())
  .then((x) => bioparsers.genbankToJson(x))
  .then((x) => console.log(x[0].parsedSequence))
