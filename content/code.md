---
layout: layouts/home.njk
title: Code
permalink: /code/
---

{% set postslist = collections.code | reverse | head(5) %}
{% include "postslist.njk" %}
