<template>
  <Card title="Alignment" subtitle="Built with MAFFT, Cyclope, and CSA">
    <div class="flex">
      <pre v-if="!$fetchState.pending" class="max-h-96 overflow-auto text-sm"
        >{{ msa }}
      </pre>
      <div v-else class="space-y-4 w-11/12 h-96 animate-pulse">
        <div v-for="i in Array(6).keys()" :key="i" class="space-y-4">
          <div class="h-4 w-1/4 bg-gray-300 rounded"></div>
          <div class="h-4 w-full bg-gray-300 rounded"></div>
        </div>
      </div>
      <div class="pl-5 sm:pl-6 flex flex-col items-center">
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
            h-12
            w-12
            text-gray-500
            bg-white
            hover:bg-gray-50
            focus:outline-none
          "
          title="Copy MSA"
          :class="{ 'border-indigo-600': copied, 'border-3': copied }"
          @click="copyMSA"
        >
          <svg
            v-if="!copied"
            xmlns="http://www.w3.org/2000/svg"
            class="h-8 w-8"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
            />
          </svg>
          <svg
            v-if="copied"
            xmlns="http://www.w3.org/2000/svg"
            class="h-8 w-8"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"
            />
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
            h-12
            w-12
            text-gray-500
            bg-white
            hover:bg-gray-50
            focus:outline-none
          "
          title="Download MSA"
          @click="download"
        >
          <svg
            class="h-8 w-8"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
            />
          </svg>
        </button>
      </div>
    </div>
  </Card>
</template>
<script lang="ts">
import Vue from 'vue'
import { saveAs } from 'file-saver'
export default Vue.extend({
  props: {
    clusterId: { type: String, required: true },
  },
  data: () => {
    return {
      msa: '',
      copied: false,
    }
  },
  async fetch() {
    const msaUrl = await this.$fire.storage.ref(this.path).getDownloadURL()
    await fetch(msaUrl)
      .then((response) => response.text())
      .then((x) => (this.msa = x))
  },
  computed: {
    path(): string {
      const temp = `Cls_${this.clusterId.slice(
        11
      )}_conp_mafft_msa.fasta`.replace('-', '_')
      return `msa/${this.clusterId.slice(0, 10)}/ID${this.clusterId.slice(
        13,
        15
      )}/${temp}`
    },
  },
  // fetchDelay: 500,
  methods: {
    async copyMSA() {
      await navigator.clipboard.writeText(this.msa)
      this.copied = true
      await new Promise((resolve) => setTimeout(resolve, 1000))
      this.copied = false
    },
    download(): void {
      saveAs(
        new File([this.msa], `${this.clusterId}.fasta`, {
          type: 'text/plain;charset=utf-8',
        })
      )
    },
  },
})
</script>
