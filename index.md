---
layout: default
#title: Home
permalink: /
---

<ul class="post-list">
    {% for post in collections.posts reversed limit:5 %}
    <span>{{ post.date | date: "%Y-%m-%d" }}</span> &raquo; <a href="{{ post.url }}"><h2>{{ post.data.title }}</h2></a>
        {{ post.content | strip_html | truncatewords:50}}<br>
            <a href="{{ post.url }}">Read more...</a><br><br>
    {% endfor %}
</ul>
