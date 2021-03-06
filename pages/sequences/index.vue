<template>
  <div>
    <TheHeader></TheHeader>
    <div class="prose max-w-[72ch] mt-5">
      <p>
        Viroids, satellite RNAs, retrozymes, and deltaviruses are unique in
        their structure, replication mechanism, and evolutionary history. Their
        genomes are small (&lt;2000 bases) and highly structured. To view and
        learn more about sequences of one specific type, click below.
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
            lg:grid-cols-5
          "
        >
          <CategoryCard
            v-for="group in groups"
            :key="group.name"
            :name="group.name"
            :path="group.path"
            :initials="group.initials"
            :members="group.members"
            color="bg-indigo-500"
          />
        </ul>
      </div>
    </div>
    <SeqTable :metadata="displayMetadata"></SeqTable>
    <div v-if="!$fetchState.pending" class="flex justify-center mt-6">
      <LoadMore
        @click="
          maxDisplay += 50
          $fetch()
        "
      >
      </LoadMore>
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
          path: '/sequences/type/viroid',
          color: 'bg-red-600',
          initials: 'Vd',
          members: 9353,
        },
        {
          name: 'Satellite RNAs',
          path: '/sequences/type/satellite-RNA',
          color: 'bg-blue-600',
          initials: 'satRNA',
          members: 10,
        },
        {
          name: 'Viruses',
          path: '/sequences/type/virus',
          color: 'bg-green-600',
          initials: 'RzV',
          members: 243,
        },
        {
          name: 'Retrozymes',
          path: '/sequences/type/retrozyme',
          color: 'bg-yellow-600',
          initials: 'Rtz',
          members: 73,
        },
        {
          name: 'Retroviroids',
          path: '/sequences/type/retroviroid',
          color: 'bg-orange-600',
          initials: 'RtVd',
          members: 12,
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
