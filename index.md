---
layout: default
title: Home
---

<h1>Latest Posts</h1>

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <h2><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
      <p class="post-meta">{{ post.date | date: "%Y-%m-%d" }}{% if post.author %} • {{ post.author }}{% endif %}</p>
      <p>{{ post.excerpt | strip_html | truncate: 200 }}</p>
    </li>
  {% endfor %}
</ul>
