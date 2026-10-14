---
layout: post
title: "OpenCloud: A Shared File Space That Follows Your Team"
date: 2026-10-14
tags:
  - self-hosting
  - privacy
  - file-sharing
  - collaboration
author: Taylor
description: "OpenCloud is an open source platform for storing, sharing and editing files together, on a server you control, with sync to laptops and phones."
---

OpenCloud is an open source platform for storing, sharing and editing files together, on a server you control, with sync to laptops and phones.

## TL;DR

[OpenCloud](https://github.com/opencloud-eu/opencloud) is a self-hosted file space for teams, schools, labs and families: upload in a browser, sync to desktop and phone apps, share by link and edit documents without leaving the browser. The server stores everything in the filesystem and needs no database. There is a public demo, so you can try it before you install anything.

## The attachment pile

Most small groups end up in one of two places. Files travel as email attachments, and a week later nobody knows which `report-final-v3.docx` is the real one. Or the group pays for a hosted cloud service and keeps its files on someone else's machine.

What the group actually needs is one place where everyone uploads, finds and shares files, including with people who are not part of the group, and where the files sit on hardware the group controls. That is the gap OpenCloud fills.

## What it is like to use

### In the browser

You open the web interface and drag files in to upload them. Keyboard shortcuts select several files at once, and any file downloads again from any browser. Search covers the whole library: by name, by full text, by OCR, and by file type, date or tag.

For a team project you create a Workspace, a dedicated project folder, so that everything belonging to the project lives in one shared place rather than in somebody's personal folder.

### On your laptop and phone

The desktop client for Windows, macOS and Linux keeps a local folder in sync with the server. Selective sync lets you choose which folders to hold locally and save disk space. On Android and iOS there is a mobile app with offline access, so the files you need on a train are already on the phone.

These clients are separate downloads from the server. The project's GitHub page links to them.

### Handing a file to someone outside

Select a file or folder, create a public link and send it. The project says people can collaborate with or without an account, which covers the client, the parent or the colleague at another organisation who will never get a login on your server.

### Editing documents in place

Documents open in the browser through the Collabora web office integration, and Markdown files open in the ToastUI Markdown editor. Every file also has a history: you can look at earlier versions and restore one when someone saves over the wrong thing. That replaces the "version chaos" the project talks about.

## Why it is worth a look

- **No database to run.** The backend stores all data in the filesystem, by default under `$HOME/.opencloud/`.
- **Sign-in is flexible.** The server ships with its own identity provider, LibreGraph Connect. If you already run something like Keycloak, OpenCloud can use it instead through OpenID Connect.
- **It speaks standard protocols.** WebDAV, the Graph API, OCS, OCM 1.1 and OpenID Connect, so it fits into an existing setup more easily than a closed system would. The project also says it runs efficiently on a Raspberry Pi and scales up to a data center. It is built as microservices.

The server is written in Go, licensed under Apache 2.0, and developed by OpenCloud GmbH, part of the Heinlein Group in Berlin.

## Running it

Start with the [public demo server](https://demo.opencloud.eu) to see the interface and click through sharing and search.

To run your own, the project points new users to its Docker Compose setup, which it describes as the full feature set including web office and full-text search. You need Docker and an identity provider, either the built-in one or an external one such as Keycloak. The steps are in the [Docker Compose guide](https://docs.opencloud.eu/docs/admin/getting-started/container/docker-compose-local), and the [getting-started page](https://docs.opencloud.eu/docs/admin/getting-started/) lists other deployment options.

Building the Go binary from source is possible too, but that is a path for development, not the way to set up a team server.

## Where it falls short

The repository holds only the server backend. Sync happens through the separate desktop and mobile apps, and editing office documents comes through the Collabora integration, so a complete setup has several parts that you install and keep updated. An identity provider is part of that picture as well, even if it is the built-in one.

Support is community-driven: the place to ask is the Matrix chat. The project's email address is for direct questions and explicitly does not handle support.

## What to do next

- Try the [demo server](https://demo.opencloud.eu).
- Follow the [Docker Compose guide](https://docs.opencloud.eu/docs/admin/getting-started/container/docker-compose-local) to run your own.
- Read the [documentation](https://docs.opencloud.eu/) or browse the [project homepage](https://opencloud.eu).
- Ask questions in the [Matrix chat](https://matrix.to/#/#opencloud:matrix.org) or in [GitHub Discussions](https://github.com/orgs/opencloud-eu/discussions).
- Follow [@OpenCloud@social.opencloud.eu](https://social.opencloud.eu/@OpenCloud) on Mastodon for updates.

*An overview based on the project's own documentation as of [v8.1.0](https://github.com/opencloud-eu/opencloud/releases/tag/v8.1.0) (2026-10-05), not a hands-on review.*
