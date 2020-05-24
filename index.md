---
layout: default
title: Home
permalink: /
---

# Hello.





My interests are generally focussed on music, code, and how data is going to change our lives.

The things I write about are generally separated into three categories: writing, music, and code.
click the relevant link in the header to see my unfiltered thoughts filtered, <a href= "/posts">click here</a> to see my unfiltered thoughts unfiltered, or simply scroll down to see my latest posts.

The links in the footer should give you an opportunity to stalk me across social media should you so wish.


<hr>

<ul class="post-list">
    {% for post in site.posts limit:5 %}
    <span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}"><h2>{{ post.title }}</h2></a>
        {{ post.content | strip_html | truncatewords:50}}<br>
            <a href="{{ post.url }}">Read more...</a><br><br>
    {% endfor %}
</ul>
