---
title: Download
description: Learn how to use @nuxt/content.
---

All data used in this site is available for download in several forms.

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
