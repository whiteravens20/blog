---
layout: post
title: "Yarr: RSS Never Died, It Just Moved to Self-Hosters"
date: 2026-09-12
tags:
  - self-hosting
  - rss
  - privacy
author: Taylor
description: "A lightweight, self-hosted RSS reader in Go that syncs across devices and keeps your feeds private."
---

A lightweight, self-hosted RSS reader that syncs across devices and keeps your feeds private.

## TL;DR

Yarr is a Go-based RSS reader that runs on minimal hardware, syncs across your devices without a cloud account, and keeps your feeds on your server. If you've been waiting for someone to build what Google Reader should have been, this is it.

## RSS never went anywhere

Google Reader died in 2013. The internet declared RSS dead with it. Except RSS didn't die — it just moved.

Today, RSS powers podcasts, Mastodon, YouTube subscriptions, and every self-hoster who refuses to let an algorithm or a venture-backed company decide what they see. The readers changed. Feedly and Inoreader filled the gap with hosted solutions. But if you run your own infrastructure, you want your feeds on *your* server, not someone else's.

That's where Yarr comes in.

## What Yarr is

Yarr is a self-hosted RSS reader written in Go. It's lightweight — the binary is a few megabytes. It's fast — no JavaScript, no bloat, no tracking. It syncs across your devices without requiring you to hand your reading list to a third party. You point it at your server, add your feeds, and your reading list stays yours.

The project has 3.8k stars on GitHub and solves a specific problem for a specific audience: people who already run their own infrastructure and want a feed reader that fits that world instead of fighting it.

## Why this matters

Three reasons.

**First: minimal hardware.** Yarr runs on a Raspberry Pi. It runs on a $5 VPS. It doesn't need a database server or a separate cache layer or a queue. You can deploy it in an afternoon on whatever box you already have running.

**Second: no account, no sync tax.** Most RSS readers sync your subscriptions to their cloud. Yarr syncs across *your* devices by storing everything on *your* server. Your phone, your laptop, your tablet — they all read from the same feed list, the same read/unread state, the same starred articles. No account creation, no API key juggling, no "premium sync" upsell.

**Third: the UI gets out of the way.** No algorithm. No "recommended for you" sidebar. No dark pattern trying to keep you scrolling. You see your feeds. You read what you subscribed to. That's the whole interface.

## How to run it

Yarr publishes pre-built binaries for Linux, macOS, and Windows. If you have a server and 15 minutes, you can have it running.

**Download the latest release:**

```bash
cd /opt
wget https://github.com/nkanaev/yarr/releases/download/v1.x.x/yarr-linux-amd64.zip
unzip yarr-linux-amd64.zip
chmod +x yarr
```

(Replace `v1.x.x` with the actual latest version from the [releases page](https://github.com/nkanaev/yarr/releases).)

**Start it:**

```bash
./yarr
```

By default it listens on `http://localhost:8080`. Open that in your browser, and you're in. Add your first feed, and you're done.

**For persistent deployment,** use a systemd service or Docker. The [README](https://github.com/nkanaev/yarr#readme) covers both. If you're already running a reverse proxy (nginx, Caddy), point it at Yarr's port and you have HTTPS with zero extra config.

## What to expect

Yarr is stable. It's not flashy. The UI is plain HTML and CSS — fast, responsive, and built to work on old phones and slow connections. You get:

- Feed subscriptions with auto-discovery (paste a URL, it finds the feed)
- Read/unread tracking across devices
- Starred articles (saved for later)
- Search across your entire feed history
- OPML import/export (so you can move your subscriptions if you ever want to)
- API for building your own clients

What you don't get: notifications, algorithms, trending topics, or any attempt to monetize your attention. That's the point.

## The catch

Yarr is a single-user reader. If you want to share a reading list with family or colleagues, you'll need to run separate instances or use a different tool. It's built for one person on one server, and it does that very well.

The UI is minimal by design, which some people love and others find sparse. There's no dark mode toggle or font customization — it's a feed reader, not a theme engine. If you need that level of personalization, Yarr isn't it.

## What to do next

Head to [the Yarr repo](https://github.com/nkanaev/yarr) and read the README. If you have a server and a list of RSS feeds you want to reclaim, deploy it. If you're not sure which feeds to start with, look for OPML exports from your current reader (Feedly, Inoreader, even old Google Reader backups) and import them directly.

RSS didn't die. It just got quieter, smaller, and more honest. Yarr is what that looks like.
