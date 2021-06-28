<template>
  <ais-instant-search
    :search-client="searchClient"
    index-name="viroiddb"
    class="flex flex-col"
  >
    <ais-search-box class="mb-1">
      <div slot-scope="{ currentRefinement, isSearchStalled, refine }">
        <input
          class="
            w-full
            py-2
            border-b-4 border-indigo-600
            bg-gray-50
            text-4xl
            pl-0
            rounded-none
            focus:outline-none
          "
          placeholder="Search..."
          :value="currentRefinement"
          @input="refine($event.currentTarget.value)"
        />
        <span :hidden="!isSearchStalled">Loading...</span>
      </div>
    </ais-search-box>

    <ais-stats>
      <p slot-scope="{ nbHits }" class="text-indigo-600">
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
        <ais-refinement-list attribute="family" class="italic" />
      </div>
      <div class="my-4">
        <p class="text-indigo-600 text-xl">Genus</p>
        <ais-refinement-list attribute="genus" class="italic" />
      </div>
      <div class="my-4">
        <p class="text-indigo-600 text-xl">Species</p>
        <ais-refinement-list attribute="species" class="italic" />
      </div>
    </div>
    <ais-infinite-hits>
      <template slot="item" slot-scope="{ item }">
        <nuxt-link :to="`/sequences/${item.accession}`">
          <p class="text-gray-900 mx-1 hover:text-indigo-600 text-lg">
            <ais-highlight attribute="displayTitle" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <span class="not-italic">type:</span>
            <ais-highlight attribute="type" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1 italic">
            <span class="not-italic">family:</span>
            <ais-highlight attribute="family" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1 italic">
            <span class="not-italic">genus:</span>
            <ais-highlight attribute="genus" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1 italic">
            <span class="not-italic">species:</span>
            <ais-highlight attribute="species" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <ais-highlight attribute="accession" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <ais-highlight attribute="geoLocation" :hit="item" />
          </p>
          <p class="text-gray-500 mx-1">
            <ais-highlight attribute="submitters" :hit="item" />
          </p>
        </nuxt-link>
      </template>
    </ais-infinite-hits>
  </ais-instant-search>
</template>
<script>
import {
  AisInstantSearch,
  AisRefinementList,
  AisInfiniteHits,
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
    AisInfiniteHits,
    AisHighlight,
    AisSearchBox,
    AisStats,
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

<style lang="postcss">
.ais-RefinementList-count {
  @apply not-italic;
}
.ais-RefinementList-labelText {
  @apply pr-1;
}
</style>
