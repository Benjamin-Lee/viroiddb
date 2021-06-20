<template>
  <!--
  This example requires Tailwind CSS v2.0+ 
  
  This example requires some changes to your config:
  
  ```
  // tailwind.config.js
  module.exports = {
    // ...
    plugins: [
      // ...
      require('@tailwindcss/forms'),
    ]
  }
  ```
-->
  <div>
    <hr />
    <form name="submit" method="POST" netlify class="space-y-4">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700"
          >Name</label
        >
        <div class="mt-1">
          <input
            type="text"
            name="name"
            id="name"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
          />
        </div>
      </div>
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700"
          >Email</label
        >
        <div class="mt-1">
          <input
            type="text"
            name="email"
            id="email"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
            placeholder="you@example.com"
          />
        </div>
      </div>
      <div>
        <label for="accession" class="block text-sm font-medium text-gray-700"
          >Accession</label
        >
        <div class="mt-1">
          <input
            type="text"
            name="accession"
            id="accession"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
            placeholder="AB279771.1"
          />
        </div>
      </div>
      <div>
        <label for="accession" class="block text-sm font-medium text-gray-700"
          >Comments</label
        >
        <div class="mt-1">
          <textarea
            name="comments"
            id="comments"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
            placeholder="Lorem ipsum dolor sit amet consectetur adipisicing elit. Eligendi ipsa officia deleniti deserunt magnam, debitis at sapiente nostrum, quae dignissimos nihil necessitatibus voluptas."
          />
        </div>
      </div>
    </form>
  </div>
</template>
