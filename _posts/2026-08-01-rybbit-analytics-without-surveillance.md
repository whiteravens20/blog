---
layout: post
title: "Rybbit: Analytics Without the Surveillance"
date: 2026-08-01
tags:
  - self-hosting
  - privacy
  - analytics
author: Taylor
description: "Open-source analytics that respects your visitors and runs on your infrastructure."
---

A privacy-first alternative to Google Analytics.

## TL;DR

Rybbit is an open-source analytics platform that replaces Google Analytics without the tracking, consent banners, or vendor lock-in. Self-host it on your own server, read your traffic in 30 seconds, and keep visitor data off third-party servers. It's younger than Plausible or Fathom, but mature enough for most self-hosted sites.

## Why Rybbit instead of Google Analytics?

Google Analytics is free because *you* are the product. Every pageview, click, and scroll gets sent to Google's servers, cross-referenced with your visitor's other browsing, and fed into an advertising machine. You get a dashboard in return. Rybbit flips that trade: you run the analytics on your own infrastructure, your visitors' data never leaves your server, and you get a readable dashboard without the surveillance.

Three concrete wins:

**Privacy by default.** No third-party tracking. No data sales. No consent-banner compliance theatre. If you self-host Rybbit, visitor data stays on your box. GDPR, CCPA, and similar regulations become non-issues because you're not sending personal data across borders.

**Dashboard that doesn't require a PhD.** Google Analytics' power comes with UI friction: funnels, segments, custom events, UTM parameter chains. Rybbit strips that down to the metrics that actually matter — traffic source, page views, bounce rate, session duration, top pages, referrers. You open it, glance at the numbers, and move on. No data analyst required.

**No vendor lock-in.** Your analytics live on your server, in an open-source codebase you can fork, modify, or migrate away from. You're not hostage to Plausible's pricing or Fathom's feature roadmap. If you decide to switch, your data is yours to export.

## How to self-host Rybbit

Rybbit runs in Docker and requires a database (PostgreSQL or SQLite). Here's the path from zero to running:

### 1. Clone the repo and check the setup guide

```bash
git clone https://github.com/rybbit-io/rybbit.git
cd rybbit
cat README.md
```

The README contains the canonical setup instructions. Follow those — they're the source of truth, and this post is written from the upstream docs, not a live test.

### 2. Spin up with Docker Compose

Rybbit ships with a `docker-compose.yml`. If you have Docker and Docker Compose installed:

```bash
docker-compose up -d
```

This starts the Rybbit service and (by default) a PostgreSQL database. Check the compose file to swap in SQLite if you prefer a single-file database.

### 3. Access the dashboard

Once the container is running, open `http://localhost:3000` (or your server's IP). You'll see a login screen. Create an account, then add your site.

### 4. Add the tracking script to your site

Rybbit generates a JavaScript snippet for each site you add. Drop it into your site's HTML `<head>` or before the closing `</body>` tag:

```html
<script defer src="https://your-rybbit-domain/script.js" data-site-id="your-site-id"></script>
```

Replace `your-rybbit-domain` with your Rybbit instance's URL and `your-site-id` with the ID Rybbit assigns when you add the site.

### 5. Reverse proxy (optional but recommended)

If you're running Rybbit behind a reverse proxy (nginx, Caddy, Traefik), point your domain to the Rybbit container and configure SSL. This keeps your analytics accessible from anywhere without exposing port 3000 directly.

Example nginx snippet:

```nginx
server {
    listen 443 ssl http2;
    server_name analytics.example.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## What to watch for

**Rybbit is younger than Plausible or Fathom.** The feature set is still consolidating. If you need advanced segmentation, custom events, or goal tracking, check the repo's issues and roadmap first — the feature might be in progress or planned. For basic traffic metrics (which is what most self-hosters need), Rybbit is solid.

**Database choice matters.** SQLite is simpler (one file, no separate database service) but slower under concurrent load. PostgreSQL is heavier but scales better if you're tracking a high-traffic site. Start with SQLite if your site gets under 10K pageviews/day; move to PostgreSQL if you outgrow it.

**The script is lightweight.** Rybbit's tracking script is smaller than Google Analytics', so it won't bloat your site's load time. But like any third-party script (even one on your own server), it does add a network request. If you're obsessed with milliseconds, test your site's performance before and after.

## What to do next

Start with the [Rybbit repo](https://github.com/rybbit-io/rybbit) — clone it, read the README, and spin up a test instance. If you're already self-hosting other services (Immich, Nextcloud, Vaultwarden), Rybbit fits the same pattern: Docker, your data, your rules. Set it up on a subdomain, add your site's tracking script, and watch your traffic without the surveillance.

If you want a managed alternative (no self-hosting), Plausible and Fathom are both privacy-first and worth a look. But if you're here for self-hosting, Rybbit is the move.
