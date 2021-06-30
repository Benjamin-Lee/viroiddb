<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <div>
    <div>
      <div class="text-3xl font-bold mb-6">Download</div>
      <p class="has-line-data" data-line-start="0" data-line-end="2">
        All the data displayed on this site is attainable both via the
        individual sequence pages, and through simple
        <code>curl</code> commands.<br />
        This includes:
      </p>
      <ol>
        <li class="has-line-data my-4" data-line-start="3" data-line-end="4">
          1. The raw nucleic sequences, along with their related metadata, ‘as
          is’, without any modification to their original counterparts of the
          different public databases such as NCBI’s
          <a href="https://www.ncbi.nlm.nih.gov/refseq/">RefSeq</a> or
          <a href="https://www.ncbi.nlm.nih.gov/genbank/">GenBank</a>.
        </li>
        <li class="has-line-data my-4" data-line-start="4" data-line-end="5">
          2. The derived information, including the analyses, outputs,
          visualizations, etc, which we performed after initial sourcing the
          entries detailed in This include, among else, sequence clustering (<a
            href="https://github.com/soedinglab/mmseqs2"
            >mmseqs</a
          >), secondary structure prediction (<a
            href="http://rna.tbi.univie.ac.at/cgi-bin/RNAWebSuite/RNAfold.cgi"
            >RNAFold</a
          >), rotational alignments (<a
            href="https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-230"
            >CSA</a
          >), and catalytic potential of sub sequences via
          <a href="http://eddylab.org/infernal/">infernal</a> based searches
          using the <a href="https://rfam.org/">Rfam</a> database.
        </li>
      </ol>
      <div>
        For ease of use, we provide a <code>curl</code> script generator to
        download data subsets
      </div>
    </div>
    <the-curl-generator></the-curl-generator>
  </div>
</template>
