<template>
<div>
  <div class="relative">
      <div class="w-full mx-auto sm:px-6 lg:px-8">
        <div class="relative shadow-xl sm:rounded-2xl sm:overflow-hidden">
          <div class="absolute inset-0">
            <div class="absolute inset-0 bg-gradient-to-r from-purple-800 to-indigo-700 mix-blend-multiply"></div>
          </div>
          <div class="relative px-4 py-16 sm:px-6 sm:py-24 lg:py-32 lg:px-8">
            <h1 class="text-center text-4xl font-extrabold tracking-tight sm:text-5xl lg:text-6xl flex justify-center">
              <span class="block text-white">Viroid</span>
              <span class="block text-indigo-200">DB</span>
            </h1>
            <p class="mt-6 max-w-lg mx-auto text-center text-xl text-indigo-200 sm:max-w-3xl">
              This database contains all known viroid and viroid-like RNA sequences.
            </p>
            <div class="mt-10 max-w-sm mx-auto sm:max-w-none sm:flex sm:justify-center">
                <nuxt-link to="/" class="flex items-center justify-center px-4 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-indigo-700 bg-white hover:bg-indigo-50 sm:px-8">
                  Get started
                </nuxt-link>
              
            </div>
          </div>
        </div>
      </div>




<div class="my-10 bg-gray-50">
    <div class="relative">
      <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto">
          <dl class="rounded-lg bg-white shadow-lg sm:grid sm:grid-cols-3">
            <div class="flex flex-col border-b border-gray-100 p-6 text-center sm:border-0 sm:border-r">
              <dt class="order-2 mt-2 text-lg leading-6 font-medium text-gray-500">
                Entries
              </dt>
              <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                9,486
              </dd>
            </div>
            <div class="flex flex-col border-t border-b border-gray-100 p-6 text-center sm:border-0 sm:border-l sm:border-r">
              <dt class="order-2 mt-2 text-lg leading-6 font-medium text-gray-500">
                Stat
              </dt>
              <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                Stat
              </dd>
            </div>
            <div class="flex flex-col border-t border-gray-100 p-6 text-center sm:border-0 sm:border-l">
              <dt class="order-2 mt-2 text-lg leading-6 font-medium text-gray-500">
                Stat
              </dt>
              <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                Stat
              </dd>
            </div>
          </dl>
        </div>
      </div>
    </div>
  </div>
</div>




      <div>
      <div class="w-full mx-auto pt-16 px-4 sm:px-6 lg:px-8">
        <p class="text-center text-sm font-semibold uppercase text-gray-500 tracking-wide">
          Brought To You By
        </p>
          <div class="grid grid-cols-2 mt-10">
              <div class="col-span-1">
                <img class="w-auto" src="/tel_aviv_logo.png" alt="Tuple">
              </div>
              <div class="col-span-1">
                <img class="w-auto" src="/NCBI-logo.png" alt="Tuple">
              </div>
          </div>
       
      </div>
    </div>
    </div>
</template>

<script>
export default {

}
</script>

<style>

</style>