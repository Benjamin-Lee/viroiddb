<template>
  <div>
    <Card title="MSA">
      <pre class="overflow-scroll max-h-96">{{ msa }}</pre>
    </Card>
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
    const msaUrl = await this.$fire.storage.ref(this.path).getDownloadURL()
    await fetch(msaUrl)
      .then((response) => response.text())
      .then((x) => (this.msa = x))
  },
  computed: {
    path(): string {
      const temp = `Cls_${this.clusterId.slice(11)}_conp_mafft_msa.fasta`.replace(
        '-',
        '_'
      )
      return `msa/${this.clusterId.slice(0, 10)}/ID${this.clusterId.slice(13,15)}/${temp}`
    },
  },
})
</script>
