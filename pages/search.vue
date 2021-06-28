<template>
  <ais-instant-search :search-client="searchClient" index-name="viroiddb" class="flex flex-col">
    <ais-search-box class="mb-1">
      <div slot-scope="{ currentRefinement, isSearchStalled, refine }">
        <input
          class="w-full py-2 border-r-0 border-l-0 border-t-0 border-b-4 border-indigo-600 bg-gray-50 text-4xl pl-0 focus:border-indigo-600"
          placeholder="Search..."
          :value="currentRefinement"
          @input="refine($event.currentTarget.value)"
        />
        <span :hidden="!isSearchStalled">Loading...</span>
      </div>
    </ais-search-box>

    <ais-stats>
      <p
        slot-scope="{
          hitsPerPage,
          nbPages,
          nbHits,
          page,
          processingTimeMS,
          query,
        }"
        class="text-indigo-600"
      >
        {{ nbHits }} <span class="text-gray-900">results</span>
      </p>
    </ais-stats>

    <div class="lg:flex lg:justify-between mb-4">
      <div class="my-4">
        <p class="text-indigo-600 text-xl">Type</p>
        <ais-refinement-list attribute="type" />
      </div>
      <div class="my-4">
        <p class="text-indigo-600 text-xl">Family</p>
        <ais-refinement-list attribute="family" />
      </div>
       <div class="my-4">
        <p class="text-indigo-600 text-xl">Genus</p>
        <ais-refinement-list attribute="genus" />
      </div>
      <div class="my-4">
        <p class="text-indigo-600 text-xl">Species</p>
        <ais-refinement-list attribute="species" />
      </div>
    </div>
    <ais-hits>
      <template slot="item" slot-scope="{ item }" class="rounded-md">
        <nuxt-link :to="`/sequences/${item.accession}`">
          <p class="text-gray-900 mx-1 hover:text-indigo-600 text-lg">
            <ais-highlight attribute="displayTitle" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <ais-highlight attribute="accession" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <ais-highlight attribute="geoLocation" :hit="item" />
          </p>
        </nuxt-link>
      </template>
    </ais-hits>
    <ais-pagination class="mt-4 p-2 self-center" />
  </ais-instant-search>
</template>
<script>
import {
  AisInstantSearch,
  AisRefinementList,
  AisHits,
  AisHighlight,
  AisSearchBox,
  AisStats,
  AisPagination,
  createServerRootMixin,
} from 'vue-instantsearch'
import algoliasearch from 'algoliasearch/lite'

const searchClient = algoliasearch(
  'QFQBVLMH7O',
  '1bc970b7d4c3ccd727fab4c71258ba36'
)

export default {
  components: {
    AisInstantSearch,
    AisRefinementList,
    AisHits,
    AisHighlight,
    AisSearchBox,
    AisStats,
    AisPagination,
  },
  data() {
    return {
      searchClient,
    }
  },
  head() {
    return {
      link: [
        {
          rel: 'stylesheet',
          href: 'https://cdn.jsdelivr.net/npm/instantsearch.css@7.4.5/themes/satellite-min.css',
        },
      ],
    }
  },
}
</script>