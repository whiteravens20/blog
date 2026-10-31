---
layout: default
title: Home
---

<section class="intro">
  <p class="intro-eyebrow">White Ravens</p>
  <h1>One self-hosted project a week.</h1>
  <p>What it does, what using it is like and where it falls short, from a small collective that runs its own services and builds open-source tools of its own.</p>
  <p>Nothing here is sponsored. Everything here is MIT (unless noted).</p>
  <p class="follow"><a class="button" href="https://mastodon.social/@whiteravens" rel="me">Follow on Mastodon</a> <a class="button" href="{{ '/feed.xml' | relative_url }}">Subscribe by RSS</a></p>
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
