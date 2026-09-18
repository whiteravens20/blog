---
layout: post
title: "PrivateBin: Zero-Knowledge Pastebin — The Server Never Sees Your Paste"
date: 2026-09-18
tags:
  - self-hosting
  - privacy
  - encryption
author: Taylor
description: "How client-side encryption turns a pastebin into a tool the server can't read — and why that matters."
---

How client-side encryption turns a pastebin into a tool the server can't read — and why that matters.

## TL;DR

PrivateBin encrypts your paste in the browser with 256-bit AES before it leaves your machine; the server stores only ciphertext and never holds the key. Self-host on any PHP server (no database required), set expiration or burn-after-read, and share secrets without trusting a third party.

## Why this matters

Pastebins are a fact of life. You need to share a debug log, a config snippet, an API key, a database dump — something sensitive that shouldn't sit in email or Slack. The problem: every mainstream pastebin (Pastebin, GitHub Gist, even some internal tools) stores your data on a server you don't control, encrypted or not. The operator can read it. The hosting provider can read it. A breach exposes it. A subpoena demands it.

PrivateBin flips the model. Encryption happens in your browser, *before* the paste ever reaches the server. The server receives only ciphertext — a blob it cannot decrypt. Even the person running the PrivateBin instance has no way to read what you posted. The key stays in your browser, in the URL fragment (the part after `#`), which never leaves your machine or reaches the server logs.

That's zero-knowledge architecture. The server is dumb by design.

## How it works

### The encryption flow

1. You paste your text into the PrivateBin form.
2. Your browser generates a random 256-bit AES key.
3. Your text is encrypted with that key using AES-256-GCM (authenticated encryption).
4. The encrypted blob is sent to the server.
5. The server stores the ciphertext and returns a URL with the key in the fragment: `https://your-bin.example.com/?abc123#xyz789key`.
6. You share the URL. The recipient's browser decrypts the ciphertext using the key from the fragment.
7. The server never sees the fragment — it's client-side only.

This is why PrivateBin's privacy guarantee holds even if the server is compromised. There is no key to steal.

### Self-hosting: the setup

PrivateBin runs on any PHP 7.1+ server. No database required (though you can use one for persistence). Here's a minimal install on a Debian/Ubuntu box:

```bash
# Install PHP and dependencies
sudo apt-get install php php-gd php-mbstring php-json

# Clone PrivateBin
cd /var/www
sudo git clone https://github.com/PrivateBin/PrivateBin.git privatebin
cd privatebin

# Set permissions
sudo chown -R www-data:www-data .
sudo chmod 750 data
```

Then point your web server (nginx, Apache) at the `public` directory. If you're on shared hosting, upload the files via FTP and you're done — no compilation, no dependencies beyond PHP.

For persistence, PrivateBin can use:
- **File storage** (default): pastes stored in `data/` directory.
- **Database** (optional): MySQL, PostgreSQL, or SQLite for larger deployments.

For a single-user or small-team instance on a Raspberry Pi or a $5/month VPS, file storage is fine.

### Client-side features

All of these are handled in the browser, not on the server:

- **Expiration**: set a paste to auto-delete after 5 minutes, 1 hour, 1 day, etc. The browser calculates when to delete; the server just stores a timestamp.
- **Burn after read**: the paste deletes itself the first time someone opens it. The browser handles the deletion logic.
- **Password protection**: optional password hashed in the browser and checked client-side before decryption.
- **Syntax highlighting**: applied locally; the server never knows if you pasted Python or SQL.

This is the elegance of the design: the server is a dumb store. All the logic lives in the browser.

## Deployment scenarios

### Single-user instance

You run PrivateBin on your own VPS or home server. You're the only user. You control the server, the domain, the backups. Perfect for sharing secrets with colleagues or clients without routing through a third-party service.

```bash
# Example: nginx on a $5 VPS
sudo apt-get install nginx php-fpm
# Configure nginx to serve /var/www/privatebin/public
# Enable HTTPS with Let's Encrypt
sudo certbot certonly -d your-bin.example.com
# Restart nginx
sudo systemctl restart nginx
```

### Team instance

You host PrivateBin internally for your team. Everyone on the network can use it; the server is behind your firewall. No data leaves your infrastructure. No third-party logs your pastes.

### Public instance

You run a public PrivateBin (like `bin.example.com`) and let anyone use it. You don't see what they paste — the server stores only ciphertext. You're providing infrastructure, not a service that reads data.

## Gotchas and limits

**URL fragment is not encrypted in transit.** The `#key` part of the URL is not sent to the server, but if you share the URL over unencrypted HTTP (not HTTPS), an eavesdropper on the network can see it. Always use HTTPS.

**Browser storage is not permanent.** If you close the tab and lose the URL, you cannot recover the paste. PrivateBin has no "forgot my paste" recovery — by design. The server has no way to prove you own it.

**Large pastes.** PrivateBin is designed for snippets, not gigabytes. Encrypting and uploading a 100 MB file in the browser will be slow and may time out. For large files, use archivum-null or a dedicated file-sharing tool.

**Server-side backups.** If you self-host, backups of the `data/` directory contain encrypted pastes. They're useless without the keys (which are in the URLs), but they're still backups. Treat them like any other sensitive data.

## What to do next

Start with the [official PrivateBin installation guide](https://github.com/PrivateBin/PrivateBin/blob/master/doc/Installation.md) — it covers Docker, shared hosting, and bare-metal setups. If you're sharing files alongside text secrets, check out [archivum-null](https://github.com/whiteravens20/archivum-null) — it's zero-knowledge file sharing with the same principle: the server never knows what you're uploading, and you control the infrastructure.
