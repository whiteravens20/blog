---
layout: post
title: "linkding: A Bookmark Manager You Actually Own"
date: 2026-07-04
tags:
  - self-hosting
  - privacy
  - tools
author: Taylor
description: "Lightweight, self-hosted bookmarks without cloud lock-in. Deploy in minutes, search instantly, export anytime."
---

What if you could finally stop losing useful links without handing your bookmarks over to a third party?

## TL;DR 

linkding is a single-container bookmark manager that runs on minimal hardware, searches your links instantly, and keeps your bookmarks portable. If you've abandoned bookmark managers because they're bloated or you don't trust them with your data, this one is different.

## Why bookmarks matter (and why most managers don't)

You save a link. Six months later, you need it. You can't remember the title. You can't remember where you saved it. You search your browser history. Nothing. The link is gone, or buried under 200 other tabs.

Bookmark managers exist to solve this. Pocket, Raindrop, Evernote — they all promise to be your link library. What they actually do is lock you in: export formats that don't work anywhere else, UIs that change without warning, and the baseline assumption that they own your data and can monetize it.

linkding takes the opposite approach. It's minimal by design. No tracking. No subscription. No lock-in. You run it on your own hardware, tag your links, search them instantly, and export them as standard HTML whenever you want. It's not flashy. It doesn't need to be.

## What linkding does

**Full-text search.** Save a link. Tag it. Later, search for a word you remember from the article. It finds it. No waiting for cloud sync, no algorithm deciding what's relevant.

**Tagging without friction.** Add tags as you save. Organize later, or don't — search works anyway. The interface is clean enough that you'll actually use it instead of letting bookmarks pile up in your browser.

**Portable bookmarks.** Export to HTML. Import into another manager, or into your browser. Your data is yours, not held hostage by a service that might shut down or change terms.

**Minimal hardware footprint.** Runs in a single Docker container. Works on a Raspberry Pi. Doesn't need a database cluster or a CDN. You need a box with a few hundred MB of RAM and you're done.

## How to run linkding

### 1. Pull and start the container

```bash
docker run \
  --name linkding \
  -p 9090:9090 \
  -v linkding-data:/etc/linkding/data \
  -e LD_SUPERUSER_NAME=admin \
  -e LD_SUPERUSER_PASSWORD=changeme \
  sissbruecker/linkding:latest
```

Replace `changeme` with a strong password. The container binds to port 9090; access it at `http://localhost:9090`.

### 2. Log in and add your first bookmark

Open the web interface. Log in with the credentials you set. Click **Add bookmark**. Paste a URL, add tags, save. That's it.

### 3. (Optional) Set up reverse proxy

If you're running linkding on a server and want to access it from outside your network, put it behind a reverse proxy (nginx, Caddy, Traefik). Example nginx config:

```nginx
server {
    listen 80;
    server_name bookmarks.example.com;

    location / {
        proxy_pass http://localhost:9090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Then use Let's Encrypt (via Certbot) to add HTTPS.

### 4. (Optional) Use Docker Compose for persistence

If you want a cleaner setup, create `docker-compose.yml`:

```yaml
version: '3.8'
services:
  linkding:
    image: sissbruecker/linkding:latest
    container_name: linkding
    ports:
      - "9090:9090"
    volumes:
      - linkding-data:/etc/linkding/data
    environment:
      - LD_SUPERUSER_NAME=admin
      - LD_SUPERUSER_PASSWORD=changeme
    restart: unless-stopped

volumes:
  linkding-data:
```

Then run:

```bash
docker-compose up -d
```

## What to expect

**The UI is functional, not flashy.** No animations, no dark mode toggle, no "modern" design that changes every quarter. It's a form, a search box, and a list. If you're used to Raindrop's polished interface, linkding will feel spartan. That's intentional. Every feature is there because someone actually uses it; nothing is there to look impressive.

**Search is fast.** Type a word and results appear instantly. No cloud round-trip, no waiting for an API.

**Tagging is optional but powerful.** You can save links with no tags and still find them via full-text search. Or tag them for quick filtering. Your choice.

**Export is standard.** Your bookmarks export as HTML — the same format browsers use. You can import them into Firefox, Chrome, another bookmark manager, or keep them as a backup. They're not trapped.

## Gotchas

**No built-in sharing.** If you want to share a bookmark with someone, you copy the link and send it. There's no "share this collection" feature. For a self-hosted tool, that's a reasonable tradeoff — sharing would require either public URLs (privacy risk) or a separate sharing system (complexity).

**No mobile app.** The web interface works on mobile, but there's no native app for iOS or Android. If you need to save links from your phone, you'll use the mobile web UI or browser extension (if available — check the repo).

**Single-user by default.** The setup above creates one admin account. Multi-user support exists but requires additional configuration. For a personal bookmark manager, single-user is fine; for a household or team, you'll need to read the docs.

## What to do next

Read the full docs at https://docs.linkding.link/ (or the README at https://github.com/sissbruecker/linkding if docs aren't live). Check the repo for browser extensions that let you save links with one click. Start with a test container on your local machine, export your bookmarks from your current manager, and import them. If it works for you, move it to your server and set it up behind a reverse proxy.
