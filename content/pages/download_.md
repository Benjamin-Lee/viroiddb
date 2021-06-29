---
title: "Download"
description: Data availability and access.
---
All the data displayed on this site is attainable both via the individual sequence pages, and through simple `curl` commands.  
This includes:   

 1. The raw nucleic sequences, along with their related metadata, 'as is', without any modification to their original counterparts of the different public databases such as NCBI's [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/) or [GenBank](https://www.ncbi.nlm.nih.gov/genbank/).
 2. The derived information, including the analyses, outputs, visualizations, etc, which we performed after initial sourcing the entries detailed in 1. This include, among else, sequence clustering ([mmseqs](https://github.com/soedinglab/mmseqs2)), secondary structure prediction ([RNAFold](http://rna.tbi.univie.ac.at/cgi-bin/RNAWebSuite/RNAfold.cgi)), rotational alignments ([CSA](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-230)), and catalytic potential of sub sequences via [infernal](http://eddylab.org/infernal/) based searches using the [Rfam](https://rfam.org/) database.

# How to get the data
For ease of use, we provide These data are  used in this site is available for download in several forms.     
  
| Subset| #Sequences | FASTA| JSON| DBN| SQL| RDS| Pickle                                                                    |
|-----------------------|------------|-------------------------------------------------------------------------|-----------------------------------------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------------|
| All            | 9891       | [/db/all](https://viroids.org/db/all.fasta)                       | [/db/all](https://viroids.org/db/all.json)                       | [/db/all](https://viroids.org/db/all.DBN)                       | [/db/all](https://viroids.org/db/all.SQL)                       | [/db/all](https://viroids.org/db/all.RDS)                       | [/db/all](https://viroids.org/db/all.pickle)                       |
| Viroids        | 9354       | [/db/viroids](https://viroids.org/db/viroids.fasta)               | [/db/viroids](https://viroids.org/db/viroids.json)               | [/db/viroids](https://viroids.org/db/viroids.DBN)               | [/db/viroids](https://viroids.org/db/viroids.SQL)               | [/db/viroids](https://viroids.org/db/viroids.RDS)               | [/db/viroids](https://viroids.org/db/viroids.pickle)               |
| Avsunviroidae  | 5284       | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.fasta)   | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.json)   | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.DBN)   | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.SQL)   | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.RDS)   | [/db/avsunviroidae](https://viroids.org/db/avsunviroidae.pickle)   |
| Pospiviroidae  | 3980       | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.fasta)   | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.json)   | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.DBN)   | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.SQL)   | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.RDS)   | [/db/pospiviroidae](https://viroids.org/db/pospiviroidae.pickle)   |
| Unclassified   | 90         | [/db/unclassified](https://viroids.org/db/viroids.fasta)          | [/db/unclassified](https://viroids.org/db/viroids.json)          | [/db/unclassified](https://viroids.org/db/viroids.DBN)          | [/db/unclassified](https://viroids.org/db/viroids.SQL)          | [/db/unclassified](https://viroids.org/db/viroids.RDS)          | [/db/unclassified](https://viroids.org/db/viroids.pickle)          |
| Deltavirus     | 453        | [/db/deltavirus](https://viroids.org/db/deltavirus.fasta)         | [/db/deltavirus](https://viroids.org/db/deltavirus.json)         | [/db/deltavirus](https://viroids.org/db/deltavirus.DBN)         | [/db/deltavirus](https://viroids.org/db/deltavirus.SQL)         | [/db/deltavirus](https://viroids.org/db/deltavirus.RDS)         | [/db/deltavirus](https://viroids.org/db/deltavirus.pickle)         |
| Retrozymes     | 74         | [/db/retrozymes](https://viroids.org/db/retrozymes.fasta)         | [/db/retrozymes](https://viroids.org/db/retrozymes.json)         | [/db/retrozymes](https://viroids.org/db/retrozymes.DBN)         | [/db/retrozymes](https://viroids.org/db/retrozymes.SQL)         | [/db/retrozymes](https://viroids.org/db/retrozymes.RDS)         | [/db/retrozymes](https://viroids.org/db/retrozymes.pickle)         |
| Satellite RNAs | 10         | [/db/satellites](https://viroids.org/db/satellites.fasta)         | [/db/satellites](https://viroids.org/db/satellites.json)         | [/db/satellites](https://viroids.org/db/satellites.DBN)         | [/db/satellites](https://viroids.org/db/satellites.SQL)         | [/db/satellites](https://viroids.org/db/satellites.RDS)         | [/db/satellites](https://viroids.org/db/satellites.pickle)         |
  





   
