---
title: 'Download'
description: Data availability and access.
---

All the data displayed on this site is attainable both via the individual sequence pages, and through simple `curl` commands.
This includes:

1.  The raw nucleic sequences, along with their related metadata, 'as is', without any modification to their original counterparts of the different public databases such as NCBI's [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/) or [GenBank](https://www.ncbi.nlm.nih.gov/genbank/).
2.  The derived information, including the analyses, outputs, visualizations, etc, which we performed after initial sourcing the entries detailed in 1. This include, among else, sequence clustering ([mmseqs](https://github.com/soedinglab/mmseqs2)), secondary structure prediction ([RNAFold](http://rna.tbi.univie.ac.at/cgi-bin/RNAWebSuite/RNAfold.cgi)), rotational alignments ([CSA](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-230)), and catalytic potential of sub sequences via [infernal](http://eddylab.org/infernal/) based searches using the [Rfam](https://rfam.org/) database.

## How to get the data

For ease of use, we provide These data are used in this site is available for download in several forms.

### By Link

All of the data used to display on this site is available for download.
For convenience, **you can download the entire data set (images excluded) as a single JSON file [here](https://viroids.org/db/latest/all.json)**.

In addition to the "master" JSON file available at [`/db/latest/all.json`](https://viroids.org/db/latest/all.json), you can also download the database in various raw data formats broken down by sequence type:

| Subset               | _n_   | FASTA                                                                               | DBN                                                                             | DBN (reverse complement)                                                              | Infernal                                                                              |
| -------------------- | ----- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| All                  | 9,891 | [/db/latest/all.fasta](https://viroids.org/db/latest/all.fasta)                     | [/db/latest/all.dbn](https://viroids.org/db/latest/all.dbn)                     | [/db/latest/all.rc.dbn](https://viroids.org/db/latest/all.rc.dbn)                     | [/db/latest/all.cmscan](https://viroids.org/db/latest/all.cmscan)                     |
| Viroids              | 9,354 | [/db/latest/viroids.fasta](https://viroids.org/db/latest/viroids.fasta)             | [/db/latest/viroids.dbn](https://viroids.org/db/latest/viroids.dbn)             | [/db/latest/viroids.rc.dbn](https://viroids.org/db/latest/viroids.rc.dbn)             | [/db/latest/viroids.cmscan](https://viroids.org/db/latest/viroids.cmscan)             |
| _Avsunviroidae_      | 5,284 | [/db/latest/avsunviroidae.fasta](https://viroids.org/db/latest/avsunviroidae.fasta) | [/db/latest/avsunviroidae.dbn](https://viroids.org/db/latest/avsunviroidae.dbn) | [/db/latest/avsunviroidae.rc.dbn](https://viroids.org/db/latest/avsunviroidae.rc.dbn) | [/db/latest/avsunviroidae.cmscan](https://viroids.org/db/latest/avsunviroidae.cmscan) |
| _Pospiviroidae_      | 3,980 | [/db/latest/pospiviroidae.fasta](https://viroids.org/db/latest/pospiviroidae.fasta) | [/db/latest/pospiviroidae.dbn](https://viroids.org/db/latest/pospiviroidae.dbn) | [/db/latest/pospiviroidae.rc.dbn](https://viroids.org/db/latest/pospiviroidae.rc.dbn) | [/db/latest/pospiviroidae.cmscan](https://viroids.org/db/latest/pospiviroidae.cmscan) |
| Unclassified viroids | 90    | [/db/latest/unclassified.fasta](https://viroids.org/db/latest/viroids.fasta)        | [/db/latest/unclassified.dbn](https://viroids.org/db/latest/viroids.dbn)        | [/db/latest/unclassified.rc.dbn](https://viroids.org/db/latest/viroids.rc.dbn)        | [/db/latest/unclassified.cmscan](https://viroids.org/db/latest/viroids.cmscan)        |
| _Deltavirus_         | 453   | [/db/latest/deltavirus.fasta](https://viroids.org/db/latest/deltavirus.fasta)       | [/db/latest/deltavirus.dbn](https://viroids.org/db/latest/deltavirus.dbn)       | [/db/latest/deltavirus.rc.dbn](https://viroids.org/db/latest/deltavirus.rc.dbn)       | [/db/latest/deltavirus.cmscan](https://viroids.org/db/latest/deltavirus.cmscan)       |
| Retrozymes           | 74    | [/db/latest/retrozymes.fasta](https://viroids.org/db/latest/retrozymes.fasta)       | [/db/latest/retrozymes.dbn](https://viroids.org/db/latest/retrozymes.dbn)       | [/db/latest/retrozymes.rc.dbn](https://viroids.org/db/latest/retrozymes.rc.dbn)       | [/db/latest/retrozymes.cmscan](https://viroids.org/db/latest/retrozymes.cmscan)       |

Note that the release name is excluded from the URL in the above table.
Instead, the latest release is automatically selected.
To override this, replace the `latest` with the release name such as `/db/2021-06-06/avsunviroidae.cmscan`.

### Command Line

If you prefer to download the data programmatically, you can easily do so using a command-line tool such as `curl`.

<the-curl-generator>
    <template #the-curl-generator></template>
</the-curl-generator>

## Data Format

### JSON Data

The JSON data is stored as an array of object.
Each object represents a single sequence.
Within each object are fields pertaining to metadata about the sequence, the sequence itself, and the sequence's annotations.
Here is an example of any element in the JSON file:

```json
  "MF774863.1": {
    "identicalSeqs": [],
    "accession": "MF774863.1",
    "sraAccession": "",
    "submitters": "Fajardo,T.V.M., Eiras,M., Nickel,O.",
    "releaseDate": "2017-10-17",
    "species": "Hop stunt viroid",
    "genus": "Hostuviroid",
    "family": "Pospiviroidae",
    "moleculeType": "ssRNA",
    "length": 298,
    "sequenceType": "GenBank",
    "nucCompleteness": "complete",
    "genotype": "",
    "segment": "",
    "publications": "",
    "geoLocation": "Brazil",
    "usa": "",
    "host": "Vitis flexuosa",
    "isolationSource": "",
    "collectionDate": "2014-08-18",
    "bioSample": "",
    "genBankTitle": "Hop stunt viroid isolate VF, complete genome",
    "displayTitle": "Hop stunt viroid isolate VF",
    "gc": 0.5704697986577181,
    "sequence": "CTGGGGAATTCTCGAGTTGCCGCATAAGGCATGCAAAGAACCTGACTTGGCAGGGAGGTACTTACCTGAGAAAGGAGCCCCGGGGCAACTCTTCTCAGAATCCAGCGAGAGGCGTGGAGAGAGGGCCGCGGTGCTCTGGAGTAGAGGCTCTGCCTTCGAAACACCATCGATCGTCCCTTCTTCTTTACCTTCTTCTGGCTCTTCCGATGAGACGCGACCGGTGGCATCACCTCTCGGTTCGTCCCAACCTGCTTTTGTTCTATCTGAGCCTCTGCCGCGGATCCTCTCTTGAGCCCCT",
    "structure": {
      "plus": {
        "dbn": "..((((....((((((...((((....((((.((..(((....(((..((((((..((.((..(((.((((...(((((((((.((..(((.((..(((..((((.((((((.((((((((((((..(((((.(..(((.((.(((((...)))))....)).)))..)))))).))))).))))))))))))))))).)))...)).)))..))..)))).))).))...)))))))..)).))..))))))...)))...)))..))...)))))))).......)))))))))).",
        "mfe": -135.23,
        "basesPaired": 0.6711409395973154
      },
      "minus": {
        "dbn": ".((((.......(((...(((((...(((((......(((((....(((((..((.((..(((((((((.((.(((.((((..(((.(((.((...((((((((..((((((...(((((.(((....(((.((((((((.((((((...))))....))..))))))))))))))))).))...)))).)).)))).))))..)).))).))).))))))))).)))))).)))..)).))..)))))........)))))......))))).)))))...))).......))))..",
        "mfe": -131.2,
        "basesPaired": 0.6442953020134228
      }
    },
    "type": "viroid",
    "ribozymes": "Description: Hop stunt viroid isolate VF, complete genome\nHit scores:\n rank     E-value  score  bias  modelname  start    end   mdl trunc   gc  description\n ----   --------- ------ -----  --------- ------ ------   --- ----- ----  -----------\n   [No hits detected that satisfy reporting thresholds]\nHit alignments:\n   [No hits detected that satisfy reporting thresholds]\nInternal CM pipeline statistics summary:\n----------------------------------------\nQuery sequence(s):                                               1  (596 residues searched)\nQuery sequences re-searched for truncated hits:                  1  (812.9 residues re-searched, avg per model)\nTarget model(s):                                                14  (1095 consensus positions)\nWindows   passing  local HMM SSV           filter:              20  (0.1543); expected (0.35)\nWindows   passing  local HMM Viterbi       filter:                  (off)\nWindows   passing  local HMM Viterbi  bias filter:                  (off)\nWindows   passing  local HMM Forward       filter:               0  (0); expected (0.02)\nWindows   passing  local HMM Forward  bias filter:               0  (0); expected (0.02)\nWindows   passing glocal HMM Forward       filter:               0  (0); expected (0.02)\nWindows   passing glocal HMM Forward  bias filter:               0  (0); expected (0.02)\nEnvelopes passing glocal HMM envelope defn filter:               0  (0); expected (0.02)\nEnvelopes passing  local CM  CYK           filter:               0  (0); expected (0.0001)\nTotal CM hits reported:                                          0  (0); includes 0 truncated hit(s)\n//",
    "Cls_ID70": "2021-06-06-ID70-51",
    "Cls_ID75": "2021-06-06-ID75-48",
    "Cls_ID85": "2021-06-06-ID85-78",
    "Cls_ID80": "2021-06-06-ID80-53",
    "Cls_ID90": "2021-06-06-ID90-90",
    "Cls_ID95": "2021-06-06-ID95-260"
  },
```

Some of these fields are not available for all sequence types although data for all sequences (even those which were excluded from downstream analysis for various) are included.

### FASTA and DBN

FASTA-formatted data is structured as follows:

```
>id name
sequence
> id2 name2
sequence2
...
```

DBN formatting is basically the same as FASTA, but with the addition of a third line with the secondary structure:

```
>id name
sequence
structure
> id2 name2
sequence2
structure2
...
```

The structure is written with dots and brackets, where dots represent unpaired bases and brackets represent paired bases.

### Infernal cmscan

For cmscan ribozyme search results, the output is structured as follows:

```
Query:       NC_003540.1  [L=399]
Description: Chrysanthemum chlorotic mottle viroid, complete genome
Hit scores:
 rank     E-value  score  bias  modelname     start    end   mdl trunc   gc  description
 ----   --------- ------ -----  ------------ ------ ------   --- ----- ----  -----------
  (1) !   8.8e-16   62.5   0.0  Hammerhead_3    134     52 -  cm    no 0.52  Hammerhead ribozyme (type III)
  (2) !    0.0026   17.0   0.0  Hammerhead_3      1     53 +  cm    5' 0.53  Hammerhead ribozyme (type III)


Hit alignments:
>> Hammerhead_3  Hammerhead ribozyme (type III)
 rank     E-value  score  bias mdl mdl from   mdl to       seq from      seq to       acc trunc   gc
 ----   --------- ------ ----- --- -------- --------    ----------- -----------      ---- ----- ----
  (1) !   8.8e-16   62.5   0.0  cm        1       58 []         134          52 - .. 0.99    no 0.52

                                                                                                       NC
                   :((((((,<<<<<___.___._>>>>>,,,,,,,<<<<____.......................____>>>>,,,)))))): CS
  Hammerhead_3   1 caccAGUCgGggCuUG.aGu.aGccCcCUGAUGAGuCugUGA.......................aAuAaGaCGAAACUggug 58
                    :CCAGUCG:::C UG AGU  G:::CCUGAUGAG:CUGUG+                       +A+AAG:CGAAACUGG:
   NC_003540.1 134 UUCCAGUCGAGACCUGaAGUgGGUUUCCUGAUGAGGCUGUGGagagagcgaaagcuuuacucccaCACAAGCCGAAACUGGAA 52
                   *********************************************************************************** PP

>> Hammerhead_3  Hammerhead ribozyme (type III)
 rank     E-value  score  bias mdl mdl from   mdl to       seq from      seq to       acc trunc   gc
 ----   --------- ------ ----- --- -------- --------    ----------- -----------      ---- ----- ----
  (2) !    0.0026   17.0   0.0  cm        9       58 ~]           1          53 + ~. 0.84    5' 0.53

                                                                       ??????  NC
                  ~~~~~<<<<<___.___._>>>>>,,,,,,,.<.<<<________>>>.>,,,)))))): CS
  Hammerhead_3  1 <[8]*gGggCuUG.aGu.aGccCcCUGAUGA.G.uCugUGAaAuAaGa.CGAAACUggug 58
                       G ::C UG  GU  G:: CCUGAUGA G UC: UGA  +A:GA CGAAAC   U
   NC_003540.1  1 <[0]*GGCACCUGaCGUcGGUGUCCUGAUGAaGaUCCAUGA--CAGGAuCGAAACCUCUU 53
                  .....*********9999************85745556655..5555559********** PP



Internal CM pipeline statistics summary:
----------------------------------------
Query sequence(s):                                               1  (798 residues searched)
Query sequences re-searched for truncated hits:                  1  (899.4 residues re-searched, avg per model)
Target model(s):                                                14  (1095 consensus positions)
Windows   passing  local HMM SSV           filter:              47  (0.3644); expected (0.35)
Windows   passing  local HMM Viterbi       filter:                  (off)
Windows   passing  local HMM Viterbi  bias filter:                  (off)
Windows   passing  local HMM Forward       filter:              17  (0.1719); expected (0.02)
Windows   passing  local HMM Forward  bias filter:              16  (0.161); expected (0.02)
Windows   passing glocal HMM Forward       filter:              10  (0.0959); expected (0.02)
Windows   passing glocal HMM Forward  bias filter:              10  (0.0959); expected (0.02)
Envelopes passing glocal HMM envelope defn filter:              10  (0.04149); expected (0.02)
Envelopes passing  local CM  CYK           filter:               3  (0.0114); expected (0.0001)
Total CM hits reported:                                          2  (0.007953); includes 1 truncated hit(s)

# CPU time: 0.17u 0.01s 00:00:00.18 Elapsed: 00:00:00.11
```

Different sequences are delimited by a line containing `//`.
