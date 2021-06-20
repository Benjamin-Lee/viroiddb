export interface sequenceMetadata {
  identicalSeqs: string[]
  accession: string
  submitters: string
  releaseDate: string
  species: string
  genus: string
  family: string
  length: number
  sequenceType: string
  geoLocation: string
  host: string
  isolationSource: string
  collectionDate: string
  genBankTitle?: string
  displayTitle: string
  gc: number
  sequence: string
  structure: {
    plus: {
      dbn: string
      mfe: number
      basesPaired: number
    }
    minus: {
      dbn: string
      mfe: number
      basesPaired: number
    }
  }
  type: string
  ribozymes: string
}
