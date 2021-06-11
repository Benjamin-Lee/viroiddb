<template>
  <div>
    <!-- <TheHeader>{{ data.name }}</TheHeader> -->
    <!-- This example requires Tailwind CSS v2.0+ -->
    <div class="md:flex md:items-center md:justify-between">
      <div class="flex-1 min-w-0">
        <h2
          class="
            text-2xl
            font-bold
            leading-7
            text-gray-900
            sm:text-3xl
            sm:truncate
          "
        >
          Back End Developer
        </h2>
      </div>
      <div class="mt-4 flex md:mt-0 md:ml-4">
        <button
          type="button"
          class="
            inline-flex
            items-center
            px-4
            py-2
            border border-gray-300
            rounded-md
            shadow-sm
            text-sm
            font-medium
            text-gray-700
            bg-white
            hover:bg-gray-50
            focus:outline-none
            focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
          "
        >
          Edit
        </button>
        <button
          type="button"
          class="
            ml-3
            inline-flex
            items-center
            px-4
            py-2
            border border-transparent
            rounded-md
            shadow-sm
            text-sm
            font-medium
            text-white
            bg-indigo-600
            hover:bg-indigo-700
            focus:outline-none
            focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
          "
        >
          Publish
        </button>
      </div>
    </div>

    <div class="py-6">
      <div
        class="
          max-w-3xl
          mx-auto
          sm:px-6
          lg:max-w-7xl
          lg:px-8
          lg:grid lg:grid-cols-12
          lg:gap-8
        "
      >
        <main class="lg:col-span-9 xl:col-span-4">
          <!-- Your content -->
          <!-- This example requires Tailwind CSS v2.0+ -->
          <Card
            title="Sequence information"
            subtitle="Basic information about the sequence."
          >
            <template #unpaddedBody>
              <div class="border-t border-gray-200 px-4 py-5 sm:p-0">
                <dl class="sm:divide-y sm:divide-gray-200">
                  <DataRow
                    v-for="field in sequenceInfoFields"
                    :key="field.name"
                    :title="field.name"
                  >
                    <div v-if="field.key === 'gc'">
                      {{
                        Number(sequenceMetadata[field.key] * 100).toFixed(1)
                      }}%
                    </div>
                    <div v-else-if="field.key === 'length'">
                      {{ sequenceMetadata[field.key] }} bp
                    </div>
                    <div
                      v-else-if="['complete', 'ambiguous'].includes(field.key)"
                    >
                      {{ sequenceMetadata[field.key] ? 'Yes' : 'No' }}
                    </div>
                    <div v-else>
                      {{
                        sequenceMetadata[field.key]
                          ? sequenceMetadata[field.key]
                          : 'Unavailable'
                      }}
                    </div>
                  </DataRow>
                </dl>
              </div>
            </template>
          </Card>
        </main>
        <div class="col-span-4">
          <Card title="Links" subtitle="External resources for this sequence"
            ><template #unpaddedBody>
              <ul class="divide-y divide-gray-200">
                <li
                  v-for="link in links"
                  :key="link.name"
                  class="
                    py-4
                    sm:py-5
                    sm:px-6
                    text-sm text-indigo-600
                    hover:underline
                  "
                >
                  <a :href="link.url" target="_blank">
                    {{ link.name }}
                  </a>
                </li>
              </ul>
            </template></Card
          >
        </div>

        <div class="col-span-4">
          <Card title="Taxonomy" subtitle="According to NCBI Taxonomy"
            ><template #unpaddedBody>
              <DataRow title="Type" class="capitalize">{{
                sequenceMetadata.type
              }}</DataRow>
              <DataRow
                title="Family"
                v-if="sequenceMetadata.type !== 'retrozyme'"
                ><i>{{
                  sequenceMetadata.family
                    ? sequenceMetadata.family
                    : 'Incertae sedis'
                }}</i></DataRow
              >
              <DataRow
                title="Genus"
                v-if="sequenceMetadata.type !== 'retrozyme'"
                ><i>{{
                  sequenceMetadata.genus
                    ? sequenceMetadata.genus
                    : 'Incertae sedis'
                }}</i></DataRow
              >
            </template></Card
          >
        </div>

        <div class="col-span-8">
          <Card
            title="Ribozymes"
            subtitle="Infernal search results for known ribozymes"
          >
            <p class="text-sm text-gray-900">
              Our search did not reveal any ribozmyes in the sequence. If you
              believe this is in error, please
              <NuxtLink to="/contact" class="text-indigo-600 hover:underline"
                >contact us</NuxtLink
              >.
            </p></Card
          >
        </div>
        <div class="col-span-4">
          <Card title="Collection information"
            ><template #unpaddedBody>
              <DataRow title="Submitters">
                {{
                  sequenceMetadata.submitters
                    ? sequenceMetadata.submitters
                    : 'Unavailable'
                }}
              </DataRow>
              <DataRow title="Host">
                <i>{{
                  sequenceMetadata.host ? sequenceMetadata.host : 'Unavailable'
                }}</i>
              </DataRow>
              <DataRow title="Isolation Source" class="capitalize">
                {{
                  sequenceMetadata.isolationSource
                    ? sequenceMetadata.isolationSource
                    : 'Unavailable'
                }}
              </DataRow>
              <DataRow title="Location">
                {{
                  sequenceMetadata.geoLocation
                    ? sequenceMetadata.geoLocation
                    : 'Unavailable'
                }}
              </DataRow>
              <DataRow title="Collection Date">
                {{
                  sequenceMetadata.collectionDate
                    ? sequenceMetadata.collectionDate
                    : 'Unavailable'
                }}
              </DataRow>
            </template>
          </Card>
        </div>
        <div class="col-span-6">
          <Card title="Secondary structure (+)">
            <iframe
              class="w-full h-96"
              src="http://nibiru.tbi.univie.ac.at/forna/forna.html?id=url/name&sequence=AACGUUAGUU&structure=(((....)))"
            ></iframe>
          </Card>
        </div>
        <div class="col-span-6">
          <Card title="Secondary structure (-)">
            <iframe
              class="w-full h-96"
              src="http://nibiru.tbi.univie.ac.at/forna/forna.html?id=url/name&sequence=AACGUUAGUU&structure=(((....)))"
            ></iframe>
          </Card>
        </div>
        <Card
          title="Nucleotide sequence"
          subtitle="FASTA-formatted sequence data."
          class="col-span-12"
        >
          <template #unpaddedBody>
            <div class="divide-y divide-gray-200">
              <DescriptionToggle
                title="Reverse complement"
                subtitle="Display the reverse complement of the sequence."
                class="px-4 py-5 sm:p-6"
                v-model="sequenceDisplayOptions.rc"
              ></DescriptionToggle>
              <DescriptionToggle
                title="Rotated"
                subtitle="Whether to display the sequence rotated to the same origin as other members of the group."
                class="px-4 py-5 sm:p-6"
                :checked="false"
                v-model="sequenceDisplayOptions.rotated"
              ></DescriptionToggle>
              <DescriptionToggle
                title="RNA"
                subtitle="Display RNA bases instead of DNA (i.e. U instead of T)"
                class="px-4 py-5 sm:p-6"
                v-model="sequenceDisplayOptions.rna"
              ></DescriptionToggle>

              <pre class="text-sm overflow-x-auto px-4 py-5 sm:p-6">
