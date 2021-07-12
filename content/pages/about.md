---
title: About ViroidDB
description: About us, about viroids, and some in between.
---

## Frequently Asked Questions

### What are viroids?

Viroids are a unique group of semi-mobile genetic agents, characterized by small genome sizes (less than 2000 nt), highly structured circular genomes, use of self-cleaving ribozymes or co-opted host enzymes, and replication via the rolling circle mechanism.

### What are viroid-like RNA agents?

We use the term _viroid-like RNA agent_ to refer to the broad class of _bona fide_ viroids, viroid-like RNAs with unconfirmed independent replication, deltaviruses, retrozymes, and viroid-like circular small satellite RNAs (satRNAs).
These agents have highly structured, single-stranded circular RNA genomes and replicate through the rolling circle mechanism, often with the presence of ribozymes for self-cleavage.
This comprehensive database contains the entirety of viroid-like RNA agents: viroids, small circular satellite RNAs, the recently classified realm of ribozyviruses (_i.e._, hepatitis delta virus and its relatives), and the newly-discovered group of retrozymes.

### Why do viroids need their own database?

Despite their ever-increasing known diversity and host range, a updated database for these agents currently does not exist.
The most recent database, [the subviral RNA database](doi.org/10.1186/1471-2180-6-24), was published 15 years ago and is no longer accessible.  
To better support computational and experimental research on these agents, we have semi-automatically compiled a database of nearly ten thousand viroid-like RNA sequences from the NCBI's nucleotide database and made them available for download at viroids.org.
In addition to curating the respective INSDC accessions and sequences, we have performed considerable post-processing so that ViroidDB entries are consistently formatted, enabling their direct use in common downstream analyses (_i.e._ circular sequences are consistently rotated and all sequence sets are deduplicated and estimated to represent complete genomes).
For use cases where the complete range of variation is undesirable, we have performed clustering to identify a representative sequence for each cluster when no reference sequence is available.
The database is version-controlled and accessible by web via graphical user interface or command-line interface for programmatic data retrieval.
Furthermore, the database is permanently archived in the Zenodo repository, ensuring future accessibility.

### Why are viroids important?

Pathogenic members infect both plants and animals, and reports of resulting diseases have been documented since the 1930s.
Presently, the only effective means of disease control is the prevention of spread, and crop infection may cause up to a 40% reduction of yield.
In addition, deltaviruses can cause symptomatic diseases in humans and other mammals.

### How do we curate the database?

To collect the sequences for the database we followed this protocol:

For viroids and deltaviruses, we used the NCBI Virus portal to download complete sequences within the taxonomy IDs:

| Subset          | Count | NCBI Taxonomy ID                                                             |
| --------------- | ----- | ---------------------------------------------------------------------------- |
| All             | 9891  |                                                                              |
| Viroids         | 9354  |                                                                              |
| _Avsunviroidae_ | 5284  | [185752](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185752) |
| _Pospiviroidae_ | 3980  | [185751](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=185751) |
| Unclassified    | 90    | [265963](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=265963) |
| _Deltavirus_    | 453   | [39759](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=39759)   |
| Satellite RNAs  | 35    | [141863](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=141863) |

