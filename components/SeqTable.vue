<template>
  <LinkTable
    :columns="[
      { name: 'Name', key: 'displayTitle' },
      { name: 'Accession', key: 'accession' },
      { name: 'Bases', key: 'length' },
      { name: 'Type', key: 'type', class: 'capitalize' },
      { name: 'Family', key: 'family', class: 'italic' },
      { name: 'Genus', key: 'genus', class: 'italic' },
    ]"
    :metadata="displayMetadata"
  ></LinkTable>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    metadata: { type: Array, required: true },
    columns: { type: Array, required: true },
  },
  computed: {
    displayMetadata() {
      return this.metadata
        .filter(
          // @ts-ignore
          (k) => typeof k.displayTitle !== 'undefined'
        )
        .map((x) => ({ ...x, to: '/sequences/' + x.accession }))
    },
  },
})
</script>
