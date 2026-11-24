---
layout: post
title: "Komga: One Library for Every Comic, Manga and eBook in the House"
date: 2026-11-24
tags:
  - self-hosting
  - media-server
  - comics
  - ebooks
author: Taylor
description: "Komga turns folders of CBZ, CBR, PDF and EPUB files into one library the whole household reads from a browser, an OPDS app, Mihon or a Kobo eReader."
---

Komga turns folders of CBZ, CBR, PDF and EPUB files into one library the whole household reads from a browser, an OPDS app, Mihon or a Kobo eReader.

## TL;DR

[Komga](https://github.com/gotson/komga) is a self-hosted media server for comics, manga, BDs, magazines and eBooks. It is for anyone with a pile of reading files in folders on a disk or NAS who wants to browse and read them from any device, with separate accounts for each person in the house. Setup is covered in the installation docs on the project's website.

## A folder full of volumes

Years of collecting leave you with a directory tree: one folder per series, CBZ and CBR archives inside, a few PDFs and EPUBs mixed in. Reading means opening files one by one, or copying them to each device by hand. Then you forget which volume of a series you were on, and the copy on the tablet is not the one on the phone.

Add a partner or kids who read from the same collection and it gets messier: everyone wants different things on their device, and not everything on the disk is meant for everyone.

## What using Komga is like

You point Komga at your folders. It builds libraries and series out of your CBZ, CBR, PDF and EPUB files, and imports any metadata embedded in the files automatically.

### Browse from anything with a browser

The web UI is responsive, so the same library opens on a laptop, a tablet or a phone. You browse by library and series, and open a book in the Webreader, which has several reading modes.

### Read in the app you already like

The browser is only one way in. Komga also speaks OPDS (both v1 and v2), so any OPDS reader can connect to it. There is a Mihon extension for manga readers on Android. If you own a Kobo, Kobo Sync links the eReader to your Komga account, and KOReader Sync covers KOReader users.

### Keep it tidy

Group books into collections and read lists. If you keep ComicRack `cbl` read lists, Komga imports them. Series and book metadata can be edited in place. Books from outside your libraries can be imported straight into a series folder.

Two cleanup tools are built in: duplicate file detection, and duplicate page detection with removal of the duplicate pages.

### Share it with the household

You create an account for each person. Access is set per library, and you can add age restrictions and label restrictions on top, so a younger reader sees only what you want them to see.

When someone needs a file outside the app, they can download a single book, a whole series or a read list.

## Why it is worth a look

- **Several ways to read, one server.** Web UI, OPDS, Mihon, Kobo Sync and KOReader Sync all draw from the same library, so you don't maintain a copy per device.
- **Per-user rules.** Library access, age restrictions and label restrictions are all part of the account setup.
- **An API to build on.** Komga has a REST API, and the community has written tools and scripts that talk to it.

## Running it

Komga's own instructions live in the installation section of the documentation: [komga.org/docs/category/installation](https://komga.org/docs/category/installation). Start there for the option that fits your machine, whether that is a NAS, a home server or a desktop that stays on.

## Where it falls short

Komga organises and serves files you already have; it does not find or fetch them for you. It is also a server you run yourself, so someone in the house has to install it and keep it up. If you want to read from your phone or Kobo away from home, that is a networking question you answer on your side.

## What to do next

Read the [installation docs](https://komga.org/docs/category/installation), then browse the rest of the documentation at [komga.org](https://komga.org). The code is at [github.com/gotson/komga](https://github.com/gotson/komga), and the project has a [Discord](https://discord.gg/TdRpkDu) if you want to ask questions.

*An overview based on the project's own documentation as of [1.30.1](https://github.com/gotson/komga/releases/tag/1.30.1) (2026-11-10), not a hands-on review.*
