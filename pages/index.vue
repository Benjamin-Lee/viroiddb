<template>
  <div>
    <!-- The hero section-->
    <div class="relative bg-gray-50 overflow-hidden">
      <div
        class="hidden sm:block sm:absolute sm:inset-y-0 sm:h-full sm:w-full"
        aria-hidden="true"
      >
        <div class="relative h-full max-w-7xl mx-auto">
          <svg
            class="
              absolute
              right-full
              transform
              translate-y-1/4 translate-x-1/4
              lg:translate-x-1/2
            "
            width="404"
            height="784"
            fill="none"
            viewBox="0 0 404 784"
          >
            <defs>
              <pattern
                id="f210dbf6-a58d-4871-961e-36d5016a0f49"
                x="0"
                y="0"
                width="20"
                height="20"
                patternUnits="userSpaceOnUse"
              >
                <rect
                  x="0"
                  y="0"
                  width="4"
                  height="4"
                  class="text-gray-200"
                  fill="currentColor"
                />
              </pattern>
            </defs>
            <rect
              width="404"
              height="784"
              fill="url(#f210dbf6-a58d-4871-961e-36d5016a0f49)"
            />
          </svg>
          <svg
            class="
              absolute
              left-full
              transform
              -translate-y-3/4 -translate-x-1/4
              md:-translate-y-1/2
              lg:-translate-x-1/2
            "
            width="404"
            height="784"
            fill="none"
            viewBox="0 0 404 784"
          >
            <defs>
              <pattern
                id="5d0dd344-b041-4d26-bec4-8d33ea57ec9b"
                x="0"
                y="0"
                width="20"
                height="20"
                patternUnits="userSpaceOnUse"
              >
                <rect
                  x="0"
                  y="0"
                  width="4"
                  height="4"
                  class="text-gray-200"
                  fill="currentColor"
                />
              </pattern>
            </defs>
            <rect
              width="404"
              height="784"
              fill="url(#5d0dd344-b041-4d26-bec4-8d33ea57ec9b)"
            />
          </svg>
        </div>
      </div>

      <div class="relative pb-16 sm:pb-24">
        <main class="mt-16 mx-auto max-w-7xl px-4 sm:mt-24">
          <div class="text-center">
            <h1
              class="
                text-4xl
                tracking-tight
                font-extrabold
                text-gray-900
                sm:text-5xl
                md:text-6xl
              "
            >
              <span class="block xl:inline">The database of</span>
              <span class="block text-indigo-600 xl:inline"
                >viroid-like RNAs</span
              >
            </h1>
            <p
              class="
                mt-3
                max-w-md
                mx-auto
                text-base text-gray-500
                sm:text-lg
                md:mt-5 md:text-xl md:max-w-3xl
              "
            >
              ViroidDB is the most comprehensive collection of viroid, satellite
              RNA, retrozyme, and deltavirus genome sequences available on the
              internet.
            </p>
            <div
              class="mt-5 max-w-md mx-auto sm:flex sm:justify-center md:mt-8"
            >
              <div class="rounded-md shadow">
                <NuxtLink
                  to="/sequences"
                  class="
                    w-full
                    flex
                    items-center
                    justify-center
                    px-8
                    py-3
                    border border-transparent
                    text-base
                    font-medium
                    rounded-md
                    text-white
                    bg-indigo-600
                    hover:bg-indigo-700
                    md:py-4 md:text-lg md:px-10
                  "
                >
                  View Data
                </NuxtLink>
              </div>
              <div class="mt-3 rounded-md shadow sm:mt-0 sm:ml-3">
                <NuxtLink
                  to="/download"
                  class="
                    w-full
                    flex
                    items-center
                    justify-center
                    px-8
                    py-3
                    border border-transparent
                    text-base
                    font-medium
                    rounded-md
                    text-indigo-600
                    bg-white
                    hover:bg-gray-50
                    md:py-4 md:text-lg md:px-10
                  "
                >
                  Download Data
                </NuxtLink>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
    <!-- The stats -->
    <div class="bg-gray-50 pt-12 sm:pt-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto text-center">
          <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
            Go beyond the sequence
          </h2>
          <p class="mt-3 text-xl text-gray-500 sm:mt-4">
            In addition assembled genomes, ViroidDB also includes downstream
            analyses including predicted secondary structures ribozymes, and
            clusters.
          </p>
        </div>
      </div>
      <div class="mt-10 pb-12 bg-gray-50 sm:pb-16">
        <div class="relative">
          <div class="absolute inset-0 h-1/2 bg-gray-50"></div>
          <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="max-w-4xl mx-auto">
              <dl class="rounded-lg bg-white shadow-lg sm:grid sm:grid-cols-3">
                <div
                  class="
                    flex flex-col
                    border-b border-gray-100
                    p-6
                    text-center
                    sm:border-0 sm:border-r
                  "
                >
                  <dt
                    class="
                      order-2
                      mt-2
                      text-lg
                      leading-6
                      font-medium
                      text-gray-500
                    "
                  >
                    Sequences
                  </dt>
                  <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                    {{ Number(9486).toLocaleString() }}
                  </dd>
                </div>

                <div
                  class="
                    flex flex-col
                    border-t border-gray-100
                    p-6
                    text-center
                    sm:border-0 sm:border-l
                  "
                >
                  <dt
                    class="
                      order-2
                      mt-2
                      text-lg
                      leading-6
                      font-medium
                      text-gray-500
                    "
                  >
                    Ribozymes predicted
                  </dt>
                  <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                    {{ Number(18854).toLocaleString() }}
                  </dd>
                </div>
                <div
                  class="
                    flex flex-col
                    border-t border-b border-gray-100
                    p-6
                    text-center
                    sm:border-0 sm:border-l sm:border-r
                  "
                >
                  <dt
                    class="
                      order-2
                      mt-2
                      text-lg
                      leading-6
                      font-medium
                      text-gray-500
                    "
                  >
                    Clusters with 90% identity
                  </dt>
                  <dd class="order-1 text-5xl font-extrabold text-indigo-600">
                    {{ Number(463).toLocaleString() }}
                  </dd>
                </div>
              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- This logo cloud -->
    <div class="bg-gray-50">
      <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <p
          class="
            text-center text-base
            font-semibold
            uppercase
            text-gray-600
            tracking-wider
            mb-8
          "
        >
          Brought to you by
        </p>
        <div class="grid grid-cols-1 gap-8 md:grid-cols-3">
          <div class="col-span-1 flex justify-center">
            <img class="h-12" src="/ncbi.png" alt="Tuple" />
          </div>
          <div class="col-span-1 flex justify-center">
            <img class="h-12" src="/oxford4.png" alt="Mirage" />
          </div>
          <div class="col-span-1 flex justify-center">
            <img class="h-12" src="/tel_aviv_logo.png" alt="StaticKit" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
