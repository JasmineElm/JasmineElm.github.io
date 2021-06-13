---
layout: post
title: Alias to start Jekyll Service
date: 2015-05-28T21:26:53.000Z
categories: writing
synopsis: bash script to aid working in Jekyll
last-modified-date: '2021-06-12T16:39:06+01:00'

---

Here is a simple alias that starts the Jekyll service, and opens a browser.

```bash
    alias jekserve='cd *your website directory* && Jekyll serve & sleep 2 && open http://0.0.0.0:4000/'
```

the command, cd's to your website directory, starts the Jekyll service, waits a couple of seconds (whilst it renders), and opens localhost on port 4000 (the default server for Jekyll).
