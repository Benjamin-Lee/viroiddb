<template>
  <NuxtLink
    :to="path"
    tag="li"
    class="col-span-1 flex shadow-sm rounded-md group hover:cursor-pointer"
  >
    <div
      :class="[
        'bg-' + color,
        'flex-shrink-0 flex items-center justify-center w-16 text-white text-sm font-medium rounded-l-md',
      ]"
    >
      {{ initials }}
    </div>
    <div
      class="
        flex-1 flex
        items-center
        justify-between
        border-t border-r border-b border-gray-200
        bg-white
        rounded-r-md
        truncate
        group-hover:bg-gray-50
      "
    >
      <div class="flex-1 px-4 py-2 text-sm truncate">
        <NuxtLink :to="path">{{ name }}</NuxtLink>
        <p class="text-gray-500">
          {{ Number(members).toLocaleString() }} Members
        </p>
      </div>
    </div>
  </NuxtLink>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    name: String,
    path: String,
    members: Number,
    initials: String,
    color: String,
  },
})
</script>
