---
layout: post
title: "Paperless-ngx: Self-Hosted Document Archival That Actually Scales"
date: 2026-06-17
tags:
  - self-hosting
  - privacy
  - document-management
author: Taylor
description: "How paperless-ngx turns paper chaos into searchable evidence — OCR, full-text indexing, and thousands of documents on modest hardware."
---

Finding a document shouldn't be harder than finding a file.

## TL;DR

Paperless-ngx is a self-hosted document management system that OCRs and indexes your paper and digital documents into a searchable archive. It runs on a Raspberry Pi, keeps your records under your control, and solves the real problem: finding that receipt, contract, or medical record when you need it — without handing everything to a cloud vendor.

## Why This Matters

Every self-hoster accumulates documents. Tax returns. Lease agreements. Medical records. Insurance policies. Warranty certificates. Utility bills. The stack grows, and the question becomes: where is it?

Cloud solutions exist. Google Drive, Evernote, Microsoft OneDrive — they'll scan and search your documents for you. But they also own the index, own the metadata, own the decision about what they do with your financial and medical history. You get convenience. You lose control.

Paperless-ngx flips that trade-off. Your archive is a directory of PDFs and a database you own. Your OCR runs on your hardware. Your search index lives on your server. If you decide to migrate, export, or nuke the whole thing, you're not negotiating with a vendor — you're moving files.

For people who actually care about document retention — contractors, freelancers, anyone with a mortgage, anyone managing aging parents' records — this is the difference between "I hope I filed that somewhere" and "I know exactly where that is."

## How It Works

Paperless-ngx ingests documents three ways:

1. **Scan or photograph** paper documents and upload them.
2. **Drop digital PDFs** into a watched folder or upload via the web UI.
3. **Forward emails** with attachments (via IMAP integration).

Once a document arrives, paperless-ngx:

- Runs OCR on it (using Tesseract, open-source, runs locally).
- Extracts and indexes the full text.
- Tags it automatically or lets you tag it manually.
- Stores the original + a searchable PDF.

Then you search. Type "lease renewal 2025" and it finds every document containing those words, ranked by relevance. No folder digging. No remembering where you filed it.

## Getting Started

Paperless-ngx runs in Docker or as a systemd service. The official docs are thorough; here's the shape of a Docker setup.

### 1. Clone the Repository and Set Up Environment

```bash
git clone https://github.com/paperless-ngx/paperless-ngx.git
cd paperless-ngx
cp .env.example .env
```

Edit `.env` to set:
- `PAPERLESS_SECRET_KEY` (generate a random string)
- `PAPERLESS_ADMIN_USER` and `PAPERLESS_ADMIN_PASSWORD`
- `PAPERLESS_TIME_ZONE` (e.g., `Europe/Warsaw`)
- `PAPERLESS_OCR_LANGUAGE` (e.g., `eng+pol` for English and Polish)

### 2. Start the Services

```bash
docker-compose up -d
```

This spins up:
- The paperless-ngx application (Django backend).
- PostgreSQL (database).
- Redis (caching and task queue).
- Nginx (reverse proxy, optional but recommended).

### 3. Access the Web UI

Navigate to `http://localhost:8000` (or your server's IP). Log in with the admin credentials you set in `.env`. You'll see an empty dashboard.

### 4. Configure Document Sources

**Upload folder:** Create a directory on your host machine, mount it in the container, and paperless-ngx will watch it for new PDFs.

In `docker-compose.yml`, add a volume:

```yaml
services:
  paperless:
    volumes:
      - ./consume:/usr/src/paperless/consume
```

Drop PDFs into `./consume`, and they'll be ingested automatically.

**Email integration:** In the web UI, go to Settings → Email and add your email account. Paperless-ngx will poll it and import attachments.

### 5. Ingest Your First Document

Drop a PDF into the consume folder or upload one via the web UI. Watch the Tasks panel — you'll see OCR running. Once it completes, search for text from the document. If it finds it, OCR worked.

### 6. Tag and Organize

Create tags (e.g., "tax-2025", "insurance", "medical") and assign them to documents. You can also set up automatic tagging rules based on document content or filename patterns.

## What You Actually Get

**OCR that works.** Paperless-ngx uses Tesseract, the same engine behind Google Docs' OCR. On clean documents (printed text, decent contrast), accuracy is 95%+. Handwritten notes and faded photocopies are harder, but paperless-ngx will still index what it can.

**Search that finds things.** Full-text search means you don't organize documents — you retrieve them. Forgot which folder? Search "boiler repair 2024" and it's there.

**Runs on modest hardware.** A Raspberry Pi 4 with 4GB RAM and a USB SSD can handle thousands of documents. A NAS with a spare CPU core works fine. You don't need a server farm.

**Your data stays yours.** No syncing to the cloud. No vendor deciding to shut down the service. No surprise price increase. Your archive is a PostgreSQL database and a directory of PDFs. Export it, back it up, move it — it's all yours.

**No vendor lock-in.** The database schema is straightforward. If you ever want to leave, you can export all documents as PDFs with metadata, or write a script to migrate to another system. You're not trapped.

## Gotchas and Tradeoffs

**Setup requires comfort with Docker or systemd.** Paperless-ngx isn't a one-click installer. You need to understand environment variables, volumes, and basic container management. If that's new to you, the docs are clear, but it's not a weekend project for a non-technical user.

**OCR quality depends on document quality.** A crisp PDF of a printed page? Perfect. A photograph of a receipt taken in bad lighting? Paperless-ngx will try, but it might miss words. You can re-run OCR on a document if you improve the source, but garbage in = garbage out.

**Storage grows.** Every document gets stored as an original + a searchable PDF. A 500-page contract becomes two files. If you're archiving thousands of documents, budget for disk space. A terabyte SSD is cheap; a terabyte of cloud storage is not.

**Email integration is polling, not push.** Paperless-ngx checks your email account on a schedule (default: every 10 minutes). There's a small delay between sending an email and it appearing in your archive. For most use cases, this is fine.

**Multi-user is basic.** Paperless-ngx supports multiple users, but permissions are coarse (admin or read-only). If you need fine-grained sharing or per-document access control, this isn't it.

## What to Do Next

Read the [official documentation](https://docs.paperless-ngx.com/) — it covers installation, configuration, and advanced features (like barcode-based splitting for batch scanning). If you're running on a NAS, check the community guides for your specific hardware. Start with a small batch of documents to get a feel for how OCR and tagging work, then commit to scanning everything.

For self-hosters who care about owning their records, paperless-ngx is the answer to "where do I keep this?" It's not perfect, but it's stable, it works, and it scales to thousands of documents without breaking a sweat.