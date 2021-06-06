<template>
  <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
    <dt class="text-sm font-medium text-gray-500">
      {{ title }}
    </dt>
    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
      <slot></slot>
    </dd>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: { title: String },
})
</script>
