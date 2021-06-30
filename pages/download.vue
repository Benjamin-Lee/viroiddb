<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <div>
    <div class="text-3xl font-bold mb-6">{{ doc.title }}</div>
    <nuxt-content :document="doc" class="prose max-w-[72ch]"></nuxt-content>
  </div>
</template>

<script>
export default {
  async asyncData({ $content, params }) {
    const doc = await $content(params.slug || 'pages/download_').fetch()

    return { doc }
  },
}
</script>
