<template>
  <div>
    <!-- <script src="https://unpkg.com/fornac@1.1.8/dist/scripts/fornac.js"></script> -->
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
          {{ sequenceMetadata.displayTitle }}
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
            w-auto
            text-gray-700
            bg-white
            hover:bg-gray-50
            focus:outline-none
          "
          :class="{ 'bg-green-500': copied, 'hover:bg-green-500': copied }"
          @click="copyFasta"
        >
          <div v-if="!copied">Copy FASTA</div>
          <div v-else class="text-white">Copied!</div>
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
          @click="download"
        >
          Download FASTA{{ sequenceDisplayOptions.dbn ? ' with DBN' : '' }}
        </button>
      </div>
    </div>

    <div class="py-6">
      <div
        class="max-w-3xl mx-auto lg:max-w-7xl lg:grid lg:grid-cols-12 lg:gap-8"
      >
        <main class="col-span-4 pad">
          <!-- Your content -->
          <!-- This example requires Tailwind CSS v2.0+ -->
          <Card
            title="Sequence information"
            subtitle="Basic information about the sequence."
          >
            <template sm:#unpaddedBody>
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
                    <div v-else-if="field.key === 'identicalSeqs'">
                      {{
                        sequenceMetadata.identicalSeqs === []
                          ? sequenceMetadata[field.key].join(', ')
                          : 'None found'
                      }}
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

        <div class="col-span-4 pad">
          <Card
            title="Collection information"
            subtitle="Provided by the depositors"
            ><template sm:#unpaddedBody>
              <DataRow title="Submitters">
                {{
                  sequenceMetadata.submitters
                    ? sequenceMetadata.submitters
                    : 'Unavailable'
                }}
              </DataRow>
              <DataRow title="Host">
                <i :class="sequenceMetadata.host ? 'italic' : 'not-italic'">{{
                  sequenceMetadata.host ? sequenceMetadata.host : 'Unavailable'
                }}</i>
              </DataRow>
              <DataRow title="Source" class="capitalize">
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
        <div class="col-span-4 pad">
          <Card title="Taxonomy" subtitle="According to NCBI Taxonomy"
            ><template sm:#unpaddedBody>
              <DataRow title="Type" class="capitalize">{{
                sequenceMetadata.type
              }}</DataRow>
              <DataRow
                v-if="sequenceMetadata.type !== 'retrozyme'"
                title="Family"
                ><i>{{
                  sequenceMetadata.family
                    ? sequenceMetadata.family
                    : 'Incertae sedis'
                }}</i></DataRow
              >
              <DataRow
                v-if="sequenceMetadata.type !== 'retrozyme'"
                title="Genus"
                ><i>{{
                  sequenceMetadata.genus
                    ? sequenceMetadata.genus
                    : 'Incertae sedis'
                }}</i></DataRow
              >
              <DataRow
                v-if="sequenceMetadata.type !== 'retrozyme'"
                title="Species"
              >
                <i>
                  {{
                    sequenceMetadata.species
                      ? sequenceMetadata.species
                      : 'Unavailable'
                  }}
                </i>
              </DataRow>
            </template></Card
          >
        </div>
        <Card
          title="Nucleotide sequence"
          subtitle="FASTA-formatted sequence data."
          class="col-span-9 pad"
        >
          <template sm:#unpaddedBody>
            <div class="divide-y divide-gray-200">
              <DescriptionToggle
                v-model="sequenceDisplayOptions.rc"
                title="Reverse complement"
                subtitle="Display the reverse complement of the sequence"
                class="px-4 py-5 sm:p-6"
              ></DescriptionToggle>
              <DescriptionToggle
                v-model="sequenceDisplayOptions.dbn"
                title="Secondary structure"
                subtitle="Include the secondary structure of the sequence in dot-bracket notation"
                class="px-4 py-5 sm:p-6"
                :checked="false"
              ></DescriptionToggle>
              <DescriptionToggle
                v-model="sequenceDisplayOptions.rna"
                title="RNA"
                subtitle="Display RNA bases instead of DNA (i.e. U instead of T)"
                class="px-4 py-5 sm:p-6"
              ></DescriptionToggle>

              <pre
                v-if="sequence.length > 0"
                class="
                  text-sm
                  overflow-x-auto
                  px-4
                  py-5
                  sm:p-6
                  flex flex-row-reverse
                  justify-between
                "
              >
                
                <div class="flex flex-col justify-start">
                  <button
                            type="button"
                            class="
                              inline-flex
                              items-center
                              px-2
                              py-2
                              border border-gray-300
                              rounded-md
                              shadow-sm
                              text-sm
                              font-medium
                              w-auto
                              text-gray-700
                              bg-white
                              hover:bg-gray-50
                              focus:outline-none
                            "
                            :class="{'border-indigo-600': copied, 'border-3': copied}"
                            @click="copyFasta"
                          >
                            <svg v-if="!copied" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
