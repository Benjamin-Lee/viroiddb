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
            text-3xl
            font-medium
            pl-0
            rounded-none
            placeholder-gray-500
            text-gray-900
            focus:outline-none
          "
          autofocus
          placeholder="Search..."
          :value="currentRefinement"
          @input="refine($event.currentTarget.value)"
        />
        <span :hidden="!isSearchStalled">Loading...</span>
      </div>
    </ais-search-box>

    <ais-stats>
      <p
        slot-scope="{ nbHits, processingTimeMS }"
        class="text-gray-500 font-medium text-sm mt-1"
      >
        {{ Number(nbHits).toLocaleString() }} results ({{ processingTimeMS }}
        ms)
      </p>
    </ais-stats>

    <div class="lg:flex lg:justify-between mb-4">
      <div class="my-4">
        <p
          class="
            text-gray-500
            mb-1
            text-sm
            font-medium
            uppercase
            tracking-wider
          "
        >
          Type
        </p>
        <ais-refinement-list class="capitalize" attribute="type" />
      </div>
      <div class="my-4">
        <p
          class="
            text-gray-500
            mb-1
            text-sm
            font-medium
            uppercase
            tracking-wider
          "
        >
          Family
        </p>
        <ais-refinement-list attribute="family" class="italic" />
      </div>
      <div class="my-4">
        <p
          class="
            text-gray-500
            mb-1
            text-sm
            font-medium
            uppercase
            tracking-wider
          "
        >
          Genus
        </p>
        <ais-refinement-list attribute="genus" class="italic" />
      </div>
      <div class="my-4">
        <p
          class="
            text-gray-500
            mb-1
            text-sm
            font-medium
            uppercase
            tracking-wider
          "
        >
          Species
        </p>
        <ais-refinement-list
          class="mt-2 italic"
          searchable
          searchable-placeholder="Search..."
          attribute="species"
        />
      </div>
    </div>
    <ais-infinite-hits class="mx-1">
      <template slot="item" slot-scope="{ item }">
        <nuxt-link :to="`/sequences/${item.accession}`">
          <p class="text-gray-900 hover:text-indigo-600 text-lg font-medium">
            <ais-highlight attribute="accession" :hit="item" />
            <ais-highlight attribute="displayTitle" :hit="item" />
          </p>
          <p class="text-gray-900">
            <!-- <span class="text-gray-500 w-10 mr-5">Taxonomy</span> -->
            <ais-highlight attribute="type" :hit="item" class="capitalize" />
            <template v-if="item.family">
              &#8250;
              <ais-highlight attribute="family" :hit="item" class="italic" />
            </template>
            <template v-if="item.genus">
              &#8250;
              <ais-highlight attribute="genus" :hit="item" class="italic" />
            </template>
            <template v-if="item.species">
              &#8250;
              <ais-highlight attribute="species" :hit="item" class="italic" />
            </template>
          </p>
          <p class="text-gray-900">
            <ais-highlight attribute="geoLocation" :hit="item" />
            <span v-if="item.geoLocation && item.host">&#8250;</span>
            <ais-highlight attribute="host" :hit="item" class="italic" />
            <span v-if="(item.geoLocation || item.host) && item.isolationSource"
              >&#8250;</span
            >
            <ais-highlight attribute="isolationSource" :hit="item" />
          </p>
          <p class="text-gray-900">
            <!-- <span class="text-gray-500">Submitters</span> -->
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
}
</script>

<style lang="postcss">
.ais-RefinementList-count {
  @apply not-italic;
}
.ais-SearchBox-input,
.ais-RefinementList-checkbox {
  @apply shadow-none rounded outline-none  hover:border-gray-400 focus:border-gray-400 border-gray-400 focus:ring-1 focus:ring-indigo-600 focus:ring-offset-2  placeholder-gray-600;
}
.ais-SearchBox-input {
  @apply text-gray-900;
}
.ais-RefinementList-labelText {
  @apply pr-1;
}
.ais-InfiniteHits-item:first-child {
  @apply rounded-t-md !important;
}
.ais-InfiniteHits-item:last-child {
  @apply rounded-b-md !important;
}
.ais-RefinementList-count {
  @apply bg-indigo-50 border-indigo-300 text-indigo-800;
}
</style>
