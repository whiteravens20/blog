---
layout: post
title: "Strapi: Headless CMS That Runs on Your Server"
date: 2026-08-07
tags:
  - self-hosting
  - cms
  - developer-tools
author: Taylor
description: "Define content models in code, expose via REST or GraphQL, keep your data on your infrastructure."
---

Own your content — a self-hosted headless CMS built for developers.

## TL;DR 

Strapi is a headless CMS built in JavaScript that lets you define content schemas in code, version them in Git, and deploy them like any other app. You get REST and GraphQL out of the box, your frontend stays independent, and your data never leaves your server. If you've been trapped in SaaS CMS pricing tiers, this is the escape route.

## Why Strapi matters

Most CMSes are monoliths: they own the frontend template layer, they own the database schema UI, they own your data location. You pay per seat, per API call, per gigabyte of bandwidth. Strapi inverts that. It's a content engine, not a publishing platform. You define your content structure in code, commit it to Git, and let your frontend—whether it's a static site, a mobile app, or a custom dashboard—pull data however it needs to.

The self-hosting angle is not incidental. Strapi runs on your infrastructure: your server, your database, your backup strategy. No vendor harvesting your analytics. No surprise bill when traffic spikes. No account suspension because an automated system flagged something. You own the whole stack.

The honest weakness: Strapi is a developer tool. If your team needs a point-and-click interface to manage content without writing code, this is not it. You will customize Strapi by writing code. That's the tradeoff for control.

## How Strapi works

### 1. Set up Strapi on your server

Start with a fresh Node.js environment (Strapi requires Node 18+). You can self-host on any Linux box, Docker, or managed Node platform.

```bash
npm create strapi@latest my-cms
cd my-cms
npm run develop
```

This spins up the Strapi admin panel on `http://localhost:1337/admin`. You'll create an admin account on first login.

### 2. Define content models in code

Instead of clicking through a UI to build schemas, you write them. Strapi generates the boilerplate, and you version it in Git.

Create a new content type (called a "Collection Type" in Strapi) by adding a file:

```bash
touch src/api/article/content-types/article/schema.json
```

Define the schema:

```json
{
  "kind": "collectionType",
  "collectionName": "articles",
  "info": {
    "singularName": "article",
    "pluralName": "articles",
    "displayName": "Article"
  },
  "options": {
    "increments": true,
    "timestamps": true
  },
  "pluginOptions": {},
  "attributes": {
    "title": {
      "type": "string",
      "required": true
    },
    "slug": {
      "type": "uid",
      "targetField": "title"
    },
    "body": {
      "type": "richtext",
      "required": true
    },
    "publishedAt": {
      "type": "datetime"
    },
    "author": {
      "type": "relation",
      "relation": "manyToOne",
      "target": "plugin::users-permissions.user"
    }
  }
}
```

Restart Strapi, and the schema is live. No UI-driven drift. Your schema is version-controlled, reviewable, and deployable like code.

### 3. Expose data via REST or GraphQL

Strapi generates both automatically. No extra configuration.

**REST endpoint:**

```bash
curl http://localhost:1337/api/articles
```

Response:

```json
{
  "data": [
    {
      "id": 1,
      "attributes": {
        "title": "Getting Started with Strapi",
        "slug": "getting-started-with-strapi",
        "body": "...",
        "publishedAt": "2026-07-31T10:00:00Z",
        "author": { "data": { "id": 1, "attributes": { "username": "taylor" } } }
      }
    }
  ],
  "meta": { "pagination": { "page": 1, "pageSize": 25, "total": 1 } }
}
```

**GraphQL endpoint:**

```bash
curl -X POST http://localhost:1337/graphql \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ articles { data { id attributes { title slug publishedAt } } } }"
  }'
```

Your frontend chooses the protocol. A static site generator might pull via REST and build at deploy time. A mobile app might query GraphQL for real-time updates. A dashboard might use webhooks. One CMS, many frontends.

### 4. Deploy to your infrastructure

Strapi is a Node.js app. Deploy it like any other: Docker, systemd, PM2, Kubernetes, whatever fits your setup.

**Docker example:**

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
EXPOSE 1337
CMD ["npm", "run", "start"]
```

Build and run:

```bash
docker build -t my-strapi .
docker run -p 1337:1337 -e DATABASE_URL=postgresql://... my-strapi
```

Use a reverse proxy (nginx, Caddy) to handle HTTPS and domain routing. Strapi itself doesn't need to be exposed directly.

## Gotchas and tradeoffs

**Database dependency:** Strapi needs a database (PostgreSQL, MySQL, SQLite, MariaDB). SQLite is fine for testing; for production, use PostgreSQL. You own the backup strategy.

**Plugin ecosystem:** Strapi has plugins for common tasks (auth, email, upload). Some are free, some are paid. Evaluate before committing to a paid plugin — you might write the feature yourself faster.

**Learning curve for non-developers:** If your content team doesn't code, they'll need training on how schemas work and how to request changes. This is not a weakness of Strapi; it's a statement that Strapi is built for teams with technical depth.

**Customization is code:** Want a custom field type? You write a plugin. Want to hook into the publish workflow? You write middleware. This is powerful, but it means your Strapi instance is a codebase you maintain, not a black box you configure.

## What to do next

Clone the Strapi repo and follow the [official quickstart](https://docs.strapi.io/dev-docs/quick-start). Spend an hour building a simple blog schema and querying it via REST and GraphQL. If you've been looking for a CMS that treats content as data and lets you own the delivery layer, Strapi is worth the experiment.

For the full self-hosting setup, see the [Strapi deployment docs](https://docs.strapi.io/dev-docs/deployment).
