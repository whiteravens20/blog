# Contributing to the White Ravens Blog

The blog is a Jekyll site published at [blog.whiteravens.net](https://blog.whiteravens.net) with GitHub Pages. `main` is the only branch, and what is on it is what is live.

## Posts

Posts are written by the White Ravens team. An approved post reaches `main` as a commit from our publishing workflow, so there is no pull request for it. A post dated in the future appears on its day: the site is rebuilt every night.

- **A mistake in a post**: open a bug report with the address of the post, or a pull request that corrects the file in `_posts/`.
- **A topic or a project worth a post**: open a suggestion. We pick what gets written.

## Changes to the site

Layout, styles, scripts, configuration and CI go through a pull request into `main`:

1. Branch from `main`.
2. Check the change locally, as described below.
3. Open the pull request. CI builds the site, reviews new dependencies, scans the gems for known vulnerabilities, analyses the site's script and plugin, and checks the pinned actions.
4. Once the checks pass, the pull request is squash-merged and the Pages workflow deploys it.

Commits follow [Conventional Commits](https://www.conventionalcommits.org/), one topic per commit.

## Local setup

Ruby 3.3 is what CI uses.

```bash
bundle install
bundle exec jekyll serve    # http://localhost:4000/
bundle exec jekyll build    # what CI runs
```

## Post format

A post is `_posts/YYYY-MM-DD-slug.md` with this front matter:

```yaml
---
layout: post
title: "Your Title"
date: 2026-05-18
tags:
  - self-hosting
  - privacy
author: Your Name
description: "One sentence that says what the post is about."
---
```

The body is Markdown below the front matter.

## Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md).
