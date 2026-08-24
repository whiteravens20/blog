---
layout: post
title: "WriteFreely: Own Your Publishing Platform Without the Overhead"
date: 2026-08-24
tags:
  - self-hosting
  - blogging
  - fediverse
author: Taylor
description: "A Markdown-first publishing platform that strips blogging down to what matters: your words, your server, your audience."
---

Own your blog without the complexity of WordPress.

## TL;DR:
WriteFreely is a lightweight, Markdown-first blogging platform that runs on a single VPS, supports multi-user instances, and federates with the fediverse. No database tuning, no plugin sprawl, no algorithmic feed — just write and publish on your own terms.

## Why WriteFreely matters

Medium solved a real problem: writers wanted a place to publish without wrestling with WordPress. But Medium solved it by taking your audience hostage. Your readers live in Medium's feed, your analytics live behind Medium's paywall, and if Medium changes its business model tomorrow, your platform changes with it.

WriteFreely inverts that. It gives you Medium's simplicity — Markdown editor, clean interface, one-click publish — but on your server. Your readers follow *you*, not a feed algorithm. Your data stays yours. And if you want to federate with Mastodon, Pixelfed, and the rest of the ActivityPub ecosystem, your posts reach readers across the open web without a separate social strategy.

The project has 5,185 stars and a mature codebase. It powers single-author blogs, multi-writer instances, newsletters, and collaborative zines. For self-hosters, it solves a specific gap: "I want to own my publishing platform, but I don't want to run WordPress."

## What you get

**Markdown-first workflow.** Write in Markdown, publish instantly. No WYSIWYG bloat, no HTML fumbling. Collections let you organize posts into sections ("Essays," "Notes," "Project Updates") without building a taxonomy.

**Multi-user instances.** One WriteFreely server can host multiple writers, each with their own blog and audience. Invite collaborators to a shared instance, set permissions, and let them publish independently. This is where WriteFreely shines for small communities: a zine, a newsletter collective, or a team blog on a single $5/month VPS.

**Federation out of the box.** Enable ActivityPub and your blog becomes a fediverse citizen. Mastodon users can follow your blog directly from their Mastodon client. Comments federate back to your instance. No plugin, no extra configuration — it's baked in.

**No vendor lock-in.** Your posts are stored as plain text files (or in a lightweight database). Export them anytime. The codebase is open; if you want to fork it or migrate to another platform, you can.

## How to set up WriteFreely

These steps assume a fresh VPS running Ubuntu 22.04 LTS. Adjust for your distro.

### 1. Install dependencies

```bash
sudo apt update && sudo apt install -y curl wget git build-essential
```

### 2. Download and extract WriteFreely

Grab the latest release from the GitHub releases page:

```bash
cd /opt
sudo wget https://github.com/writefreely/writefreely/releases/download/v0.15.0/writefreely_0.15.0_linux_x86_64.tar.gz
sudo tar -xzf writefreely_0.15.0_linux_x86_64.tar.gz
sudo mv writefreely writefreely-app
cd writefreely-app
```

(Check the [releases page](https://github.com/writefreely/writefreely/releases) for the latest version.)

### 3. Configure the database

WriteFreely ships with SQLite by default, which is fine for a single-author blog or small instance. For a multi-user setup, MySQL or PostgreSQL is recommended.

For SQLite (minimal setup):

```bash
sudo mkdir -p /var/lib/writefreely
sudo chown -R $(whoami) /var/lib/writefreely
```

For MySQL, create a database and user first:

```bash
mysql -u root -p
```

```sql
CREATE DATABASE writefreely;
CREATE USER 'writefreely'@'localhost' IDENTIFIED BY 'your_secure_password';
GRANT ALL PRIVILEGES ON writefreely.* TO 'writefreely'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 4. Initialize WriteFreely

Run the setup wizard:

```bash
./writefreely --config config.ini
```

You'll be prompted for:
- Database type (SQLite, MySQL, PostgreSQL)
- Database connection details (if not SQLite)
- Site name and description
- Admin username and password
- Port (default 8080)

The wizard generates `config.ini`. Review it:

```bash
cat config.ini
```

### 5. Set up a reverse proxy (nginx)

WriteFreely listens on `localhost:8080` by default. Use nginx to expose it to the web:

```bash
sudo apt install -y nginx certbot python3-certbot-nginx
```

Create an nginx config:

```bash
sudo nano /etc/nginx/sites-available/writefreely
```

Paste:

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable the site and get a certificate:

```bash
sudo ln -s /etc/nginx/sites-available/writefreely /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
sudo certbot --nginx -d your-domain.com
```

### 6. Start WriteFreely

```bash
./writefreely
```

You should see:

```
[INFO] Listening on localhost:8080
```

Visit `https://your-domain.com` in your browser. You should see the WriteFreely homepage.

### 7. Create your first blog

Log in with the admin credentials you set during setup. Click "New Blog" and choose a username (this becomes your blog's URL: `your-domain.com/username`). Start writing.

### 8. Enable federation (optional)

If you want your blog to federate with Mastodon and other ActivityPub apps:

1. Log in as admin.
2. Go to Settings → Federation.
3. Toggle "Enable ActivityPub" and save.
4. Your blog's profile is now discoverable from Mastodon. Users can follow `@username@your-domain.com`.

## Gotchas and tradeoffs

**SQLite vs. a real database.** SQLite is convenient for single-author blogs and works fine for small multi-user instances. But if you're running a high-traffic collaborative instance, switch to MySQL or PostgreSQL. SQLite has write-locking limitations; concurrent posts will queue up.

**Federation is opt-in.** Enabling ActivityPub doesn't automatically federate your existing posts — only new ones. If you want Mastodon users to discover your back-catalog, you'll need to re-publish or manually share links.

**No built-in analytics.** WriteFreely doesn't track readers or pageviews (by design). If you need that, add Plausible, Fathom, or another privacy-respecting analytics tool via a custom HTML snippet in your config.

**Backups are your job.** WriteFreely doesn't have built-in backup automation. Set up a cron job to dump your database and sync to cold storage:

```bash
0 2 * * * mysqldump -u writefreely -p'your_password' writefreely | gzip > /backup/writefreely-$(date +\%Y-\%m-\%d).sql.gz
```

**Customization is limited.** WriteFreely is intentionally minimal. You can't easily add custom post types or complex taxonomies. If you need that, WordPress is still the answer.

## What to do next

Read the [WriteFreely documentation](https://writefreely.org/start) for multi-user setup, custom domains, and federation tuning. The [official demo](https://write.as) is a live WriteFreely instance — poke around to see what the interface feels like before you deploy.
