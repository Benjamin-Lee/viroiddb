<template>
  <!-- /Derived from https://tailwindui.com/components/application-ui/layout/panels#component-86cba6bd01f8053d3a7f0d071121c1ee -->
  <div
    class="bg-white overflow-hidden shadow rounded-lg divide-y divide-gray-200"
  >
    <div v-if="title.length > 0" class="px-4 py-5 sm:px-6">
      <!-- Content goes here -->
      <!-- We use less vertical padding on card headers on desktop than on body sections -->
      <slot name="header">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          {{ title }}
        </h3>
        <p v-if="subtitle.length > 0" class="mt-1 text-sm text-gray-500">
          {{ subtitle }}
        </p>
      </slot>
    </div>
    <div v-if="$slots.default" class="px-4 py-5 sm:p-6">
      <!-- Content goes here -->
      <slot></slot>
    </div>
    <slot name="unpaddedBody"></slot>
    <div v-if="$slots.footer" class="px-4 py-4 sm:px-6">
      <!-- Content goes here -->
      <!-- We use less vertical padding on card footers at all sizes than on headers or body sections -->
      <slot name="footer"></slot>
    </div>
    <slot v-if="title == 'Secondary structure (-)'" name="unpaddedFooter">
      <!-- <DataRow title="green">
                <div class="text-green-400">
                  Stems (canonical helices)
                </div>
                
              </DataRow> -->
      <!--Card title="Legend">
            <template sm:#unpaddedBody>
              <DataRow title="green">
                <div class="text-green-400">
                  Stems (canonical helices)
                </div>
                
              </DataRow>
              <DataRow title="red">
                <div class="text-red-600">
                  Multiloops (junctions)
                </div>
                
              </DataRow>
              <DataRow title="yellow">
                <div class="text-yellow-200">
                  Interior loops
                </div>
                
              </DataRow>
              <DataRow title="blue">
                <div class="text-blue-300">
                  Hairpin loops
                </div>
                
              </DataRow>
              <DataRow title="green">
                <div class="text-yellow-500">
                  5' and 3' unpaired region
                </div>
                
              </DataRow>
            </template>
          </Card-->
    </slot> 
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    title: { default: '', type: String },
    subtitle: { default: '', type: String },
  },
})
</script>
