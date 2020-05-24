---
layout: sandpit
title: Posts
permalink: /sandpit/
---

<!-- <div class="home"> -->

<ul class="post-list">
<div class="onerow">
  {% for post in site.posts %}
  {% if post.title.size < 30 %}
  {% assign colwidth = 'col4' %}
  {% assign truncate = '50' %}
  {% assign twocol = '' %}
  {% else %}
  {% assign colwidth = 'col6' %}
  {% assign truncate = '100' %}
  {% assign twocol = 'twocol' %}
  {% endif %}
    <li class="{{ post.categories }} {{colwidth}}">
        <p><a class= "post-category" href="/{{ post.categories }}"> {{ post.categories }} </a>
      <span class="post-date">{{ post.date | date: "%B, %Y" }} </span></p>
      <p class = "coltitle">
      <a class ="post-title" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a> </p>
      <p class = "colcontent {{twocol}}">
      <a class="post-excerpt" href="{{ post.url | prepend: site.baseurl }}">{{ post.excerpt | strip_html | strip_newlines | truncatewords: truncate}} </a></p>
    </li>
  {% endfor %}
