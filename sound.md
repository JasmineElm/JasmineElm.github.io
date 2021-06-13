---
layout: post
title: Sound
permalink: /sound/
---

<div class="home">

<ul class="post-list"> {% for post in site.categories.sound limit:5 %} <span>{{
post.date
| date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url
}}"><h2>{{ post.title }}</h2></a> {{ post.content | strip_html |
truncatewords:50}}<br> <a href="{{ post.url }}">Read more...</a><br><br> {%
endfor %} </ul>  