</svg>
<svg v-if="copied" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
</svg>
                          </button>
                  
                          <button
                            type="button"
                            class="
                              inline-flex
                              items-center
                              px-2
                              py-2
                              mt-2
                              border border-gray-300
                              rounded-md
                              shadow-sm
                              text-sm
                              font-medium
                              w-auto
                              text-gray-700
                              bg-white
                              hover:bg-gray-50
                              focus:outline-none
                            "
                            @click="download"
                          >
                           <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
</svg>
                          </button>
                </div>
                <div>{{ fasta }}</div></pre>
            </div>
          </template>
        </Card>
        <div class="col-span-3 pad">
          <Card title="Links" subtitle="External resources for this sequence"
            ><template sm:#unpaddedBody>
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
        <div class="col-span-12 pad">
          <Card
            title="Ribozymes"
            subtitle="Infernal search results for known ribozymes"
          >
            <pre class="text-sm text-gray-900 overflow-scroll h-96"
              >{{ sequenceMetadata.ribozymes }}
            </pre>
            <template
              v-if="sequenceMetadata.family === 'Pospiviroidae'"
              #footer
            >
              <p class="text-sm text-gray-500">
                Members of <i>Pospiviroidae</i> are not expected to contain
                ribozymes.
              </p></template
            >
          </Card>
        </div>
        <div class="col-span-6 pad">
          <Card title="Secondary structure (+)">
            <template sm:#unpaddedBody>
              <DataRow title="MFE (25 ºC)">{{
                sequenceMetadata.structure.plus.mfe
              }}</DataRow>
              <DataRow title="Bases paired"
                >{{
                  Number(
                    sequenceMetadata.structure.plus.basesPaired * 100
                  ).toFixed(1)
                }}%</DataRow
              >
              <div
                id="fornac_plus"
                class="h-96"
                :class="{
                  'bg-gray-200 animate animate-pulse': $fetchState.pending,
                }"
              ></div>
            </template>
          </Card>
        </div>
        <div class="col-span-6 pad">
          <Card title="Secondary structure (-)">
            <template sm:#unpaddedBody>
              <DataRow title="MFE (25 ºC)">{{
                sequenceMetadata.structure.minus.mfe
              }}</DataRow>
              <DataRow title="Bases paired"
                >{{
                  Number(
                    sequenceMetadata.structure.minus.basesPaired * 100
                  ).toFixed(1)
                }}%</DataRow
              >
              <div
                id="fornac_minus"
                class="h-96"
                :class="{
                  'bg-gray-200 animate animate-pulse': $fetchState.pending,
                }"
              ></div>
            </template>
          </Card>
        </div>
        <div class="col-span-4 pad">
          <Card title="Legend">
            <template sm:#unpaddedBody>
              <DataRow title="green">
                <div class="text-green-400">
                  Stems (canonical helices)
                </div>
                <!-- #90ee90 -->
              </DataRow>
              <DataRow title="red">
                <div class="text-red-600">
                  Multiloops (junctions)
                </div>
                <!-- #ff9896 -->
              </DataRow>
              <DataRow title="yellow">
                <div class="text-yellow-200">
                  Interior loops
                </div>
                <!-- #dbdb8d -->
              </DataRow>
              <DataRow title="blue">
                <div class="text-blue-300">
                  Hairpin loops
                </div>
                <!-- #add8e6 -->
              </DataRow>
              <DataRow title="green">
                <div class="text-yellow-500">
                  5' and 3' unpaired region
                </div>
                <!-- #ffa07a -->
              </DataRow>
            </template>
          </Card>
        </div>
        <aside class="col-span-4 pad">
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
// import { IContentDocument } from '@nuxt/content/types/content'
import { parseStringPromise } from 'xml2js'
import { saveAs } from 'file-saver'
import { sequenceMetadata } from 'types/sequenceMetadata'

