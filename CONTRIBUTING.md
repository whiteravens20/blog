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

## Link previews

A production build gives every post its own link preview: `_plugins/og_cards.rb` has the browser on the build machine draw the post's title into `assets/og/<slug>.png`. With no browser there, or when one card fails, the post keeps `assets/images/og-default.png`, because a preview must never stop a post from going out. CI fails if no card was made at all.

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

A post can carry one picture right after its TL;DR: a file in `assets/posts/` named after the post, with a caption saying where it comes from and under which licence. A picture never stays on another server, where a reader's browser would have to ask for it.

```markdown
![What the picture shows](/assets/posts/your-slug.png)
*Image from the [Project README](https://github.com/owner/repo#readme), MIT.*
```

## Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md).
