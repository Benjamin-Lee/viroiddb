<template>
  <div class="flex flex-col">
    <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
      <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
        <div class="shadow overflow-hidden sm:rounded-lg">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-white">
              <tr>
                <th
                  v-for="column in columns"
                  :key="column.name"
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
                  {{ column.name }}
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <template v-for="(row, rowIdx) in metadata">
                <tr
                  :key="rowIdx"
                  class="hover:cursor-pointer hover:bg-gray-50"
                  @click="$router.push(row.to)"
                >
                  <td
                    v-for="(column, columnIdx) in columns"
                    :key="column.key"
                    class="px-6 py-4 whitespace-nowrap text-sm font-medium"
                    :class="[
                      columnIdx === 0 ? 'text-gray-900' : 'text-gray-500',
                      column.class,
                    ]"
                  >
                    <NuxtLink :to="row.to">
                      {{ row[column.key] }}
                    </NuxtLink>
                  </td>
                </tr>
              </template>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    // sequenceMetadata: { type: Array, required: false, default: () => [] },
    columns: { type: Array, required: true },
    metadata: { type: Array, required: true, default: () => [] },
  },
})
</script>
