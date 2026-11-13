---
layout: post
title: "Mastodon: Your Own Social Network Server, Still Connected to Everyone Else"
date: 2026-11-04
tags:
  - self-hosting
  - fediverse
  - social-media
author: Taylor
description: "You can run a social network server of your own that still follows and is followed by people on every other Mastodon server."
---

You can run a social network server of your own that still follows and is followed by people on every other Mastodon server.

## TL;DR

[Mastodon](https://github.com/mastodon/mastodon) is free, open-source social network server software. It is for anyone tired of a company deciding what lands in their feed, and for groups who would rather set their own rules than rent a spot on someone else's platform. Every server is independent, and servers talk to each other over ActivityPub, so you can join one or host your own and still reach everyone.

## The problem with the big platform

If you post on a large social platform, a company decides what shows up in your feed and what the rules are. The usual options are to put up with it or to leave, and leaving means losing the audience you built there.

The same goes for a club, a community or a small organization. Your members live on a platform where you have no say over moderation, and the platform can change its terms whenever it likes.

## What using Mastodon is like

### One account, many servers

You pick a server to join, or you run your own. Either way you get one account, and that account can follow people on any other Mastodon server. Someone on a different server can follow you back, and their posts reach you the same way as everyone else's.

The network is wider than Mastodon itself. Anything that implements ActivityPub is part of the Fediverse, so the same account can follow and talk to people on other software too.

### The home feed

The home feed shows posts from the people you follow, in the order they were written, and updates appear as they arrive. The project says there are no algorithms or ads in it.

### Posting

You can publish text, links, pictures, video and audio. Posts can carry accessibility descriptions and content warnings, and you can attach polls. Videos with no audio track are treated like animated GIFs, while normal videos loop continuously.

### Keeping your space in order

Mastodon has private posts, locked accounts, phrase filters, muting and blocking, plus a reporting and moderation system. Each server writes its own rules and enforces them locally, not from the top down. If you disagree with a server's rules, you join one whose rules you do agree with, or host your own.

### Apps

You can read and post from the official Android and iOS apps. Third-party apps work too: Mastodon acts as an OAuth2 provider and exposes REST and Streaming APIs, and the project keeps a [list of apps](https://joinmastodon.org/apps).

## Why it is worth a look

- **The network is not tied to one company.** Servers run by different people interoperate over open standards, so there is no single vendor to depend on.
- **The licence is AGPLv3**, and the project describes itself as developed by a non-profit.
- **There is an official container image** and the repository ships Docker and docker-compose configurations.

## Trying it, then running it

The quickest way in is to join a server and look around as a user. The [homepage](https://joinmastodon.org) offers mastodon.social first, and there is a "pick another server" option if you want something else. We post from our own account on mastodon.social, and it is a fine place to see what a feed looks like before deciding anything.

To host your own, the repository includes deployment configurations for Docker and docker-compose, as well as for Heroku and Scalingo. There is an [official container image](https://github.com/mastodon/mastodon/pkgs/container/mastodon), and Helm charts live in the separate [mastodon/chart repository](https://github.com/mastodon/chart). If you would rather install without containers, the [standalone installation guide](https://docs.joinmastodon.org/admin/install/) in the documentation walks through it. That route needs Ruby 4.0, PostgreSQL 14+, Redis 7.0+, Node.js 24+ and FFmpeg 5.1+.

Follow the install guide for the exact steps. Once your server answers at its address, create an account there and try following someone on another server. If their posts arrive in your home feed, federation works.

## Where it falls short

Mastodon is not one small binary. A server is a Ruby on Rails app plus PostgreSQL, Redis with Sidekiq for caching and queues, and a separate Node.js streaming API. That is several moving parts to install and keep running, which is a real cost for one person who just wants a place to post.

If that sounds like too much, join an existing server. You keep the same ability to follow and be followed across the network, and someone else does the upkeep.

## What to do next

Start at [joinmastodon.org](https://joinmastodon.org) and pick a server. When you want to host, read the [installation guide](https://docs.joinmastodon.org/admin/install/) and the rest of the [documentation](https://docs.joinmastodon.org). Project news is on the [Mastodon blog](https://blog.joinmastodon.org), and the project posts at @Mastodon@mastodon.social. Questions and discussion happen [on GitHub](https://github.com/mastodon/mastodon/discussions).
