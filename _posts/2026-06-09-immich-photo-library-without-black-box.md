---
layout: post
title: "Immich: Your Photo Library Without the Black Box"
date: 2026-06-09
tags:
  - self-hosting
  - privacy
  - immich
  - photo-management
author: Taylor
description: "Why Immich replaces Google Photos — and why your photos shouldn't live in a corporate cloud you don't control."
---

Tired of storing your photos in someone else’s cloud?

## TL;DR

Immich is a self-hosted photo and video manager that replaces Google Photos without the cloud lock-in or privacy trade-off. Photos sync from your phone on your terms, face recognition and search run locally, and the UI is polished enough that household members use it without friction. Setup requires Docker; the payoff is permanent ownership.

## Why This Matters

You own thousands of photos. Google owns the ability to search them, organize them, and analyze them. That asymmetry is the problem Immich solves.

Google Photos is convenient — tap a button, photos appear everywhere. But convenience is the price you pay, not what you get. Google's algorithm learns your faces, your locations, your habits. It can change the terms tomorrow. It can delete your account. It can sell access to your data (directly or indirectly) to third parties. You have no recourse because you don't own the platform.

Immich flips that. Your photos live on your hardware. Your face recognition runs on your server. Your search index is yours. No cloud account required. No corporate terms of service. No algorithm learning who you are.

The catch: you have to run it. That means Docker, a NAS, or a spare Linux box. It means you're responsible for backups. It means you're responsible for uptime. For self-hosters, that's not a bug — it's the point. You're trading convenience for control. And for photos, that trade is worth it.

## How Immich Works

### Mobile Sync: Offline-First

Install the Immich app on your phone. Point it at your server. From then on, photos upload when you're ready — not automatically to a cloud you didn't choose.

This matters more than it sounds. Automatic cloud sync trains you to assume your photos are already backed up. Immich makes you *choose* to back them up. You see the upload queue. You decide when. If you're on a metered connection, you can wait. If you're offline, photos stay on your phone until you're ready. You're in control.

### Organization: Local, Fast, Yours

Once photos are on your server, Immich organizes them without sending anything to a third party.

**Face recognition** runs locally using machine learning models on your hardware. Immich groups photos by face, learns who is who, and lets you search by person. No image leaves your server. Google, Amazon, or any cloud provider never sees your photos.

**Search** indexes your photos by content, date, location, and metadata. Type "beach" and Immich finds every photo taken at a beach. Type a date and it finds photos from that day. All of this happens on your server.

**Map view** plots your photos on a map based on GPS metadata. You can see where you were and when. Again, locally.

**Albums and collections** let you organize photos the way you want — by trip, by person, by project. Shared links let you give friends or family read-only access to specific albums without them needing an account.

### The UI: Built for Humans

Immich's interface is polished. It looks like a modern photo app, not a self-hosted project. That matters because it means your partner, your kids, your parents can use it without asking you how.

The mobile app works offline. The web interface is fast. Bulk operations (delete, tag, move to album) don't require a terminal. You can use Immich like Google Photos — because it was designed to be used like Google Photos.

## The Real Setup Cost

Immich isn't a one-click install. Here's what you actually need:

### Hardware

Immich runs in Docker. You need:

- A Linux box, NAS, or cloud VM with at least 2 GB RAM (4 GB recommended for face recognition).
- Storage for your photos. A 1 TB library needs roughly 1 TB of disk space.
- A stable network connection. Immich can run on your home network or a rented server; either works.

### Docker Setup

Immich provides a `docker-compose.yml` file. If you've run Docker before, this is straightforward:

```bash
git clone https://github.com/immich-app/immich.git
cd immich/docker
docker-compose up -d
```

If you haven't used Docker, you'll need to install it first. The official Docker docs cover this; it's a 10-minute job on most systems.

### Initial Import

If you're migrating from Google Photos, you'll need to export your library. Google Takeout gives you a ZIP file of all your photos. Immich can import them, but the process is manual — you upload the ZIP or point Immich at a folder. This is a one-time task, but it takes time proportional to your library size.

### Ongoing Maintenance

You're now responsible for:

- **Backups.** If your server dies, your photos are gone. Set up automated backups to external storage or a second server.
- **Updates.** Immich releases regularly. You'll want to keep up with security patches. `docker-compose pull && docker-compose up -d` does this.
- **Uptime.** If your server goes down, you can't access your photos. Most self-hosters accept this trade-off; some run redundant hardware.

None of this is hard. But it's not zero-friction either. You're trading Google's convenience for your own control.

## What You Get

### Privacy

Your photos never leave your server. No algorithm learns your face. No third party sees your location data. You own the hardware, you own the data.

### Unlimited Scale

Google Photos has limits (storage, API calls, processing time). Immich's limits are your hardware. With a 4 TB drive, you can store 4 TB of photos. Face recognition might take longer on a 100k-photo library, but it will finish. There's no artificial ceiling.

### Permanence

Google can change its terms, delete your account, or shut down the service. Immich is open source. If the maintainers disappear, the code is still there. You can fork it, modify it, run it forever.

### Cost

Immich is free. You pay for hardware (a NAS or a cheap cloud VM). That's it. No subscription. No per-photo fee. No upsell.

## The Honest Gotchas

### Learning Curve

If you've never self-hosted anything, Immich is a good first project — but it's still a project. You'll learn Docker, networking, backups. That's not a bad thing, but it's not nothing.

### Mobile Sync Isn't Automatic

Unlike Google Photos, Immich doesn't automatically upload photos the moment you take them. You have to open the app and tap "sync." For some people, that's a feature (you control what gets backed up). For others, it's friction.

### Face Recognition Takes Time

On a large library (50k+ photos), face recognition can take hours or days to run. It's not instant. Plan for this during off-peak hours.

### You're On Call

If your server goes down, you can't access your photos. If a backup fails, you might lose them. You're responsible for uptime and reliability. Google handles this for you; Immich makes you the operator.

## What to Do Next

Start here: https://immich.app/docs/

Read the installation guide for your hardware (Docker, Unraid, Synology, etc.). Spin up a test instance with a small library. Sync a few hundred photos from your phone. See if the workflow fits your life.

If it does, migrate your full library. If it doesn't, you've lost a few hours, not years of photos.

The self-hosting community has grown because people got tired of renting their data. Immich is proof that you don't have to. Your photo library shouldn't live in a black box. It should live where you can see it, control it, and keep it forever.
