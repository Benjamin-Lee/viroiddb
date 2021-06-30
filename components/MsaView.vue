<template>
  <pre>Hello</pre>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    clusterId: { type: String, required: true },
  },
})
</script>
