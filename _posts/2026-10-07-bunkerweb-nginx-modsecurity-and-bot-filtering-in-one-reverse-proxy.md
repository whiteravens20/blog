---
layout: post
title: "BunkerWeb: NGINX, ModSecurity and Bot Filtering in One Reverse Proxy"
date: 2026-10-07
tags:
  - self-hosting
  - security
  - docker
  - waf
author: Taylor
description: "BunkerWeb puts NGINX, ModSecurity with the OWASP Core Rule Set, rate limits, bot challenges and Let's Encrypt behind one reverse proxy driven by settings."
---

BunkerWeb puts NGINX, ModSecurity with the OWASP Core Rule Set, rate limits, bot challenges and Let's Encrypt behind one reverse proxy.

## TL;DR

[BunkerWeb](https://github.com/bunkerity/bunkerweb) is an open-source (AGPLv3) web application firewall built on NGINX. You put it in front of your web apps as a reverse proxy and configure it with a flat list of settings. The plain Docker setup needs the container recreated on every config change; the autoconf image is what fixes that.

## Why one proxy instead of five parts

A self-hosted WAF is usually assembled: NGINX for proxying, ModSecurity and a rule set for filtering, something for rate limits, certbot for certificates, a separate answer for bots. Each piece works, and each piece is one more config file to keep in sync.

BunkerWeb packages those parts as a single web server that sits between the internet and your apps. What comes in the box:

- Integrated **ModSecurity** with the **OWASP Core Rule Set**
- **Automatic bans** for clients that trigger suspicious HTTP status codes
- **Connection and request limits** per client
- **Bot challenges**: cookie, JavaScript, captcha, hCaptcha or reCAPTCHA
- **Blocking of known bad IPs** through external blacklists and DNSBL
- **HTTPS** with Let's Encrypt automation, plus security headers and TLS hardening

The project runs a demo site, [demo.bunkerweb.io](https://demo.bunkerweb.io/), and invites visitors to attack it. If you want to see what the filters do before you install anything, that is the place to poke.

## How it is put together

### Settings, not config files

You configure BunkerWeb with settings: `NAME=value` pairs such as `AUTO_LETS_ENCRYPT` or `USE_ANTIBOT`. The project's own example:

```conf
SERVER_NAME=www.example.com
AUTO_LETS_ENCRYPT=yes
USE_ANTIBOT=captcha
REFERRER_POLICY=no-referrer
USE_MODSECURITY=no
USE_GZIP=yes
USE_BROTLI=no
```

Note `USE_MODSECURITY=no` in there: ModSecurity is a feature you switch, so check what your configuration actually has enabled.

By default BunkerWeb serves a single application and every setting applies to it. Turn on **multisite mode** and one instance serves several apps, each identified by its server name and carrying its own settings. A setting is attached to one app by prefixing it with that app's primary server name:

```conf
www.example.com_USE_ANTIBOT=captcha
myapp.example.com_USE_GZIP=yes
```

Some settings come in numbered groups, for example `REVERSE_PROXY_URL_1=/subdir` paired with `REVERSE_PROXY_HOST_1=http://myhost1`, then `_2` for the next upstream.

When settings are not enough, custom configurations let you drop in raw NGINX config (in the HTTP or server context) and custom ModSecurity config. The second one is how you deal with false positives or add your own rules. Beyond that there is a plugin system. The maintained plugins include ClamAV and VirusTotal scanning of uploads, Discord, Slack and webhook notifications, and Coraza as an alternative to ModSecurity.

### The scheduler and the database

BunkerWeb is more than an NGINX process. A service called the scheduler stores your settings and custom configs in a database, runs periodic jobs, generates the configuration BunkerWeb understands, and acts as the go-between for the web UI and autoconf. The database can be SQLite, MariaDB, MySQL or PostgreSQL. It holds settings, custom configs, the list of instances, job metadata and cached files.

The optional web UI sits on top of this. It shows blocked attacks, lets you edit settings and custom NGINX/ModSecurity configs, restart or reload the instance, install plugins, read logs and monitor jobs. A read-only demo is at [demo-ui.bunkerweb.io](https://demo-ui.bunkerweb.io/).

### Where it runs

The project calls these "integrations" rather than installs, and supports six:

- **Docker**: prebuilt images for x64, x86, armv7 and arm64 on Docker Hub. The setup is environment variables for the settings, a scheduler container, and networks that expose ports to clients and reach your upstream services.
- **Docker autoconf**: the same, with a container that watches Docker events (more below).
- **Swarm**: autoconf listens for Swarm service events and configures instances without downtime.
- **Kubernetes**: autoconf acts as an Ingress controller, reads Ingress resources and ConfigMaps, and there is an official Helm chart in [bunkerity/bunkerweb-helm](https://github.com/bunkerity/bunkerweb-helm).
- **Linux**: packages for Debian 12 and 13, Ubuntu 22.04, 24.04 and 26.04, Fedora 43 and 44, and RHEL, CentOS, Rocky Linux and AlmaLinux 8, 9 and 10.
- **Microsoft Azure**: an Azure Marketplace listing and an ARM template.

The install steps for each live in the [integrations documentation](https://docs.bunkerweb.io/1.6.15/integrations/), and the project's quickstart guide covers first configuration of a protected service.

## Gotchas

**The simple Docker setup is not the convenient one.** With plain Docker you pass settings as environment variables, and the container has to be recreated every time one changes. That is workable for a set-and-forget single app and tedious for a homelab where you add services every few weeks. The answer is the separate **autoconf** image: it listens for Docker events and reconfigures BunkerWeb live. Instead of environment variables on the BunkerWeb container, you put labels on your application containers. On Swarm the labels use a `bunkerweb.` prefix. The tradeoff is one more moving part.

**Defaults are a floor.** The out-of-the-box values give minimal protection, and the maintainers strongly recommend tuning them. Tuning is also how you handle false positives: a CRS-based WAF in front of real apps will block something legitimate sooner or later, and the fix is a custom ModSecurity config, not turning the engine off. The documentation's security tuning section is where to start.

**Not everything documented is open source.** There is a PRO edition with a 30-day trial and a license key you paste into the web UI or a setting. PRO features are marked with a crown in the documentation and the UI, so look for it before you plan around a feature. There is also BunkerWeb Cloud, a managed offering for people who do not want to host an instance at all.

**AGPLv3.** The core is free software under the AGPL. That matters if you plan to modify it and expose the result to others.

## What to do next

Start with the [live demo](https://demo.bunkerweb.io/) to see the filters at work, then pick your integration in the [integrations documentation](https://docs.bunkerweb.io/1.6.15/integrations/). If you run Docker, go straight to autoconf. The code, issues and releases are in the [repository](https://github.com/bunkerity/bunkerweb), and the project's homepage is [bunkerweb.io](https://www.bunkerweb.io).

*An overview based on the project's own documentation as of [v1.6.15](https://github.com/bunkerity/bunkerweb/releases/tag/v1.6.15) (2026-09-21), not a hands-on review.*
