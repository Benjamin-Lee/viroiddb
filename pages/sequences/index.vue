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
          Types
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
            :key="group.name"
            :name="group.name"
            :path="group.path"
            :initials="group.initials"
            :members="group.members"
            :color="group.color"
          />
        </ul>
      </div>
    </div>
    <LinkTable :sequence-metadata="displayMetadata"></LinkTable>
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
          path: 'sequences/type/viroid',
          color: 'red-600',
          initials: 'Vd',
          members: 9264,
        },
        {
          name: 'Satellite RNAs',
          path: 'sequences/type/satellite-RNA',
          color: 'blue-600',
          initials: 'satRNA',
          members: 10,
        },
        {
          name: 'Viruses',
          path: 'sequences/type/virus',
          color: 'green-600',
          initials: 'Rzv',
          members: 21,
        },
        {
          name: 'Retrozymes',
          path: 'sequences/type/retrozyme',
          color: 'yellow-600',
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
