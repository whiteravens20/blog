---
layout: default
title: Tags
permalink: /tags/
---

<!--
  Adding a new tag? Create tags/<slug>.md with this front matter so the
  tag gets a dedicated, indexable page:

    ---
    layout: tag
    tag: <slug>
    title: "Tag: <slug>"
    permalink: /tags/<slug>/
    ---
-->

<section class="intro">
  <p class="intro-eyebrow">Browse</p>
  <h1>Tags</h1>
  <p>Every topic covered on this blog. Pick one to see its posts.</p>
</section>

{% assign tags = site.tags | sort %}

{% if tags == empty %}
<p>No tags yet.</p>
{% else %}
<nav class="tag-cloud" aria-label="Tag cloud">
  {% for tag in tags %}
    <a class="tag-chip" href="{{ '/tags/' | relative_url }}{{ tag[0] | slugify }}/">
      <span class="tag-chip-name">{{ tag[0] }}</span>
      <span class="tag-chip-count">{{ tag[1] | size }}</span>
    </a>
  {% endfor %}
</nav>
{% endif %}
