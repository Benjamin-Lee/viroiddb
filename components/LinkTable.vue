<template>
  <table class="min-w-full divide-y divide-gray-200">
    <thead class="bg-gray-50">
      <tr>
        <th
          scope="col"
          class="
            px-6
            py-3
            text-left text-xs
            font-medium
            text-gray-500
            uppercase
            tracking-wider
          "
        >
          Name
        </th>
        <th
          scope="col"
          class="
            px-6
            py-3
            text-left text-xs
            font-medium
            text-gray-500
            uppercase
            tracking-wider
          "
        >
          Accession
        </th>
        <th
          scope="col"
          class="
            px-6
            py-3
            text-left text-xs
            font-medium
            text-gray-500
            uppercase
            tracking-wider
          "
        >
          Length
        </th>
        <th
          scope="col"
          class="
            px-6
            py-3
            text-left text-xs
            font-medium
            text-gray-500
            uppercase
            tracking-wider
          "
        >
          Type
        </th>
        <th
          scope="col"
          class="
            px-6
            py-3
            text-left text-xs
            font-medium
            text-gray-500
            uppercase
            tracking-wider
          "
        >
          Family
        </th>
        <th scope="col" class="relative px-6 py-3">
          <span class="sr-only">View</span>
        </th>
      </tr>
    </thead>
    <tbody class="bg-white divide-y divide-gray-200">
      <template v-for="(sequence, seqIdx) in displayMetadata">
        <tr
          :key="sequence.accession"
          class="hover:cursor-pointer hover:bg-gray-100"
          :class="seqIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
          @click="$router.push(`/sequences/sequence/${sequence.accession}`)"
        >
          <td
            class="
              px-6
              py-4
              whitespace-nowrap
              text-sm
              font-medium
              text-gray-900
            "
          >
            {{ sequence.displayTitle }}{{ seqIdx }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            <a
              :href="`https://www.ncbi.nlm.nih.gov/nuccore/${sequence.accession}`"
              target="_blank"
              >{{ sequence.accession }}</a
            >
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ sequence.length }} bp
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 capitalize"
          >
            {{ sequence.type }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 italic">
            {{ sequence.family }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
          >
            <NuxtLink
              :to="'/sequences/sequence' + sequence.accession"
              class="text-indigo-600 hover:text-indigo-900"
              >View</NuxtLink
            >
          </td>
        </tr>
      </template>
    </tbody>
  </table>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    sequenceMetadata: { type: Array, required: false, default: () => [] },
  },
  computed: {
    displayMetadata() {
      return this.sequenceMetadata.filter(
        (k) => typeof k.displayTitle !== 'undefined'
      )
    },
  },
})
</script>
