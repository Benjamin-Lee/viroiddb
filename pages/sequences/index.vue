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
            sm:gap-6
            sm:grid-cols-2
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
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th
                    scope="col"
                    class="
                      px-6
                      py-3
                      text-left text-xs
                      font-medium
                      text-gray-500
                      uppercase
                      tracking-wider
                    "
                  >
                    Name
                  </th>
                  <th
                    scope="col"
                    class="
                      px-6
                      py-3
                      text-left text-xs
                      font-medium
                      text-gray-500
                      uppercase
                      tracking-wider
                    "
                  >
                    Accession
                  </th>
                  <th
                    scope="col"
                    class="
                      px-6
                      py-3
                      text-left text-xs
                      font-medium
                      text-gray-500
                      uppercase
                      tracking-wider
                    "
                  >
                    Length
                  </th>
                  <th
                    scope="col"
                    class="
                      px-6
                      py-3
                      text-left text-xs
                      font-medium
                      text-gray-500
                      uppercase
                      tracking-wider
                    "
                  >
                    GC Content
                  </th>
                  <th
                    scope="col"
                    class="
                      px-6
                      py-3
                      text-left text-xs
                      font-medium
                      text-gray-500
                      uppercase
                      tracking-wider
                    "
                  >
                    Type
                  </th>
                  <th scope="col" class="relative px-6 py-3">
                    <span class="sr-only">View</span>
                  </th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <template v-for="(sequence, accession, seqIdx) in metadata">
                  <template
                    v-if="seqIdx <= maxDisplay && 'displayTitle' in sequence"
                  >
                    <tr
                      :key="accession"
                      :class="seqIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
                    >
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-sm
                          font-medium
                          text-gray-900
                        "
                      >
                        {{ sequence.displayTitle }}
                      </td>
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-sm text-gray-500
                        "
                      >
                        <a
                          :href="`https://www.ncbi.nlm.nih.gov/nuccore/${sequence.accession}`"
                          target="_blank"
                          >{{ sequence.accession }}</a
                        >
                      </td>
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-sm text-gray-500
                        "
                      >
                        {{ sequence.length }} bp
                      </td>
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-sm text-gray-500
                        "
                      >
                        {{ Number(sequence.gc * 100).toFixed(1) }}%
                      </td>
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-sm text-gray-500
                        "
                      >
                        {{ sequence.family }}
                      </td>
                      <td
                        class="
                          px-6
                          py-4
                          whitespace-nowrap
                          text-right text-sm
                          font-medium
                        "
                      >
                        <NuxtLink
                          :to="'/sequences/' + sequence.accession"
                          class="text-indigo-600 hover:text-indigo-900"
                          >View</NuxtLink
                        >
                      </td>
                    </tr>
                  </template>
                </template>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <p>{{ this.$route.query.group }}</p>
  </div>
</template>
<script lang="ts">
import Vue from 'vue'
import { mapState } from 'vuex'
export default Vue.extend({
  data() {
    return {
      maxDisplay: 100,
      groups: [
        { name: 'Viroids', bgColor: 'bg-red-600', initials: 'Vd', members: 21 },
        {
          name: 'Satellite RNAs',
          bgColor: 'bg-blue-600',
          initials: 'satRNA',
          members: 21,
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
          members: 21,
        },
      ],
    }
  },
  computed: {
    ...mapState(['metadata']),
  },
  mounted() {
    this.scroll()
  },
  // eslint-disable-next-line vue/order-in-components
  // when leaving the page, don't track scroll location
  beforeRouteLeave(_to, _from, next): void {
    window.onscroll = () => {}
    next()
  },
  methods: {
    scroll() {
      window.onscroll = () => {
        if (
          Math.max(
            window.pageYOffset,
            document.documentElement.scrollTop,
            document.body.scrollTop
          ) +
            window.innerHeight ===
          document.documentElement.offsetHeight
        ) {
          this.maxDisplay += 100
        }
      }
    },
  },
})
</script>
