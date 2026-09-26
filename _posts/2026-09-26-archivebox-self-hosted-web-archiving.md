---
layout: post
title: "ArchiveBox: Stop Trusting Links to Stay Alive"
date: 2026-09-26
tags:
  - self-hosting
  - privacy
  - web-archiving
author: Taylor
description: "Why self-hosters should own their web archives instead of hoping pages stay live."
---

Why self-hosters should own their web archives instead of hoping pages stay live.

## TL;DR

ArchiveBox captures full-page snapshots—HTML, JavaScript, PDFs, media—and stores them on your hardware. Feed it your browser history, bookmarks, or RSS feeds, and you have a searchable offline archive that survives link rot. Runs on a Raspberry Pi.

## Why links die, and why that should scare you

You bookmark something. You tell yourself you'll read it later. Six months pass. You click the link. 404. The site pivoted. The domain expired. The author deleted it. The page was never archived.

This is link rot, and it's everywhere. Studies show that roughly 1% of web pages disappear every year. If you've been online for a decade, half the links you saved are probably dead.

Most people treat this as inevitable—a cost of the internet. They don't. Self-hosters especially shouldn't. If you run your own infrastructure, you already understand that relying on someone else's service is a bet against time. ArchiveBox is the answer: a self-hosted web archiving engine that turns your browser history, bookmarks, and feeds into a searchable vault of full-page snapshots. You own the archive. No cloud. No Wayback Machine. No hope.

## What ArchiveBox actually captures

It's not a bookmark manager. It's not a link shortener. It's a *full-page snapshot engine*.

When ArchiveBox archives a page, it captures:

- **HTML**: The rendered DOM, exactly as it was.
- **JavaScript**: Executed and rendered—dynamic content is frozen in place.
- **PDFs, images, media**: Downloaded and stored locally.
- **Metadata**: Title, description, favicon, headers.

Take a page you archived five years ago. Open it from your ArchiveBox vault. It loads exactly as it did then—same layout, same content, same images—even if the original domain is now a casino or a phishing site.

This is not a reference. It's a replica.

## Where it gets its URLs

You don't manually feed ArchiveBox one link at a time. It ingests from everywhere:

- **Browser history**: Export from Chrome, Firefox, Safari, Edge. ArchiveBox reads the export and queues every page you visited.
- **Bookmarks**: Same—export your bookmarks file, ArchiveBox processes them.
- **Pocket, Pinboard, Instapaper**: API integrations pull your saved articles.
- **RSS feeds**: Subscribe to a feed, ArchiveBox archives every new post.
- **Plain text lists**: One URL per line.
- **Manual entry**: Paste a URL into the web UI if you want.

Most self-hosters start by dumping their browser history. ArchiveBox queues thousands of pages in seconds. You walk away. Hours or days later, depending on your hardware and internet speed, you have a searchable archive of your entire web footprint.

## Hardware and performance

ArchiveBox is not a resource hog. The project's own docs list tested deployments on:

- Raspberry Pi 4 (4GB RAM): Handles thousands of pages, archives at ~1–2 pages per minute depending on page size and media.
- NAS (Synology, QNAP): Runs as a Docker container; archive lives on the NAS storage.
- Old laptop or desktop: Perfectly fine for personal use.

The archive itself is just files on disk—HTML snapshots, PDFs, images, metadata. A typical page archive is 2–10 MB. A thousand pages might be 10–50 GB depending on media density. You control the storage.

CPU cost is real during archiving (especially if you enable screenshot capture or PDF rendering), but it's not continuous. Archive a batch of URLs overnight, then the system idles. The search UI is lightweight.

## Setting it up

ArchiveBox runs in Docker or as a standalone Python app. Here's the fastest path:

```bash
git clone https://github.com/ArchiveBox/ArchiveBox.git
cd ArchiveBox
docker compose up -d
```

Then visit `http://localhost:8000` in your browser. You'll see the web UI. From there:

1. Click **Add** and paste URLs, or upload a bookmarks file.
2. ArchiveBox queues them and starts archiving.
3. Search or browse your archive once pages are processed.

For production deployments (NAS, always-on server), the docs cover reverse proxy setup, authentication, and storage optimization. The quickstart is genuinely quick; the deep config is there if you need it.

## What to watch for

**Archiving speed depends on your internet connection and the target pages.** A page with 50 MB of embedded video will take longer to capture than a text article. ArchiveBox respects `robots.txt` by default—you can override this, but don't be rude to small sites.

**Screenshot and PDF rendering require extra dependencies.** If you want ArchiveBox to capture a screenshot of each page or render PDFs, you'll need to install Chromium and other tools. The docs walk you through it. For text-only archiving, the base install is leaner.

**Storage grows fast if you're aggressive.** If you feed ArchiveBox your entire browser history (tens of thousands of pages), you might end up with 100+ GB of archives. Plan your disk space accordingly. The UI lets you delete old archives if you need to prune.

**The search index is local.** ArchiveBox indexes pages as they're archived, so search is instant and stays on your hardware. No cloud indexing, no telemetry.

## Why this matters for self-hosters

You already know the value of owning your data. Email, calendar, photos—you run them yourself because you don't trust someone else's promises about retention or privacy. Web archiving is the same bet. The pages you've visited, the articles you've saved, the research you've done—they're part of your intellectual history. Leaving them to link rot or relying on the Wayback Machine means betting that someone else will preserve them for you.

ArchiveBox lets you stop betting. You own the archive. You control the hardware. You decide what gets archived and for how long. If you ever need to share a snapshot of a page—to prove what it said, to preserve evidence, to hand someone a copy without exposing the original URL—you have it.

## What to do next

Start with the [ArchiveBox quickstart](https://github.com/ArchiveBox/ArchiveBox#quickstart). Export your browser history, feed it to ArchiveBox, and let it run overnight. By morning, you'll have a searchable vault of your web footprint.

If you're archiving sensitive pages or want to share a snapshot with someone without leaving a trail, that's where ephemeral, encrypted file exchange fits in—[archivum-null](https://github.com/whiteravens20/archivum-null) lets you hand someone your archive snapshot without a cloud account or a record. But first: get ArchiveBox running, see what you've got, and stop losing links to rot.