---
layout: post
title: "Discourse: Own Your Community's Conversation Layer"
date: 2026-08-15
tags:
  - self-hosting
  - community
  - open-source
author: Taylor
description: "A modern forum platform that gives you searchable, moderated discussion without platform lock-in."
---

A better home for your community: searchable, organized, and fully yours.

## TL;DR

Discourse is a self-hosted forum that replaces Discord's ephemeral chaos and Reddit's algorithmic noise with searchable, threaded, permanent conversation. Full-text search and moderation work out of the box. Docker setup runs on a $5/month VPS.

## Why your community needs its own forum

Discord is great for real-time chat, but it's not a forum. Threads disappear into the void. Search is useless. Your community's institutional knowledge evaporates after two weeks.

Reddit gives you searchability and threading, but you own nothing. The algorithm decides what people see. One policy change, one shadowban, and your community is hostage to someone else's terms.

Discourse flips this. It's a modern discussion platform built for communities that want:

- **Searchable history.** Full-text search that actually works. Your community's knowledge stays findable.
- **Threading and organization.** Conversations stay on track. Moderators can move, split, or pin topics without friction.
- **Moderation that scales.** Flags, suspensions, category permissions—built in, not bolted on.
- **No platform tax.** No ads. No algorithmic feed. No vendor lock-in. Your data, your rules, your server.

If you're running a community—a project, a team, a user group—and you're tired of watching conversations scatter across Slack, Discord, and email, Discourse is the answer.

## How to run Discourse

### 1. Provision a server

Discourse recommends 2GB RAM minimum; 4GB is comfortable. A $5/month DigitalOcean or Linode droplet works fine for communities under 1000 active users.

```bash
# SSH into your server
ssh root@your-server-ip

# Update the system
apt update && apt upgrade -y

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add your user to the docker group (optional, avoids sudo)
usermod -aG docker $USER
```

### 2. Clone the Discourse repository

```bash
git clone https://github.com/discourse/discourse.git
cd discourse
```

### 3. Run the setup wizard

Discourse ships with a setup script that walks you through configuration:

```bash
./d/setup
```

The wizard will ask for:
- Your domain name (e.g., `forum.example.com`).
- Email address for the admin account.
- SMTP credentials (for sending notifications—use SendGrid free tier, Mailgun, or your own mail server).
- Hostname for the database container.

The script generates a `containers/app.yml` file with your settings and spins up the containers.

### 4. Point your domain

Add an A record pointing your domain to your server's IP:

```
forum.example.com  A  your-server-ip
```

Wait for DNS to propagate (usually 5–30 minutes).

### 5. Set up HTTPS

Discourse includes Let's Encrypt integration. Once DNS is live, rebuild the container to generate certificates:

```bash
./d/rebuild app
```

The script handles cert generation automatically. Your forum is now live and encrypted.

### 6. Log in and configure

Visit `https://forum.example.com`, log in with the admin account you created, and configure:
- Site name and description.
- Category structure (e.g., Announcements, General, Support, Off-topic).
- Trust levels and permissions.
- Email notification settings.

## What works out of the box

**Full-text search.** Type a keyword, get results ranked by relevance. No plugin needed.

**Moderation tools.** Flag posts, suspend users, move topics, split conversations. Moderators have granular controls without needing to SSH into the server.

**User trust levels.** New users start at Trust Level 0 (read-only or limited posting). As they participate, they earn higher trust, unlocking features like editing, creating topics, or uploading files. Spam and bad actors can't wreck your forum on day one.

**Email notifications.** Users get digests, replies, and mentions via email. Fully configurable per user.

**Mobile-friendly UI.** The default theme is responsive and modern. No 2005 forum vibes.

**Webhooks and API.** If you want to integrate Discourse with other tools (Slack, Zapier, custom bots), the API is solid.

## Gotchas

**Email is mandatory.** Discourse relies on SMTP to send notifications. If you don't configure it, users won't get replies or mentions. Use a free tier from SendGrid or Mailgun if you don't have your own mail server.

**Backups are your responsibility.** The Docker setup includes a backup tool, but you need to schedule and store them. A cron job that runs `./d/backup` weekly and ships backups to S3 or your NAS is the standard approach.

**Database is inside the container.** By default, the PostgreSQL database lives in the Docker volume. For production, consider externalizing it or ensuring your backup strategy covers it.

**Upgrades require downtime.** Running `./d/rebuild app` pulls the latest image and restarts the container. Plan for 5–10 minutes of downtime. For high-availability setups, you'd need a load balancer and multiple instances—doable, but beyond the single-server scope.

**Spam moderation is reactive.** Discourse has good spam detection, but you'll still need to monitor and moderate. Set up category permissions to limit who can post initially, then promote trusted users.

## Performance and scaling

For a community under 1000 active users, a single $5/month VPS is fine. Discourse is efficient—the Docker container uses ~300–500MB RAM at rest, more under load.

If you grow beyond that, the standard path is:
1. Upgrade to a larger single server (4GB+ RAM).
2. Move the database to a managed PostgreSQL instance (DigitalOcean, AWS RDS).
3. Add a Redis cache layer.
4. Run multiple app containers behind a load balancer.

But for most communities, the single-server setup scales to thousands of users without strain.

## What to do next

If you're ready to move your community off Discord or Reddit, start here:

1. **Read the official docs:** https://github.com/discourse/discourse/blob/main/docs/INSTALL.md covers Docker, bare-metal, and cloud deployments.
2. **Spin up a test instance.** Use a cheap VPS or your home server to try it for a week. See if the workflow fits your community.
3. **Plan your migration.** Export your existing community data (if possible), set up categories, and invite early members to test moderation and search.

Discourse is mature, well-maintained, and battle-tested by thousands of communities. The self-hosting story is real. Your forum, your data, your rules.