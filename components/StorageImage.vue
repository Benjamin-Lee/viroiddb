<template>
  <div>
    <img v-if="!$fetchState.error" :src="url" alt="" class="rounded-md" />
    <div v-else>
      <div class="rounded-md bg-gray-50 p-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <!-- Heroicon name: solid/x-circle -->
            <svg
              class="h-5 w-5 text-gray-400"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              fill="currentColor"
              aria-hidden="true"
            >
              <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                clip-rule="evenodd"
              />
            </svg>
          </div>
          <div class="ml-3">
            <h3 class="text-sm text-gray-800">
              Due an error, we were unable to generate a visualization of the
              cluster.
            </h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: { src: { type: String, required: true } },
  data() {
    return { url: '' }
  },
  async fetch() {
    this.url = await this.$fire.storage.ref(this.src).getDownloadURL()
  },
})
</script>
