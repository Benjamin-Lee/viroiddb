---
title: About ViroidDB
description: Learn how to use @nuxt/content.
---

Viroids and their (potential) relatives are among the most unique and exciting of all biological entities.
However, we couldn't find a good, up-to-date database containing all of them in one place so we made our own.

Etc etc.

To view the sequence data, [click here](/sequences).

```js
const http = require('http')
const bodyParser = require('body-parser')

http
  .createServer((req, res) => {
    bodyParser.parse(req, (error, body) => {
      res.end(body)
    })
  })
  .listen(3000)
```
