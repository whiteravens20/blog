---
layout: default
title: Tags
permalink: /tags/
---

<section class="intro">
  <p class="intro-eyebrow">Browse</p>
  <h1>Tags</h1>
  <p>Every post on this blog grouped by the tags it carries. Use the cloud below to jump to a section, or scroll.</p>
</section>

{% assign tags = site.tags | sort %}

{% if tags == empty %}
<p>No tags yet.</p>
{% else %}

<nav class="tag-cloud" aria-label="Tag cloud">
  {% for tag in tags %}
    <a class="tag-chip" href="#{{ tag[0] | slugify }}">
      <span class="tag-chip-name">{{ tag[0] }}</span>
      <span class="tag-chip-count">{{ tag[1] | size }}</span>
    </a>
  {% endfor %}
</nav>

{% for tag in tags %}
  <section class="tag-section" id="{{ tag[0] | slugify }}">
    <h2 class="section-heading">#{{ tag[0] }}</h2>
    <ul class="post-list">
      {% assign posts = tag[1] | sort: 'date' | reverse %}
      {% for post in posts %}
        <li>
          <h2><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
          <p class="post-meta">{{ post.date | date: "%Y-%m-%d" }}{% if post.author %} &middot; {{ post.author }}{% endif %}</p>
          <p>{{ post.excerpt | strip_html | truncate: 200 }}</p>
        </li>
      {% endfor %}
    </ul>
  </section>
{% endfor %}

{% endif %}