>{{ sequenceMetadata.accession }} {{
                  'genBankTitle' in sequenceMetadata
                    ? sequenceMetadata.genBankTitle
                    : sequenceMetadata.displayTitle
                }} [ViroidDB]
{{ displaySequence.match(new RegExp('.{1,' + 80 + '}', 'g')).join('\n') }}
</pre
              >
            </div>
          </template>
        </Card>
        <aside class="col-span-4">
          <div class="sticky top-6 space-y-4">
            <!-- Your content -->
            <!-- This example requires Tailwind CSS v2.0+ -->
          </div>
        </aside>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
import { parseStringPromise } from 'xml2js'

export default Vue.extend({
  data() {
    return {
      sequenceInfoFields: [
        { name: 'Accession', key: 'accession' },
        { name: 'Length', key: 'length' },
        { name: 'GC Content', key: 'gc' },
        { name: 'Release Date', key: 'releaseDate' },
        { name: 'Database', key: 'sequenceType' },
      ],
      sequenceDisplayOptions: { rc: false, rotate: false, rna: false },
      uid: '',
      sequence:
        'GTCATAAGTTTCGTCGCATTTCAGCGACTCATCAGTGGGCTTAGCCCAGACTTATGAGAGAGTAAAGACCTCTCAGCCCCTCCACCTTGGGGTGCCCTATTCGGAGCACTGCAGTTCCCGATAGAAAGGCTAAGCACCTCGCAATGAGGTAAGGTGGGACTTTTCCTTCTGGAACCAAGCGGTTGGTTCCGAGGGGGGTGTGATCCAGGTACCGCCGTAGAAACTGGATTACGACGTCTACCCGGGATTCAAACCCGTCCCCTCCAGAAGTGATTCTGGATGAAGAGTCTGTGCTAAGCACACTGACGAGTCTCTGAGATGAGACGAAACTCTTCTT',
    }
  },
  async fetch() {
    this.uid = await fetch(
      `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=${this.$route.params.name}`
    )
      .then((res) => res.text())
      .then((body) => parseStringPromise(body))
      .then((result) => result.eSearchResult.IdList[0].Id[0])
  },

  computed: {
    displaySequence() {
      let seq = this.sequence.toUpperCase()

      if (this.sequenceDisplayOptions.rc) {
        seq = seq.replaceAll('U', 'T') // force DNA for now
        let rc = {
          G: 'C',
          A: 'T',
          T: 'A',
          C: 'G',
          Y: 'R', // ambiguous
          R: 'Y',
          K: 'M',
          M: 'K',
          B: 'V',
          V: 'B',
          D: 'H',
          H: 'D',
        }
        seq = seq
          .split('')
          .map((x) => rc[x])
          .reverse()
          .join('')
      }

      if (!this.sequenceDisplayOptions.rna) {
        seq = seq.replaceAll('U', 'T')
      } else {
        seq = seq.replaceAll('T', 'U')
      }

      return seq
    },
    sequenceMetadata() {
      return this.$store.state.metadata[this.$route.params.name]
    },
    links() {
      return [
        {
          name: 'NCBI Nucleotide',
          url: `https://www.ncbi.nlm.nih.gov/nuccore/${this.sequenceMetadata.accession}`,
        },
        {
          name: 'Taxonomy',
          url: `https://www.ncbi.nlm.nih.gov/taxonomy?LinkName=nuccore_taxonomy&from_uid=${this.uid}`,
        },
        {
          name: 'PubMed',
          url: `https://www.ncbi.nlm.nih.gov/pubmed?LinkName=nuccore_pubmed&from_uid=${this.uid}`,
        },
      ]
    },
  },
})
</script>
