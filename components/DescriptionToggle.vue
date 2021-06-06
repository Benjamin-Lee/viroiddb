<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <div class="flex items-center justify-between">
    <span class="flex-grow flex flex-col" id="availability-label">
      <span class="text-sm font-medium text-gray-900">{{ title }}</span>
      <span class="text-sm text-gray-500">{{ subtitle }}</span>
    </span>
    <!-- Enabled: "bg-indigo-600", Not Enabled: "bg-gray-200" -->
    <button
      type="button"
      class="
        relative
        inline-flex
        flex-shrink-0
        h-6
        w-11
        border-2 border-transparent
        rounded-full
        cursor-pointer
        transition-colors
        ease-in-out
        duration-200
        focus:outline-none
        focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
      "
      :class="checked ? 'bg-indigo-600' : 'bg-gray-200'"
      role="switch"
      :aria-checked="checked"
      aria-labelledby="availability-label"
      @click="$emit('change', !checked)"
    >
      <!-- We emit !checked since clicking it should invert the modeled value -->
      <span class="sr-only">Use setting</span>
      <!-- Enabled: "translate-x-5", Not Enabled: "translate-x-0" -->
      <span
        aria-hidden="true"
        class="
          pointer-events-none
          inline-block
          h-5
          w-5
          rounded-full
          bg-white
          shadow
          transform
          ring-0
          transition
          ease-in-out
          duration-200
        "
        :class="checked ? 'translate-x-5' : 'translate-x-0'"
      ></span>
    </button>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  model: {
    prop: 'checked',
    event: 'change',
  },
  props: { checked: Boolean, title: String, subtitle: String },
  inheritAttrs: false,
})
</script>
