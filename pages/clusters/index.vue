<template>
  <div>
    <TheHeader></TheHeader>
    <div class="prose max-w-[72ch] mt-5">
      <NuxtContent :document="page"> </NuxtContent>
    </div>
    <!--
  This example requires Tailwind CSS v2.0+ 
  
  This example requires some changes to your config:
  
  ```
  // tailwind.config.js
  module.exports = {
    // ...
    plugins: [
      // ...
      require('@tailwindcss/forms'),
    ]
  }
  ```
-->
    <div class="mt-8">
      <label for="identity" class="block text-sm font-medium text-gray-700"
        >Identity Threshold</label
      >
      <select
        id="identity"
        v-model.number="identity"
        name="identity"
        class="
          my-1
          block
          pl-3
          pr-10
          py-2
          text-base
          border-gray-300
          focus:outline-none
          focus:ring-indigo-500
          focus:border-indigo-500
          sm:text-sm
          rounded-md
        "
      >
        <option value="90">90%</option>
        <option value="85">85%</option>
        <option value="70">70%</option>
      </select>
      <p class="text-sm text-gray-500">
        Viroid species demarcation historically used 90% as a cutoff.
      </p>
    </div>

    <LinkTable
      class="mt-5"
      :columns="[
        { name: 'Cluster ID', key: 'id' },
        { name: 'Reference Sequence', key: 'representativeDisplayTitle' },
        { name: 'Members', key: 'count' },
      ]"
      :metadata="clusters[identity]"
    ></LinkTable>
    <div v-if="!$fetchState.pending" class="flex justify-center mt-6">
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
export default Vue.extend({
  async asyncData({ $content }) {
    const page = await $content('pages/clusters').fetch()
    return {
      page,
    }
  },
  data() {
    return {
      clusters: { 70: [], 85: [], 90: [] },
      identity: 90,
      maxDisplay: 50,
    }
  },
  async fetch() {
    // @ts-ignore
    this.clusters[this.identity] = (
      await this.$fire.firestore
        .collection('clusters')
        .where('identity', '==', this.identity)
        .limit(this.maxDisplay)
        .get()
    ).docs
      .map((x) => x.data())
      .map(
        (x) => ({ ...x, to: '/clusters/' + x.id } as { to: string; id: string })
      )
      .sort((a, b) =>
        Number(a.id.split('.').pop()) < Number(b.id.split('.').pop()) ? -1 : 1
      )
  },
  watch: {
    async identity(val) {
      // @ts-ignore since it doesn't know identity is a valid key for clusters
      if (this.clusters[val].length === 0) {
        await this.$fetch()
      }
    },
  },
})
</script>
