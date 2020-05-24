---
layout: default
title: Posts
permalink: /posts/
---

<div class="home">

  <ul class="post-list">
    {% for post in site.posts %}
      <li>
        <!-- <span class="post-meta">
        {% for categories in page.categories %}<li>{{ page.categories }}</li>{% endfor %}</span>
        | -->
        <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
        <h2>
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
        </h2>
        <span class="post-meta">{{ post.synopsis }}</span>
      </li>
    {% endfor %}
  </ul>
