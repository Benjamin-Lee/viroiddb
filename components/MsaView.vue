<template>
  <div>
    <Card title="MSA" class="sm:p-6 overflow-scroll h-96"><pre class="overflow-x-auto overflow-y-auto">{{ msa }}</pre></Card>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    clusterId: { type: String, required: true },
  },
  data: () => {
    return {
      msa: '',
    }
  },
  async fetch() {
    const msaUrl = await this.$fire.storage.ref(this.url).getDownloadURL()
    await fetch(msaUrl)
      .then((response) => response.text())
      .then((x) => (this.msa = x))
  },
  computed: {
    url(): string {
      return `Cls_${this.clusterId.slice(11)}_conp_mafft_msa.fasta`.replace(
        '-',
        '_'
      )
    },
  },
})
</script>
