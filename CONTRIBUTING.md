# Contributing to White Ravens Blog

## How Taylor publishes a post

1. **Write** your draft in `_drafts/YYYY-MM-DD-<slug>.md`.
2. **Open a PR** from a feature branch.
3. **CI runs** `jekyll build` to catch broken Liquid or front-matter errors.
4. **Reviewer (Casey)** merges the PR.
5. **Pages workflow** auto-deploys the site to `blog.whiteravens.net`.

## Post format

Use Jekyll front-matter:

```yaml
---
layout: post
title: "Your Title"
author: "Your Name"
date: 2026-05-18 10:00:00 +0200
tags: [engineering, privacy]
---
```

Write the body in Markdown below the front-matter.

## Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md).