For retrozymes, which are currently not taxonomically classified as monophyletic group, we downloaded all sequences within the NCBI Nucleotide database matching the search term ["retrozymes"](https://www.ncbi.nlm.nih.gov/nuccore/?term=retrozymes).
Please note that due to the procedural de-duplication steps we perform, exact replications (identical strings) are masked from most down stream analyses (such as secondary structure prediction and ribozyme search) to avoid unnecessary use of computation resources and eventual storage space.

### Do you modify the original INSDC indexed sequences?

Short answer: no. Long answer: Sort of, but when we do, we clearly note it. For example, rotated sequences, reverse complement, and RNA ( T --> U) versions of reference sequences are suffixed (in the fasta header) by the addition of `[ViroidDB]` at the end of the definition line.  
Please see [Download](./Download) for more information about how to fetch and acquire any of the data from ViroidDB.

**Note:** The **majority** of the information in the database is derived from subsequent analyses we performed using the original sequences.

### I found a new viroid I would like add to ViroidDB. What should I do?

Please contact us with additional information via the form in the [submit](/submit) page.
We're always happy to look at more circRNAs!

### How can I contact you?

Feel free to [email](mailto:help@Viroids.org) us or file an issue on GitHub.

### How often will ViroidDB be updated?

Should new viroid-like RNAs classes be discovered, we hope to add them automatically on (at least) a yearly basis.
If you believe an update is warranted, please [contact us](mailto:help@Viroids.org).

### How do you generate the clusters and their information?

We care about reproducibility just as much as we care about future proofing ViroidDB.
In order to ensure that, as new and exciting circRNAs are discovered, they would be consistently incorporated into new releases, we wrote a custom, standalone pipeline to process all the sequences gathered from the reference databases.
Below is a concise overview of the general workflow.
For a detailed description please refer to the ViroidDB manuscript or visit the ViroidDB GitHub repo to see GPL3/MIT (open source) code.
Briefly, after the sequences are fetched from their original reference database, such as NCBI's [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/) or [GenBank](https://www.ncbi.nlm.nih.gov/genbank/), and verified to meet our curation standards (see above), they are subjected to:

1. The nucleic acid sequences and accompanying metadata are categorized, formatted and converted to JSON format.
   Additional metadata, such as GC content, is also derived from the sequence.
2. The secondary structure is predicted for every sequence ssing [RNAFold](http://rna.tbi.univie.ac.at/cgi-bin/RNAWebSuite/RNAfold.cgi), producing the dot bracket notation (DBN) representation of the structure.
3. The DBN information is used to generate SVG and PDF visualizations (using [forna](http://rna.tbi.univie.ac.at/forna/)).
4. All sequences are scanned for autocatalytic potential of via [infernal](http://eddylab.org/infernal/)-based searches against selected families the [Rfam](https://rfam.org/) database.
5. All sequences are clustered using [mmseqs](https://github.com/soedinglab/mmseqs2) at multiple identity thresholds (see [clusters](/clusters)).
6. Cyclic/rotational alignment is attempt for every cluster using [CSA](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-230).
7. If CSA failed to produce an output (see below for reasons why), cyclic comparison is attempted using [cyclope](http://www.bioinf.uni-leipzig.de/Software/cyclope/index.html).
8. If cyclope fails to produce an output, circular comparison is attempted using [MARS](https://github.com/lorrainea/MARS).
9. All clusters are are then re-aligned using [MAFFT v7.475](https://mafft.cbrc.jp/alignment/software/) (2020-11-23).
   For the minority of the clusters that no cyclic comparison software successfully produce meaningful output, the cluster's sequences are forwarded 'as is' to MAFFT.
10. For every resulting MSA (_one for every cluster_) a consensus sequence is generated (using [Seals-2](https://github.com/YuriWolf-ncbi/seals-2)).
    The consensus sequence is then inserted into the alignment as the first sequence is the multi-FASTA file (to act as a "master sequence").
11. The output of is used to construct nhmm profiles using [HMMER 3.3.2 ](http://hmmer.org/) (2020-11).

### Why do you rotate clusters?

**Note:** For brevity, we use the term "rotation" to describe [circular string permutations](https://en.wikipedia.org/wiki/Cyclic_permutation).

Many downstream analyses rely on multiple sequence alignments (MSA). Circular entities present a vey unique and very often overlooked challenge, as every rotation of the sequences should and must be considered, because variations in sequencing and assembly may result in nearly identical sequences failing to align due to having different origins.

For example, consider the following:

```
>MT883227.1 TGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCCCACGGAATTAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGCTCGACGAAGGCCGGTGAGCAGAAGGCTTAGCGGATCCCCTTGCGGCAAGACGCCCGGAACCGCGATAAAGAACTCGCCGCCGAGCCCGCGCCGCAGCTCCACCGCGCTGCTAGTCGAGCGGAGGCCGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAATGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCC
>LC596500.1 TGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCCTCAGGAATAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGTCGACGAAGGCCGGTGAGCAGTAAGCCGGACGGTCCCCTCGCGGCCGTTCCTCTGGAGCTCTGCTCTAAGAACTTCGTCGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCTAGCGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCC
>MN885659.1 GTGGTTCCTGTGGGTCACCCCGCCCCACGGGAAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGTCGACGAAGGCCGGTGAGCAGTAAGCCGGACGGTCCCCTCGCGGCCGATCCTCTGGAGCTCTGCTCTACGATCTTCGCTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTGAACAAC
>MN885660.1 GTGGGTCACCCCGCCCCACGGGAAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGTCGACGAAGGCCGGTGAGCAGTAAGCCGGACGGTCCCCTCGCGGCCGATCCTCTGGAGCTCTGCTCTACGATCTTCGCTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTG
```

A rudimentary, 'as is' alignment would produce a poor result, often with many long open gap regions and many mismatches:

```
>MT883227.1	TGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCC-CACGGAATTAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGCTCGACGAAGGCCGGTGAGCAGAAGGCTTAGCGGATCCCCTTGCGGCAAGACGCCCGGAA--CCGCGATAAAGAACTCGCCGCCGA-GCCCGCGCCGCAGCTCCACCGCGCTGCTAGTCGAGCGGAGGCCGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAATGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCC------------
>LC596500.1	TGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCCTCAGGAAT--AATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGTGAGCAGTAAGCCGGACGG-TCCCCTCGCGGCCGTTCCTCTGGAGCTCTGCTCTAAGAACTTCGTCGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCTAGCGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCC------------
>MN885659.1	---------------GTGGTTCCTGTGGGTCACCCCGCCC-CACGGGA--AATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGTGAGCAGTAAGCCGGACGG-TCCCCTCGCGGCCGATCCTCTGGAGCTCTGCTCTACGATCTTCGCTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTGAACAAC
>MN885660.1	------------------------GTGGGTCACCCCGCCC-CACGGGA--AATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGTGAGCAGTAAGCCGGACGG-TCCCCTCGCGGCCGATCCTCTGGAGCTCTGCTCTACGATCTTCGCTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAGTCGAGCGGACGTTGGTGGTCTCCCTCTCCCTGTGCAATAAAATCCAGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTG------
```

However, by merely rotating the sequences, prior to alignment, we may arrive at a considerably more reasonable output:

```
>MT883227.1 @ 202 TCGAGCGGAGGCCGGTGGTC-TCCCTCTCCCTGTGCAATAAAA-TCC-AGGTGGCGAATGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCC-CAC-GGA-ATTAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCGCTCGACGAAGGCCGGTGAGCAGAAGGCTTAGCGGATCCCCTTGCGGCAAGACGCCCGGA---A-----C---C-G-CGA-----T--A-----------AAGAAC-TCG-CCGCCGA-GCCCGCGCCGCAGCTCCACCGCGCTGCTAG
>LC596500.1 @ 202 TCGAGCGGACGTTGGTGGTC-TCCCTCTCCCTGTGCAATAAAA-TCCTA-GCGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTGAACAACCTTGTGGTTCCTGTGGGTCACCCCGCCCTCA--GGA-A-TAATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGT-----G-A-GC--A---G------T-------A-A-G-CCGGACGGTCCCCTC--GCGGCCGTTCCTCTGGAGCTCTG-CTCTAAGAACTTCGTC-GCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAG
>MN885659.1 @ 186 TCGAGCGGACGTTGGTGGTC-TCCCTCTCCCTGTGCAATAAAA-TCC-AGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCTGGGTGAACAA-C--GTGGTTCCTGTGGGTCACCCCGCCC-CAC-GGG-A--AATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGT-----G-A-GC--A---G------T-------A-A-G-CCGGACGGTCCCCTC--GCGGCCGATCCTCTGGAGCTCTG-CTCTACGATCTTCG-CTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAG
>MN885660.1 @ 177 TCGAGCGGACGTTGGTGGTC-TCCCTCTCCCTGTGCAATAAAA-TCC-AGGTGGCGAGTGGTGTCCCCAGGGTAAAACACGATTGGTGTTCTCCCT--G-G---------GT-G-----GTGGGTCACCCCGCCC-CAC-GGG-A--AATAAAAGCAGAGGAGTAGAGAGTACTCACCTGTCGTCG-TCGACGAAGGCCGGT-----G-A-GC--A---G------T-------A-A-G-CCGGACGGTCCCCTC--GCGGCCGATCCTCTGGAGCTCTG-CTCTACGATCTTCG-CTGCTGAGGCCCGCGCCGCCGCTCTTCCGCGCTGCTAG
```

### Why do some clusters lack a circular-alignment/block-chain plots?

These plots are produced by our go-to cyclic alignment tool: CSA.
While we found it gives the most useful output, but it is a relatively old software whose original source code only handles clusters with several dozen members.
Therefore, large clusters may be limited to the other cyclic comparison tools we used if CSA failed.
Very briefly, these tools do not go so far as to produce an alignment, rather they attempt to identify the optimal rotation of every sequence in a given multi-FASTA file, so that the distances between subsequent alignments would minimized.  
There are several other possible reasons why a rotated cluster may lack the circular/block visitation.
These range from technical to more matter-of-factly:

- The cluster has too few members.
  Singletons (_clusters compromised of a single sequence_) obviously have no rotational information.
- Some of the cluster members are too short.
- The shortest sequence in the cluster is _considerably_ shorter than the largest sequence.
- A visualization can be rendered, but it was found to be meaningless (_e.g._ cluster members are identical rotations of each other).
