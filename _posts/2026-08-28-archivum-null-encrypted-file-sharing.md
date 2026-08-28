---
layout: post
title: "Archivum Null: Encrypted File Sharing Without the Cloud"
date: 2026-08-28
tags:
  - self-hosting
  - privacy
  - file-sharing
author: Taylor
description: "Zero-knowledge file sharing in the browser, no accounts, no cloud. Deploy on your own server."
---

Share files securely without accounts, clouds, or trusting a third-party server.

## TL;DR

Archivum Null is a self-hosted encrypted file sharing service that works entirely in the browser — files are encrypted client-side before upload, the server never sees plaintext or keys, and you deploy it with one Docker command. No accounts, no tracking, no cloud.

---

## Why This Matters

Firefox Send is dead. Croc and Magic Wormhole work, but they demand CLI on both ends. Most "secure" web uploaders want your email, your password, and your trust. Archivum Null closes that gap: it brings back the simplicity of Firefox Send — just pick a file, share a link, done — but it runs on your own hardware and never asks you to sign up.

The problem it solves is real. You need to send a document to someone. You don't want it sitting in a cloud account or a third-party server. You don't want to manage accounts or remember passwords. You want encryption that actually works: files encrypted before they leave your machine, keys that never touch the network, and a server that sees only ciphertext.

Archivum Null does exactly that. It's built for self-hosters, privacy-first users, and anyone who'd rather run their own infrastructure than trust a SaaS vendor.

---

## How It Works

### Zero-Knowledge by Design

Every file you upload to Archivum Null is encrypted in your browser using AES-256-GCM **before** it ever leaves your machine. The server receives only ciphertext — it never sees the plaintext, never sees the encryption key, never sees the original filename.

The decryption key lives in the URL fragment (the part after `#`). That fragment never leaves your browser or the recipient's browser — it's not sent to the server, not logged, not tracked. You share the full URL with someone, they visit it, their browser decrypts the file on their machine, and that's it.

This is zero-knowledge by architecture, not by marketing. The server is cryptographically blind to the content it stores.

### One-Command Deployment

Self-hosting Archivum Null takes one command:

```bash
docker compose -f docker-compose.quickstart.yml up -d
```

The service opens at `http://127.0.0.1:3000`. From there, you can:

- Upload files directly in the browser.
- Set an expiry time (how long the file stays on the server).
- Set a max download count (file deletes after N downloads).
- Generate a shareable link with the decryption key embedded.

The quickstart is meant for testing and small-scale use. For production — running it on a VPS or behind a reverse proxy — the hardening docs walk you through WireGuard tunneling, SSL setup, and Turnstile integration to prevent abuse.

### What You Get

- **No accounts.** No sign-up, no login, no email verification.
- **No tracking.** No analytics, no telemetry, no profiling.
- **No cloud dependency.** It runs on your own server, your own network, your own hardware.
- **Expiry control.** Files auto-delete after a set time or download count.
- **Browser-native.** Works in any modern browser — no plugins, no CLI tools required on the recipient's end.

---

## Getting Started

### Try the Demo

Before self-hosting, you can test Archivum Null at the working demo: **https://archivum.wrservices.link**

Upload a small file, share the link with someone, and watch it decrypt on their end. You'll see the URL fragment in action — the key is right there in the link, and the server never sees it.

### Self-Host Locally

1. **Clone the repo:**
   ```bash
   git clone https://github.com/whiteravens20/archivum-null.git
   cd archivum-null
   ```

2. **Start the service:**
   ```bash
   docker compose -f docker-compose.quickstart.yml up -d
   ```

3. **Open in your browser:**
   Navigate to `http://127.0.0.1:3000`. You'll see the upload interface.

4. **Upload a file:**
   Click "Choose File", pick something small (a text file, a PDF), and upload. The browser encrypts it before sending.

5. **Share the link:**
   Once uploaded, you'll get a shareable link with the decryption key in the fragment. Copy it and send it to someone. They visit the link, their browser decrypts the file, and they download it.

### Production Hardening

If you're running Archivum Null on a VPS or behind a reverse proxy, the `docs/HARDENING.md` file covers:

- **WireGuard tunneling:** Restrict access to your own network.
- **Reverse proxy setup:** Use nginx or Caddy to handle SSL termination and rate limiting.
- **Turnstile integration:** Add CAPTCHA-style abuse protection without tracking users.
- **Admin password:** Protect the admin panel.

Read through those docs before exposing Archivum Null to the internet. They're straightforward and assume no prior DevOps experience.

---

## Why Self-Hosting Matters Here

File sharing is a trust boundary. When you upload to a third-party service, you're trusting:

- The service not to read your files.
- The service not to sell access to your data.
- The service's infrastructure not to be breached.
- The service not to change its terms of service.

With Archivum Null on your own server, you eliminate that middle layer. You trust your own hardware, your own network, your own admin. The encryption is client-side and cryptographically sound — even if someone broke into your server, they'd find only ciphertext and no keys.

This is especially valuable if you're sharing sensitive documents, medical records, legal files, or anything you'd rather not pass through a cloud vendor's infrastructure.

---

## What to Do Next

Start with the demo at **https://archivum.wrservices.link** to get a feel for how it works. Then clone the repo and run the quickstart locally:

```bash
git clone https://github.com/whiteravens20/archivum-null.git
cd archivum-null
docker compose -f docker-compose.quickstart.yml up -d
```

Once you're comfortable with the interface, read `docs/HARDENING.md` if you plan to run it on a VPS or expose it to the internet. The docs are clear and cover everything from reverse proxy setup to abuse protection.

For development or deeper customization, the README includes an "Architecture" section that explains the encryption flow and design decisions. The project is open-source and welcomes feedback from early adopters — if you find bugs or have ideas, the GitHub repo is the place to report them.
