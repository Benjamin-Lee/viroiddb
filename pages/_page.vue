<template>
  <div class="prose max-w-[75ch]">
    <TheHeader>{{ page.title }}</TheHeader>
    <nuxt-content :document="page" />
  </div>
</template>
<script>
export default {
  async asyncData({ $content, params }) {
    const page = await $content('pages/' + params.page).fetch()

    return {
      page,
    }
  },
}
</script>
<style lang="postcss">
.prose h1 {
  @apply text-3xl font-bold leading-tight text-gray-900;
}
</style>
