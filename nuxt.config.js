// import data from './static/meta.slim.json'
// let dynamicRoutes = () => {
//   return new Promise((resolve) => {
//     resolve(Object.keys(data).map((el) => `sequences/${el}`))
//   })
// }

export default {
  // Target: https://go.nuxtjs.dev/config-target
  target: 'static',

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'ViroidDB',
    htmlAttrs: {
      lang: 'en',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
    script: [
      {
        src: 'https://unpkg.com/fornac@1.1.8/dist/scripts/fornac.js',
        defer: true,
      },
    ],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/typescript
    '@nuxt/typescript-build',
    // https://go.nuxtjs.dev/tailwindcss
    '@nuxtjs/tailwindcss',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    '@nuxt/content',
    [
      '@nuxtjs/firebase',
      {
        config: {
          apiKey: 'AIzaSyD28urAR7MGh-dfmNsM9LVbnxY1m20WM1M',
          authDomain: 'viroiddb.firebaseapp.com',
          projectId: 'viroiddb',
          storageBucket: 'viroiddb.appspot.com',
          messagingSenderId: '863813157544',
          appId: '1:863813157544:web:0c5a95bed9fd4d4475789d',
        },
        // terminateDatabasesAfterGenerate: true,
        services: {
          firestore: true,
        },
      },
    ],
  ],

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
 
      transpile: ['vue-instantsearch', 'instantsearch.js/es'], 
   
    html: {
      minify: {
        // have to copy-paste since it is not merged
        collapseBooleanAttributes: true,
        decodeEntities: true,
        minifyCSS: true,
        minifyJS: true,
        processConditionalComments: true,
        removeEmptyAttributes: true,
        removeRedundantAttributes: false,
        trimCustomFragments: true,
        useShortDoctype: true,
      },
    },
  },

  // make Netlify work
  generate: {
    fallback: true,

    // routes: ['/submit'],
  },

  content: {
    markdown: {
      prism: {
        theme: false,
      },
    },
  },
}
