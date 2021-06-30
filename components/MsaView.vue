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
  data: () => {
    return {
      url: '',
      msa: '',
    }
  },
  props: {
    clusterId: { type: String, required: true },
  },
  async fetch() {
    let temp = `Cls_${this.clusterId.slice(11)}_conp_mafft_msa.fasta`
    this.url = temp.replace('-', '_')
    this.msa = await this.$fire.storage.ref(this.url).getDownloadURL()
    fetch(this.msa).then((response) => {
      console.log(response)
    })
  },
})
</script>