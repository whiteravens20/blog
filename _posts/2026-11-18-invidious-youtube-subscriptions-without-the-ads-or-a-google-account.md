---
layout: post
title: "Invidious: YouTube Subscriptions Without the Ads or a Google Account"
date: 2026-11-18
tags:
  - self-hosting
  - privacy
  - youtube
  - open-source
author: Taylor
description: "Invidious is an open source front-end to YouTube that gives you subscriptions, playlists and ad-free playback without a Google account."
---

Invidious is an open source front-end to YouTube that gives you subscriptions, playlists and ad-free playback without a Google account.

## TL;DR

[Invidious](https://github.com/iv-org/invidious) is an open source front-end to YouTube: you watch on an Invidious site instead of youtube.com, with no ads in front of the video. Subscriptions and playlists live on the Invidious side, so you don't need a YouTube account to keep a list of channels. It is for anyone who watches YouTube regularly and is tired of the ads and the tracking. You can start on a public instance or host your own.

![Image from the Invidious README](/assets/posts/invidious-youtube-subscriptions-without-the-ads-or-a-google-account.png)
*Image from the [Invidious README](https://github.com/iv-org/invidious#readme), AGPL-3.0.*

## The trade you make to follow a channel

YouTube wants three things from a regular viewer: your attention for the ads, your habits for the tracking, and a Google account so it can remember which channels you follow. People handle this in a few ways. They put up with all of it. They keep a throwaway Google account just for the subscription list. Or they stop following channels and rely on whatever the homepage suggests.

Invidious takes a different route. It is a separate front-end that shows you YouTube's videos and keeps the list of channels on its own side.

## What using it is like

### Open an instance and watch

An Invidious site is called an instance. The project keeps a [list of public instances](https://instances.invidious.io); pick one, open it, and search for a video or a channel. There is no sign-up step before you can watch. The video plays in the Invidious player with no ad in front of it, and the pages work with JavaScript turned off.

### Subscribe and make playlists

When you want a feed of the channels you follow, you subscribe on the instance. Subscriptions are stored there, not at Google, and you get notifications for all the channels you subscribe to. Playlists work the same way: you build them on the instance, with no YouTube account behind them.

### Bring your list with you

You don't have to rebuild your channel list by hand. Invidious imports subscriptions from YouTube, NewPipe and FreeTube, and watch history from YouTube and NewPipe. Going the other way, you can export subscriptions to NewPipe and FreeTube. It also imports and exports its own user data, so moving between instances is possible.

### Listen instead of watch

Audio-only mode is there for the times you only want the sound, and on mobile it keeps playing in the background.

### Make it yours

Preferences covers the basics: a light or dark theme, the interface language, and the layout of the homepage. The interface is translated into many languages by volunteers through Weblate.

## Why it is worth a look

- **It doesn't lean on YouTube's official APIs**, and the project describes itself as lightweight. It is licensed AGPL-3.0.
- **Other tools can build on it.** There is a documented [REST API](https://docs.invidious.io/api/) and support for embedded videos.
- **Shared links can open there.** A browser extension such as [Privacy Redirect](https://github.com/SimonBrazell/privacy-redirect#get), which the project recommends, redirects YouTube URLs to an Invidious instance, so a link a friend sends opens on Invidious instead of youtube.com. The [list of applications and extensions](https://docs.invidious.io/applications/) has more.

## Running it

The quickest way is not to run anything: choose a public instance from the [instances list](https://instances.invidious.io) and start watching. We run one ourselves for our community, at [invid.wrservices.link](https://invid.wrservices.link), with no ads and no Google account.

To host your own, the project's [installation instructions](https://docs.invidious.io/installation/) are the place to start. They cover the steps for setting up your own instance.

## Where it falls short

Public instances are run by third parties, and the project takes no responsibility for them. Whoever runs the instance you use sees your requests, so choosing one is a matter of trust. Hosting your own removes that question, but it makes you the admin.

The bigger catch is where the video comes from. By default, the stream still comes straight from Google's servers, so Google sees the viewer's address. This is true on our instance too. If you don't want that, turn on **Proxy videos** in Preferences, and the video is fetched through the instance instead.

The project also reminds users to follow the rules of their own country and refuses liability for misuse such as illegal downloading.

## What to do next

Pick an instance from the [public list](https://instances.invidious.io), or try ours at [invid.wrservices.link](https://invid.wrservices.link), and import your subscriptions. If you want your own, the [installation guide](https://docs.invidious.io/installation/) is next. The [FAQ](https://docs.invidious.io/faq/) and the [documentation](https://docs.invidious.io/) cover the rest, and the project's chat is on [Matrix](https://matrix.to/#/#invidious:matrix.org). You can also follow it on the Fediverse at [@invidious@social.tchncs.de](https://social.tchncs.de/@invidious). The code is at [github.com/iv-org/invidious](https://github.com/iv-org/invidious), and the project's site is [invidious.io](https://invidious.io).
