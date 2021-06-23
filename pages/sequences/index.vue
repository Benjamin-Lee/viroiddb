<template>
  <div>
    <TheHeader></TheHeader>
    <div class="prose mt-5">
      <p>
        Lorem ipsum dolor, sit amet consectetur adipisicing elit. Similique
        explicabo at consectetur, molestiae quaerat expedita impedit eos in
        libero hic! Vel excepturi fuga amet, placeat repudiandae deserunt
        aliquam natus eum!
      </p>
    </div>
    <div class="mt-5 mb-8">
      <!-- This example requires Tailwind CSS v2.0+ -->
      <div>
        <h2 class="text-gray-500 text-xs font-medium uppercase tracking-wide">
          Groups
        </h2>
        <ul
          class="
            mt-3
            grid grid-cols-1
            gap-5
            sm:gap-6 sm:grid-cols-2
            lg:grid-cols-4
          "
        >
          <CategoryCard
            v-for="group in groups"
            v-bind:key="group.name"
            :name="group.name"
            :initials="group.initials"
            :members="group.members"
            :bgColor="group.bgColor"
            :href="group.href"
          />
        </ul>
      </div>
    </div>
    <div class="max-w-lg w-full lg:max-w-xs">
      <label for="search" class="sr-only">Search</label>
      <div class="relative">
        <div
          class="
            absolute
            inset-y-0
            left-0
            pl-3
            flex
            items-center
            pointer-events-none
          "
        >
          <!-- Heroicon name: solid/search -->
          <svg
            class="h-5 w-5 text-gray-400"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
            fill="currentColor"
            aria-hidden="true"
          >
            <path
              fill-rule="evenodd"
              d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
              clip-rule="evenodd"
            />
          </svg>
        </div>
        <input
          id="search"
          name="search"
          class="
            block
            w-full
            pl-10
            pr-3
            py-2
            border border-gray-300
            rounded-md
            leading-5
            bg-white
            placeholder-gray-500
            focus:outline-none
            focus:placeholder-gray-400
            focus:ring-1
            focus:ring-indigo-500
            focus:border-indigo-500
            sm:text-sm
          "
          placeholder="Search"
          type="search"
          v-model.lazy="query"
          @input="maxDisplay = 100"
        />
      </div>
    </div>
    <div class="flex flex-col">
      <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
          <div
            class="
              shadow
              overflow-hidden
              border-b border-gray-200
              sm:rounded-lg
            "
          >
            <LinkTable :sequence-metadata="displayMetadata"></LinkTable>
          </div>
        </div>
      </div>
    </div>
    <div v-if="!$fetchState.pending" class="flex justify-center mt-6">
      <button
        @click="
          maxDisplay += 50
          $fetch()
        "
        type="button"
        class="
          inline-flex
          items-center
          px-4
          py-2
          border border-transparent
          text-sm
          font-medium
          rounded-md
          text-indigo-700
          bg-indigo-100
          hover:bg-indigo-200
          focus:outline-none
          focus:ring-2
          focus:ring-offset-2
          focus:ring-indigo-500
        "
      >
        Load more
      </button>
    </div>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
// import Fuse from 'fuse.js'
import { sequenceMetadata } from 'types/sequenceMetadata'

export default Vue.extend({
  data() {
    return {
      maxDisplay: 50,
      groups: [
        {
          name: 'Viroids',
          bgColor: 'bg-red-600',
          initials: 'Vd',
          members: 9264,
        },
        {
          name: 'Satellite RNAs',
          bgColor: 'bg-blue-600',
          initials: 'satRNA',
          members: 10,
        },
        {
          name: 'Ribozyviruses',
          bgColor: 'bg-green-600',
          initials: 'Rzv',
          members: 21,
        },
        {
          name: 'Retrozymes',
          bgColor: 'bg-yellow-600',
          initials: 'Rtz',
          members: 74,
        },
      ],
      query: '',
      metadata: [] as sequenceMetadata[],
    }
  },
  async fetch() {
    const snapshot = await this.$fire.firestore
      .collection('sequences')
      .orderBy('accession')
      .limit(this.maxDisplay)
      .get()
    this.metadata = snapshot.docs.map((doc) => doc.data()) as sequenceMetadata[]
  },
  computed: {
    // ...mapState(['metadata']),

    // fuse(): Fuse<{ [key: string]: { [key: string]: string } }> {
    //   return new Fuse(Object.values(this.metadata), {
    //     includeScore: true,
    //     useExtendedSearch: true,

    //     keys: ['displayTitle', 'accession'],
    //   })
    // },
    displayMetadata(): sequenceMetadata[] {
      // if (this.query.length > 0) {
      //   const searchResults = this.fuse.search(this.query) as Array<{
      //     item: {}
      //   }>
      //   return searchResults.map((x) => x.item)
      // }
      return Object.values(this.metadata)
    },
  },
  // mounted(): void {
  //   this.scroll()
  // },
  // when leaving the page, don't track scroll location
  // eslint-disable-next-line vue/order-in-components
  // beforeRouteLeave(_to, _from, next): void {
  //   window.onscroll = () => {}
  //   next()
  // },
  // methods: {
  //   scroll(): void {
  //     window.onscroll = () => {
  //       if (
  //         Math.max(
  //           window.pageYOffset,
  //           document.documentElement.scrollTop,
  //           document.body.scrollTop
  //         ) +
  //           window.innerHeight ===
  //         document.documentElement.offsetHeight
  //       ) {
  //         this.maxDisplay += 100
  //       }
  //     }
  //   },
  // },
})
</script>
