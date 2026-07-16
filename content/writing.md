---
layout: layouts/home.njk
title: Writing
permalink: /writing/
---

{% set postslist = collections.writing | reverse | head(5) %}
{% include "postslist.njk" %}
