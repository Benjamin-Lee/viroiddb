<template>
  <div>
    <TheHeader
      ><span class="capitalize">{{
        $route.params.group.replaceAll('-', ' ') +
        ($route.params.group.slice(-1) === 's' ? 'es' : 's')
      }}</span></TheHeader
    >
    <nuxt-content :document="page" class="prose mt-5 mb-8" />
    <SeqTable :metadata="metadata"></SeqTable>
    <div
      v-if="!$fetchState.pending && metadata.length === maxDisplay"
      class="flex justify-center mt-6"
    >
      <LoadMore
        @click="
          maxDisplay += 50
          $fetch()
        "
      >
      </LoadMore>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
import { sequenceMetadata } from '@/types/sequenceMetadata'
export default Vue.extend({
  async asyncData({ $content, params }) {
    const page = await $content('types/' + params.group).fetch()
    return {
      page,
    }
  },
  data() {
    return { metadata: [] as sequenceMetadata[], maxDisplay: 50 }
  },
  async fetch() {
    const snapshot = await this.$fire.firestore
      .collection('sequences')
      .where('type', '==', this.$route.params.group.replaceAll('-', ' '))
      .orderBy('accession')
      .limit(this.maxDisplay)
      .get()
    this.metadata = snapshot.docs.map((doc) => doc.data()) as sequenceMetadata[]
  },
})
</script>
