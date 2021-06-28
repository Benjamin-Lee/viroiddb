<template>
  <div>
    <TheHeader></TheHeader>
    <div class="prose mt-5">
      <NuxtContent :document="page" class="prose"> </NuxtContent>
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
        name="identity"
        class="
          my-1
          block
          pl-3
          pr-10
          py-2
          text-base
          border-gray-300
          focus:outline-none focus:ring-indigo-500 focus:border-indigo-500
          sm:text-sm
          rounded-md
        "
      >
        <option selected>90%</option>
        <option>85%</option>
        <option>70%</option>
      </select>
      <p class="text-sm text-gray-500">
        Viroid species demarcation historically used 90% as a cutoff.
      </p>
    </div>

    <LinkTable
      class="mt-5"
      :columns="[
        { name: 'Cluster ID', key: 'clusterid' },
        { name: 'Reference Sequence', key: 'reference' },
        { name: 'Members', key: 'members' },
      ]"
      :metadata="[
        {
          clusterid: 1,
          reference: 'NC_BLAH.1',
          members: 123,
          to: '/clusters/1',
        },
        {
          clusterid: 2,
          reference: 'NC_FOO.1',
          members: 456,
          to: '/clusters/2',
        },
      ]"
    ></LinkTable>
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
})
</script>
