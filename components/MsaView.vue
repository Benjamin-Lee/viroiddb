<template>
  <div>
    Cls_ID70_161_conp_mafft_msa.fasta
    <pre>{{ url }}</pre>
    <pre>{{ msa }}</pre>
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
