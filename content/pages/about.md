---
title: About ViroidDB
description: About us, about Viroids, and some in between.
---


#  FAQs

  
<details>
  <summary>What are Viroids/circRNAs? </summary>
  
Viroids/circRNAs are unique groups of semi-mobile genetic agents. They are highly structured, often circular, use self-cleaving ribozymes or co-opted host enzymes, replicate via the rolling circle mechanism, and are characterized by small genome sizes.

This database has been curated to cover the entirety of viroid-like RNA agents: Viroids, small circular satellite RNAs, the recently described realm of ribozyviruses (*i.e.*, hepatitis delta virus and its relatives), and retrozymes.   
</details>  

    
  
<details>
  <summary>Why do Viroids need their own Database?</summary>
  
Despite the ever-increasing diversity and host range of these agents, no database currently exists. The most recent such database, [the subviral RNA database](doi.org/10.1186/1471-2180-6-24), was published 15 years ago and is no longer accessible.  

To better support computational and experimental research on these agents, we have semi-automatically compiled a database of nearly ten thousand viroid-like RNA sequences from the NCBI's nucleotide database and made them available for download at viroids.org. In addition to curating the respective INSDC accessions and sequences, we have performed considerable post-processing so that ViroidDB entries are consistently formatted, enabling their direct use in common downstream analyses (e.g. circular sequences are consistently rotated and all sequence sets are deduplicated and estimated to represent complete genomes). For use-cases where the complete range of variation is undesirable, we have performed clustering to identify a representative sequence for each cluster when no reference sequence is available. The database is version controlled and accessible online via a simple graphical user interface or by command-line interface for programmatic data retrieval. Furthermore, the database is permanently archived in the Zenodo repository, ensuring future accessibility.
  

</details>  

  
<details>
  <summary>Why are Viroids important? </summary>
  
  Pathogenic members infect both plants and animals, and reports of resulting diseases have been documented since the 1930s. Presently, the only effective means of disease control is the prevention of spread, and crop infection may cause up to a 40% reduction of yield.
</details>  



<details>
  <summary>How have we curated the database?</summary>
  

We collected the sequences for the database using the following protocol:

For viroids and deltaviruses, we used the NCBI Virus portal to download complete sequences within the taxonomy IDs:  
| Subset         | #Sequences | NCBI TaxID                                                                   |
|----------------|------------|------------------------------------------------------------------------------|
| All            | 9891       | ----                                                                         |
| Viroids        | 9354       |                                                                              |
| Avsunviroidae  | 5284       | [185752](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185752) |
| Pospiviroidae  | 3980       | [185751](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185751) |
| Unclassified   | 90         | [265963](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=265963) |
| Deltavirus     | 453        | [39759](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=39759)   |
| Satellite RNAs | 35         | [141863](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=141863)   |   


For retrozymes, which are currently not taxonomically classified as monophyletic group, we downloaded all sequences within the NCBI Nucleotide database matching the search term ["retrozymes"](https://www.ncbi.nlm.nih.gov/nuccore/?term=retrozymes).    
We note that due to the de-duplication steps we perform, exact replications (identical strings) are deliberately masked from most downstream analyses (such as secondary structure prediction and ribozyme search), to avoid the use of unnecessary computational resources and storage space.  


</details>  


<details>
  <summary>Have we modified the original INSDC indexed sequences?</summary>
  

Short answer  -  no. Long answer - Yes, but when we do, we clearly note it. For example, rotated sequences,  reverse complement, and RNA  ( T --> U)  versions of reference sequences are suffixed (in the fasta header) by the addition of [ViroidDB] at the end of the defline. Please see [Download](./Download) for more information about how to fetch and acquire this data from ViroidDB.
> **Note:** The **majority ** of the information in the database is derived from analyses we performed using the original sequences.


</details>  


  
  
<details>
  <summary>I found a new viroid I would like to be on ViroidDB, what should I do?</summary>
  
Do you believe we missed something when curating the database? If so, please let us know by filling out the form below and we will be happy to create another release and update the site.

Please remember that all sequences and submission must follow these general inclusion criteria:  

1. The sequence must be uniq
1. The data must be publicly available in an INSDC database
1. Sequence must be complete
1. Sequence must be unambiguous.  
  
Exceptions to these criteria, such as representatives of novel families, may be considered and evaluated on case-by-case basis.  

<SubmitForm/>



</details>  


  
  
<details>
  <summary>How can I contact you? </summary>
  
Feel free to contact us via [email](email:help@Viroids.org) or by filing a GitHub issue.

</details>  

  
  
<details>
  <summary>How often will ViroidDB be updated? </summary>
  
  
Should new viroid-like RNAs classes be discovered, we hope to add them on (at least) a yearly basis. If you believe an update is required, please contact us or perform the update yourself by creating a pull request with the update in the ViroidDB GitHub repository.
</details>  




