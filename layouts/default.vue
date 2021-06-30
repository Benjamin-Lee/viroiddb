<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <div class="bg-gray-50">
    <div class="flex flex-col h-screen justify-between">
      <div>
        <nav class="bg-white border-b border-gray-200">
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
              <div class="flex">
                <div class="flex-shrink-0 flex items-center">
                  <NuxtLink to="/" class="logo">
                    <img
                      class="block lg:hidden h-8 w-auto"
                      src="/viroiddb.png"
                      alt="ViroidDB"
                    />
                    <img
                      class="hidden lg:block h-8 w-auto"
                      src="/viroiddb.png"
                      alt="ViroidDB"
                    />
                  </NuxtLink>
                  <NuxtLink
                    to="/"
                    class="
                      ml-4
                      font-bold
                      text-xl
                      tracking-wide
                      text-gray-900
                      logo
                    "
                    >ViroidDB</NuxtLink
                  >
                </div>
                <div class="hidden sm:-my-px sm:ml-6 sm:flex sm:space-x-8">
                  <!-- Current: "border-indigo-500 text-gray-900", Default: "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700" -->
                  <NuxtLink
                    v-for="link in links"
                    :key="link.name"
                    :to="link.to"
                    class="
                      border-transparent
                      text-gray-500
                      hover:border-gray-300 hover:text-gray-700
                      inline-flex
                      items-center
                      px-1
                      pt-1
                      border-b-2
                      text-sm
                      font-medium
                    "
                    aria-current="page"
                  >
                    {{ link.name }}
                  </NuxtLink>
                </div>
              </div>

              <div class="-mr-2 flex items-center sm:hidden">
                <!-- Mobile menu button -->
                <button
                  type="button"
                  class="
                    bg-white
                    inline-flex
                    items-center
                    justify-center
                    p-2
                    rounded-md
                    text-gray-400
                    hover:text-gray-500 hover:bg-gray-100
                    focus:outline-none
                    focus:ring-2
                    focus:ring-offset-2
                    focus:ring-indigo-500
                  "
                  @click="showMenu = !showMenu"
                  aria-controls="mobile-menu"
                  aria-expanded="false"
                >
                  <span class="sr-only">Open main menu</span>
                  <!--
              Heroicon name: outline/menu

              Menu open: "hidden", Menu closed: "block"
            -->
                  <svg
                    :class="{ hidden: showMenu, block: !showMenu }"
                    class="block h-6 w-6"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M4 6h16M4 12h16M4 18h16"
                    />
                  </svg>
                  <!--
              Heroicon name: outline/x

              Menu open: "block", Menu closed: "hidden"
            -->
                  <svg
                    :class="{ hidden: !showMenu, block: showMenu }"
                    class="h-6 w-6"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M6 18L18 6M6 6l12 12"
                    />
                  </svg>
                </button>
              </div>
            </div>
          </div>

          <!-- Mobile menu, show/hide based on menu state. -->
          <div class="sm:hidden" id="mobile-menu" v-if="showMenu">
            <div class="pt-2 pb-3 space-y-1">
              <!-- Current: "bg-indigo-50 border-indigo-500 text-indigo-700", Default: "border-transparent text-gray-600 hover:bg-gray-50 hover:border-gray-300 hover:text-gray-800" -->
              <NuxtLink
                v-for="link in links"
                :key="link.name"
                :to="link.to"
                class="
                  border-transparent
                  text-gray-600
                  hover:bg-gray-50 hover:border-gray-300 hover:text-gray-800
                  block
                  pl-3
                  pr-4
                  py-2
                  border-l-4
                  text-base
                  font-medium
                "
                aria-current="page"
              >
                {{ link.name }}
              </NuxtLink>
            </div>
          </div>
        </nav>

        <div class="py-10 mx-2 sm:mx-auto bg-gray-50">
          <main>
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
              <Nuxt />
            </div>
          </main>
        </div>
      </div>
      <!-- This example requires Tailwind CSS v2.0+ -->
      <footer class="bg-gray-50">
        <div
          class="max-w-7xl mx-auto pb-12 px-4 overflow-hidden sm:px-6 lg:px-8"
        >
          <p class="text-center text-base text-gray-400">
            &copy; {{ new Date().getFullYear() }}. All rights reserved.
          </p>
        </div>
      </footer>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  data() {
    return {
      links: [
        { name: 'About', to: '/about' },
        { name: 'Sequences', to: '/sequences' },
        { name: 'Clusters', to: '/clusters' },
        { name: 'Search', to: '/search' },
        { name: 'Download', to: '/download' },
        { name: 'Submit', to: '/submit' },
      ],
      showMenu: false,
    }
  },
  watch: {
    $route() {
      this.showMenu = false
    },
  },
})
</script>
<style lang="postcss">
.nuxt-link-active:not(.logo) {
  @apply bg-indigo-50 border-indigo-500 text-indigo-700 sm:bg-white sm:border-indigo-500 sm:hover:border-indigo-500 sm:text-gray-900 sm:hover:text-gray-900;
}
</style>
