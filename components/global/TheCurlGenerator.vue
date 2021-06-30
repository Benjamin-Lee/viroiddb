<template>
  <div>
    <div class="flex mt-6">
      <div class="sm:flex sm:items-center">
        <div class="font-medium sm:mr-2">Subset</div>
        <div class="relative inline-block text-left">
          <div>
            <button
              type="button"
              class="
                inline-flex
                justify-center
                w-full
                rounded-md
                border border-gray-300
                shadow-sm
                px-4
                py-2
                bg-white
                text-sm
                font-medium
                text-gray-700
                hover:bg-gray-50
                focus:outline-none
                focus:ring-2
                focus:ring-offset-2
                focus:ring-offset-gray-100
                focus:ring-indigo-500
              "
              id="menu-button"
              aria-expanded="true"
              aria-haspopup="true"
              @click="showSubsetMenu = !showSubsetMenu"
            >
              {{ subset }}
              <!-- Heroicon name: solid/chevron-down -->
              <svg
                class="-mr-1 ml-2 h-5 w-5"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                aria-hidden="true"
              >
                <path
                  fill-rule="evenodd"
                  d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                  clip-rule="evenodd"
                />
              </svg>
            </button>
          </div>
          <!--
                    Dropdown menu, show/hide based on menu state.
      
                    Entering: "transition ease-out duration-100"
                      From: "transform opacity-0 scale-95"
                      To: "transform opacity-100 scale-100"
                    Leaving: "transition ease-in duration-75"
                      From: "transform opacity-100 scale-100"
                      To: "transform opacity-0 scale-95"
                  -->
          <div
            v-if="showSubsetMenu"
            class="
              origin-top-right
              absolute
              left-0
              mt-2
              w-56
              rounded-md
              shadow-lg
              bg-white
              ring-1 ring-black ring-opacity-5
              focus:outline-none
            "
            role="menu"
            aria-orientation="vertical"
            aria-labelledby="menu-button"
            tabindex="-1"
          >
            <div class="py-1" role="none">
              <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-0"
                @click="
                  subset = 'all'
                  showSubsetMenu = false
                "
              >
                All
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-1"
                @click="
                  subset = 'viroids'
                  showSubsetMenu = false
                "
              >
                Viroids
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'satellites'
                  showSubsetMenu = false
                "
              >
                Satellite RNAs
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'avsunviroidae'
                  showSubsetMenu = false
                "
              >
                <span class="italic">Avsunviroidae</span>
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'pospiviroidae'
                  showSubsetMenu = false
                "
              >
                <span class="italic">Pospiviroidae</span>
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'deltavirus'
                  showSubsetMenu = false
                "
              >
                <span class="italic">Deltavirus</span>
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'retrozymes'
                  showSubsetMenu = false
                "
              >
                <span class="italic">Retrozymes</span>
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  subset = 'unclassified'
                  showSubsetMenu = false
                "
              >
                Unclassified
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="ml-4 sm:flex sm:items-center">
        <div class="font-medium sm:mr-2">Format</div>
        <div class="relative inline-block text-left">
          <div>
            <button
              type="button"
              class="
                inline-flex
                justify-center
                w-full
                rounded-md
                border border-gray-300
                shadow-sm
                px-4
                py-2
                bg-white
                text-sm
                font-medium
                text-gray-700
                hover:bg-gray-50
                focus:outline-none
                focus:ring-2
                focus:ring-offset-2
                focus:ring-offset-gray-100
                focus:ring-indigo-500
              "
              id="menu-button"
              aria-expanded="true"
              aria-haspopup="true"
              @click="showFormatMenu = !showFormatMenu"
            >
              {{ type.toUpperCase() }}
              <!-- Heroicon name: solid/chevron-down -->
              <svg
                class="-mr-1 ml-2 h-5 w-5"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                aria-hidden="true"
              >
                <path
                  fill-rule="evenodd"
                  d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                  clip-rule="evenodd"
                />
              </svg>
            </button>
          </div>
          <!--
                    Dropdown menu, show/hide based on menu state.
      
                    Entering: "transition ease-out duration-100"
                      From: "transform opacity-0 scale-95"
                      To: "transform opacity-100 scale-100"
                    Leaving: "transition ease-in duration-75"
                      From: "transform opacity-100 scale-100"
                      To: "transform opacity-0 scale-95"
                  -->
          <div
            v-if="showFormatMenu"
            class="
              origin-top-right
              absolute
              left-0
              mt-2
              w-56
              rounded-md
              shadow-lg
              bg-white
              ring-1 ring-black ring-opacity-5
              focus:outline-none
            "
            role="menu"
            aria-orientation="vertical"
            aria-labelledby="menu-button"
            tabindex="-1"
          >
            <div class="py-1" role="none">
              <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'fasta'
                  showFormatMenu = false
                "
              >
                FASTA
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'json'
                  showFormatMenu = false
                "
              >
                JSON
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'dbn'
                  showFormatMenu = false
                "
              >
                DBN
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'sql'
                  showFormatMenu = false
                "
              >
                SQL
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'rds'
                  showFormatMenu = false
                "
              >
                RDS
              </button>
              <button
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="menu-item-2"
                @click="
                  type = 'pickle'
                  showFormatMenu = false
                "
              >
                PICKLE
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <pre
      class="
        bg-gray-800
        text-white
        p-4
        mt-4
        rounded
        max-w-7xl
        flex
        justify-between
      "
    ><div><span class="select-none">$ </span>{{ url }}</div> <button
            type="button"
            class="
              inline-flex
              items-center
              border border-gray-300
              rounded-md
              shadow-sm
              text-sm
              font-medium
              w-auto
              text-gray-700
              bg-white
              hover:bg-gray-50
              focus:outline-none
            "
            :class="{ 'border-indigo-600': copied }"
            @click="copyCurl"
          >
            <svg v-if="!copied" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
      </svg>
      <svg v-if="copied" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
      </svg>
          </button></pre>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      showFormatMenu: false,
      showSubsetMenu: false,
      copied: false,
      subset: 'all',
      type: 'fasta',
    }
  },
  computed: {
    url() {
      let url = `curl viroids.org/db/${this.subset}.${this.type} > ${this.subset}.${this.type}`
      return url
    },
  },
  mounted () {
    document.addEventListener('click', this.close)
  },
  beforeDestroy () {
    document.removeEventListener('click',this.close)
  },
  methods: {
    copyCurl() {
      navigator.clipboard.writeText(this.url)
      this.copied = true
      setTimeout(() => {
        this.copied = false
      }, 1000)
    },
    
      close (e) {
      if (!this.$el.contains(e.target)) {
        this.showFormatMenu = false
      this.showSubsetMenu = false
      }
    }
  },
}
</script>

<style></style>
