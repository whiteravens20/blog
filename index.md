---
layout: default
title: Home
---

<section class="intro">
  <p class="intro-eyebrow">White Ravens</p>
  <h1>Open-source, in the open.</h1>
  <p>Field notes from a small collective building self-hosted services, privacy-respecting tooling, and the rough edges of running software in the open &mdash; plus the lessons we collect along the way.</p>
  <p>Nothing here is sponsored. Everything here is MIT (unless noted). Pull up a chair.</p>
</section>

<h2 class="section-heading">Latest Posts</h2>

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <h2><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
      <p class="post-meta">{{ post.date | date: "%Y-%m-%d" }}{% if post.author %} &middot; {{ post.author }}{% endif %}</p>
      <p>{{ post.excerpt | strip_html | truncate: 200 }}</p>
    </li>
  {% endfor %}
</ul>
