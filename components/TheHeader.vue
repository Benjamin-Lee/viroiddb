<template>
  <header>
    <h1 class="text-3xl font-bold leading-tight text-gray-900">
      <slot>{{
        $nuxt.$route.name
          .split('-')
          .map((x) => x[0].toUpperCase() + x.slice(1))
          .join(' ')
      }}</slot>
    </h1>
  </header>
</template>
