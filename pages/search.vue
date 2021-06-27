<template>
  <ais-instant-search :search-client="searchClient" index-name="viroiddb">
    <ais-search-box />
    <ais-stats />
    <p>Species</p>
    <ais-refinement-list attribute="species" />
    <p>Genus</p>
    <ais-refinement-list attribute="genus" />
    <p>Family</p>
    <ais-refinement-list attribute="family" />
    <p>Type</p>
    <ais-refinement-list attribute="type" />

    <ais-hits>
      <template slot="item" slot-scope="{ item }">
          <nuxt-link :to="`/sequences/${item.accession}`">
            <p class="text-gray-900 mx-1 hover:text-indigo-600">
              <ais-highlight attribute="displayTitle" :hit="item" />
            </p>
            <p class="text-gray-500 mx-1">
              <ais-highlight attribute="accession" :hit="item" />
            </p>
                    <!-- <p>
            <ais-highlight attribute="geoLocation" :hit="item" />
                    </p> -->
          </nuxt-link>
      </template>
    </ais-hits>
    <ais-pagination />
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
