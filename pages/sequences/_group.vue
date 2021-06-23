<template>
  <div>
    <TheHeader
      ><span class="capitalize">{{ $route.params.group }}</span></TheHeader
    >
    <LinkTable :sequence-metadata="metadata"></LinkTable>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
import { sequenceMetadata } from '@/types/sequenceMetadata'
export default Vue.extend({
  data() {
    return { metadata: [] as sequenceMetadata[] }
  },
  async fetch() {
    const snapshot = await this.$fire.firestore
      .collection('sequences')
      .where('type', '==', this.$route.params.group.replaceAll('_', ' '))
      .orderBy('accession')
      .limit(50)
      .get()
    this.metadata = snapshot.docs.map((doc) => doc.data()) as sequenceMetadata[]
  },
})
</script>
