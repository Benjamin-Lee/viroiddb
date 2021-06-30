---
title: About ViroidDB
description: About us, about Viroids, and some in between.
---

## Frequently Asked Questions

### What are viroid-like RNA agents?

Viroids are a unique group of semi mobile genetic agents, characterized by small genome sizes (less than 2000 nt), highly structured, circular genomes, use of self-cleaving ribozymes or co-opted host enzymes, and replication via the rolling circle mechanism.
This database is curated to cover the entirety of viroid-like RNA agents: Viroids, small circular satellite RNAs, the recently described realm of ribozyviruses (_i.e._, hepatitis delta virus and its relatives), and retrozymes.

### Why do Viroids need their own Database?

Despite the ever-increasing diversity and host range of these agents, no database currently exists. The most recent such database, [the subviral RNA database](doi.org/10.1186/1471-2180-6-24), was published 15 years ago and is no longer accessible.  
To better support computational and experimental research on these agents, we have semi-automatically compiled a database of nearly ten thousand viroid-like RNA sequences from the NCBI's nucleotide database and made them available for download at viroids.org. In addition to curating the respective INSDC accessions and sequences, we have performed considerable post-processing so that ViroidDB entries are consistently formatted, enabling their direct use in common downstream analyses (e.g. circular sequences are consistently rotated and all sequence sets are deduplicated and estimated to represent complete genomes). For use cases where the complete range of variation is undesirable, we have performed clustering to identify a representative sequence for each cluster when no reference sequence is available. The database is version controlled and accessible by web via a simple graphical user interface or by command-line interface for programmatic data retrieval. Furthermore, the database is permanently archived in the Zenodo repository, ensuring future accessibility.

### Why are Viroids important?

Pathogenic members infect both plants and animals, and reports of resulting diseases have been documented since the 1930s. Presently, the only effective means of disease control is the prevention of spread, and crop infection may cause up to a 40% reduction of yield.  
If that doesn't convince you, let us ask **you** a question: Do you like long, curly french fries in MacDonalds?

![image](https://user-images.githubusercontent.com/41674327/123809317-2ccd2e80-d8fa-11eb-9ae4-47765b1bef29.png)  
 Well, even if adible, one of the earliest known viroids can shatter the american dream of a nice, salty, deep fried french fry:  
 ![image](https://www.daera-ni.gov.uk/sites/default/files/styles/inline-expandable/public/images/daera/PSTVd%20photo.1.jpg?itok=dmmWZovB)  
 Healthy potato tuber (left), and spindle shaped tubers (right) that have been affected by PSTVd. © Dr. J. W. Roenhorst NPPO-NL

### How do we curate the database?

To collect the sequences for the database we followed this protocol:

For viroids and deltaviruses, we used the NCBI Virus portal to download complete sequences within the taxonomy IDs:  
| Subset | #Sequences | NCBI TaxID |
|----------------|------------|------------------------------------------------------------------------------|
| All | 9891 | ---- |
| Viroids | 9354 | |
| Avsunviroidae | 5284 | [185752](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185752) |
| Pospiviroidae | 3980 | [185751](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185751) |
| Unclassified | 90 | [265963](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=265963) |
| Deltavirus | 453 | [39759](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=39759) |
| Satellite RNAs | 35 | [141863](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=141863) |

For retrozymes, which are currently not taxonomically classified as monophyletic group, we downloaded all sequences within the NCBI Nucleotide database matching the search term ["retrozymes"](https://www.ncbi.nlm.nih.gov/nuccore/?term=retrozymes).  
Please note that due to the procedural de-duplication steps we perform, exact replications (identical strings) are masked from most down stream analyses (such as secondary structure prediction and ribozyme search), to avoid unnecessary use of computation resources and eventual storage space.

### Do you modify the original INSDC indexed sequences?

Short answer - no. Long answer - Yes, but when we do, we clearly note it. For example, rotated sequences, reverse complement, and RNA ( T --> U) versions of reference sequences are suffixed (in the fasta header) by the addition of [ViroidDB] at the end of the defline.  
Please see [Download](./Download) for more information about how to fetch and acquire any of the data from ViroidDB.

> **Note:** The **majority ** of the information in the database is derived from subsequent analyses we performed using the original sequences.

### I found a new viroid I would like to be on ViroidDB, what should I do?

### How can I contact you?

Feel free to contact us via sending an [email](email:help@Viroids.org) or filing an issue on GitHub.

### How often will ViroidDB be updated?

Should new viroid-like RNAs classes be discovered, we hope to add them automatically on (at least) a yearly basis. If you feel an update is required, please contact us or perform the update yourself by submitting it as a pull request in the GitHub repository.
