<template>
  <div>
    <TheHeader
      ><span class="capitalize">{{
        $route.params.group +
        ($route.params.group.slice(-1) === 's' ? 'es' : 's')
      }}</span></TheHeader
    >
    <nuxt-content :document="page" class="prose mt-5 mb-8" />
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
  async asyncData({ $content, params }) {
    const page = await $content('types/' + params.group).fetch()
    return {
      page,
    }
  },
})
</script>
