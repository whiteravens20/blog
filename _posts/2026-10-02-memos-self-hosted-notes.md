---
layout: post
title: "Memos: Self-Hosted Notes That Stay Yours"
date: 2026-10-02
tags:
  - self-hosting
  - privacy
  - productivity
author: Taylor
description: "Why a self-hosted note app beats cloud lock-in for people who actually write."
---

Why a self-hosted note app beats cloud lock-in for people who actually write.

## TL;DR

[Memos](https://github.com/usememos/memos) is a lightweight, markdown-native note app that runs on your own server. You write without picking a title or a folder, and every note lands in a searchable timeline — no cloud vendor in between. It runs from a single Docker command and gets out of your way.

## The problem with cloud notes

Cloud note apps promise simplicity. What they deliver is friction.

You open Evernote or OneNote and wait for sync. You hit a feature wall and consider upgrading. You try to export your years of writing and get a proprietary format that doesn't open anywhere else. You switch apps and start over.

For people who write — who rely on notes as a thinking tool, not a to-do list — this is a slow bleed. Every sync delay, every account nag, every closed format is a tiny friction point that adds up.

Memos removes all of it.

## Why Memos works

**Markdown first.** You write plain Markdown, so the words themselves aren't locked into a proprietary format. Memos keeps the notes in its own database on your server (SQLite by default), and that data directory is what you back up and move — more on that below.

**Runs on your hardware.** Memos is lightweight enough for a Raspberry Pi. No cloud bill, no bandwidth throttling, no "your account is full" message. You control the server; you control the uptime. If you want it offline, it's offline. If you want it on a $5 VPS, it's there.

**One copy, every device.** Memos is a web app on your server: a note is saved there the moment you hit save, and your phone and laptop open the same timeline. There's no second copy to sync and no conflict to untangle. You write, it saves, it's done.

**Searchable from day one.** Every note is indexed and searchable the moment it lands on your server. No waiting for a background sync. No "search is only available in the paid tier." Your entire archive is yours to query, instantly.

## Getting started

Memos runs as a Docker container or a standalone binary. Here's the fastest path:

### Docker (recommended)

If you already run Docker, Memos is a five-minute setup:

```bash
docker run -d \
  --name memos \
  -p 5230:5230 \
  -v ~/.memos:/var/opt/memos \
  neosmemo/memos:stable
```

The `stable` tag follows the project's stable releases, and everything Memos stores lands in `~/.memos` on the host. Then open `http://localhost:5230` in your browser. Create an account (local, on your server — no cloud signup), and start writing.

### Other ways to run it

Binaries and the other install options live in the [deployment guide](https://usememos.com/docs/deploy). Releases ship as archives for Linux, macOS and Windows, and newer ones use calendar tags such as `26.09`, so take the current download from there. Same deal once it runs: open the browser, create an account, write.

### Reverse proxy (for production)

If you're running Memos on a VPS or behind a reverse proxy, point your domain at it:

```nginx
server {
    listen 443 ssl http2;
    server_name notes.example.com;

    ssl_certificate /etc/letsencrypt/live/notes.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/notes.example.com/privkey.pem;

    location / {
        proxy_pass http://localhost:5230;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Reload nginx and you're live. HTTPS, your domain, your server.

## What to know before you start

**Upgrading from an old version takes a stop on the way.** If you run a release older than v0.31.0, the README says to upgrade to [v0.31.0](https://github.com/usememos/memos/releases/tag/v0.31.0) first and let it finish before moving on. A fresh install doesn't need this.

**Mobile is web-first.** Memos has no official iOS or Android app. You access it through your phone's browser. It works, but it's not as polished as a native app. If you need offline mobile notes, Memos isn't there yet.

**Backup is your responsibility.** Memos stores data in a SQLite database (by default) or PostgreSQL (if you configure it). You need to back it up yourself — tar the data directory, push it to S3, whatever your backup strategy is. Memos won't do it for you.

**No built-in sync to other devices.** Memos syncs across browsers on the same server, but if you want your notes on your phone *and* your laptop *and* your desktop, you're accessing the same server from all three. That's fine if your server is always reachable. If you're offline, you're offline.

## The real win

Memos isn't the fanciest note app. It doesn't have AI summaries or infinite plugins or a marketplace. It has one job: let you write in markdown, keep your notes on your server, and get out of the way.

For self-hosters, that's everything. You own the hardware. You own the data. You own the format. You're not renting a feature set from a company that might pivot, get acquired, or decide your tier isn't profitable anymore.

You write. The note is yours. That's it.

## What to do next

Before you install anything, click around the [live demo](https://demo.usememos.com/) to see the timeline for yourself. Then start with the [Memos GitHub repo](https://github.com/usememos/memos): the README has the Docker command above and links the [deployment guide](https://usememos.com/docs/deploy) for every other setup. Once you're running, the [web clipper](https://usememos.com/web-clipper) for Chrome and Firefox saves pages and selections straight into your timeline.