export default Vue.extend({
  data() {
    return {
      copied: false,
      sequenceInfoFields: [
        { name: 'Accession', key: 'accession' },
        { name: 'Length', key: 'length' },
        { name: 'GC Content', key: 'gc' },
        { name: 'Release Date', key: 'releaseDate' },

        { name: 'Database', key: 'sequenceType' },
        { name: 'Rotationally Identical', key: 'identicalSeqs' },
      ],
      sequenceDisplayOptions: { rc: false, dbn: false, rna: false },
      uid: '',
      sequenceMetadata: {
        identicalSeqs: [],
        accession: 'Loading...',
        submitters: 'Loading...',
        releaseDate: 'Loading...',
        species: 'Loading...',
        genus: 'Loading...',
        family: 'Loading...',
        length: 0,
        sequenceType: 'Loading...',
        geoLocation: 'Loading...',
        host: 'Loading...',
        isolationSource: 'Loading...',
        collectionDate: 'Loading...',
        genBankTitle: 'Loading...',
        displayTitle: 'Loading...',
        gc: 0,
        sequence: 'Loading...',
        structure: {
          plus: {
            dbn: 'Loading...',
            mfe: 0,
            basesPaired: 0,
          },
          minus: {
            dbn: 'Loading...',
            mfe: 0,
            basesPaired: 0,
          },
        },
        type: 'Loading...',
        ribozymes: 'Loading...',
      } as sequenceMetadata,
    }
  },
  async fetch() {
    const snapshot = await this.$fire.firestore
      .collection('sequences')
      .doc(this.$route.params.name)
      .get()
    this.sequenceMetadata = snapshot.data() as sequenceMetadata
    // this.showforna()
    this.uid = await fetch(
      `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=${this.$route.params.name}`
    )
      .then((res) => res.text())
      .then((body) => parseStringPromise(body))
      .then((result) => result.eSearchResult.IdList[0].Id[0])
  },

  computed: {
    sequence(): string {
      return this.sequenceMetadata.sequence
    },
    fasta(): string {
      let dbn = ''
      if (this.sequenceDisplayOptions.dbn) {
        dbn = !this.sequenceDisplayOptions.rc
          ? this.sequenceMetadata.structure.plus.dbn
          : this.sequenceMetadata.structure.minus.dbn
        dbn = (dbn.match(new RegExp('.{1,' + 80 + '}', 'g')) ?? []).join('\n')
      }
      return `>${this.sequenceMetadata.accession} ${
        'genBankTitle' in this.sequenceMetadata
          ? this.sequenceMetadata.genBankTitle
          : this.sequenceMetadata.displayTitle
      } [ViroidDB]\n${(
        this.displaySequence.match(new RegExp('.{1,' + 80 + '}', 'g')) ?? []
      ) // had to do the null coalesce for typescript
        .join('\n')}\n${dbn}`
    },
    revCompSequence(): string {
      let seq = this.sequence.toUpperCase()
      if (this.sequence === '') {
        return this.sequence
      }
      seq = seq.replaceAll('U', 'T') // force DNA for now
      const rc: { [key: string]: string } = {
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
        .map((x: string) => rc[x])
        .reverse()
        .join('')
      return seq
    },

    displaySequence(): string {
      let seq = this.sequenceDisplayOptions.rc
        ? this.revCompSequence
        : this.sequence.toUpperCase()

      if (!this.sequenceDisplayOptions.rna) {
        seq = seq.replaceAll('U', 'T')
      } else {
        seq = seq.replaceAll('T', 'U')
      }

      return seq
    },

    links(): {
      name: string
      url: string
    }[] {
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

  methods: {
    download(): void {
      saveAs(
        new File([this.fasta], `${this.sequenceMetadata.accession}.fasta`, {
          type: 'text/plain;charset=utf-8',
        })
      )
    },
    async copyFasta() {
      navigator.clipboard.writeText(this.fasta)
      this.copied = true
      setTimeout(() => {
        this.copied = false
      }, 1000)
    },
    showforna() {
      for (const [seq, pol, el] of [
        [
          this.sequence,
          this.sequenceMetadata.structure.plus.dbn,
          '#fornac_plus',
        ],
        [
          this.revCompSequence,
          this.sequenceMetadata.structure.minus.dbn,
          '#fornac_minus',
        ],
      ]) {
        // @ts-ignore
        const container = new fornac.FornaContainer(el, {
          applyForce: false,
        })
        const options = {
          structure: pol,
          sequence: seq,
        }
        container.addRNA(options.structure, options)
        container.setSize()
      }
    },
  },
})
</script>
<style lang="postcss">
.pad {
  @apply lg:my-auto;
  @apply my-4;
}
</style>