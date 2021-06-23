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
        <input type="hidden" name="form-name" value="submit" />
        <div class="mt-1">
          <input
            id="name"
            type="text"
            name="name"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
            placeholder="T.O. Diener"
          />
        </div>
      </div>
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700"
          >Email</label
        >
        <div class="mt-1">
          <input
            id="email"
            type="email"
            name="email"
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
          >Accession(s)</label
        >
        <div class="mt-1">
          <input
            id="accession"
            type="text"
            name="accession"
            class="
              shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              sm:text-sm
              border-gray-300
              rounded-md
            "
            placeholder="AB279771.1, AF298178.1"
          />
        </div>
      </div>
      <div>
        <label for="comments" class="block text-sm font-medium text-gray-700"
          >Comments</label
        >
        <div class="mt-1">
          <textarea
            id="comments"
            name="comments"
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
      <input
        type="submit"
        value="Submit"
        class="
          inline-flex
          items-center
          px-3
          py-2
          border border-transparent
          text-sm
          leading-4
          font-medium
          rounded-md
          shadow-sm
          text-white
          bg-indigo-600
          hover:bg-indigo-700
          focus:outline-none
          focus:ring-2
          focus:ring-offset-2
          focus:ring-indigo-500
        "
      />
    </form>
  </div>
</template>
