---
layout: post
title: "Jitsi Meet: Video Calls on Your Own Server, Joined From a Link"
date: 2026-11-10
tags:
  - self-hosting
  - privacy
  - video-conferencing
author: Taylor
description: "You can run video calls for your team or family on your own server, and send people a link that opens in their browser."
---

You can run video calls for your team or family on your own server, and send people a link that opens in their browser.

## TL;DR

[Jitsi Meet](https://github.com/jitsi/jitsi-meet) is open source video conferencing that runs in the browser: you start a meeting, send the URL, and people join with video, audio, chat and screen sharing. It is for teams, clubs, classes and families who want to decide who runs the server and what the address looks like. You can try it on the project's free hosted instance first, then move to your own server.

## One more account everyone has to have

If you regularly need to get a group of people on a call, you probably use whichever hosted meeting service everyone already has an account with. It works, until it doesn't: the server is someone else's, the address is someone else's, and the rules change when the vendor decides they should.

That is fine for many groups. Others, such as a club, a school class or a family spread over several countries, would rather host the calls themselves, under their own address and branding, and know who runs the machine.

## What a call looks like

### Starting and joining

You open a browser, start a meeting and send the URL to the people you want. They open it in any current browser and they are in. There is nothing for them to install on a laptop. The project also lists custom, memorable meeting URLs as a feature, so the link you send does not have to be a string of random characters.

### During the call

- **Share your screen.** Show your desktop or a presentation to everyone on the call.
- **Chat.** Write in the shared chat, or start a private conversation with one person.
- **Keep a bigger group in order.** Raise hand, reactions and polls are built in.
- **Hide the room.** Turn on a virtual background when the space behind you is not meeting-ready.
- **Write together.** Open Etherpad from the meeting and edit a document with the others while you talk.

Audio is HD, using the Opus codec.

### From a phone

Participants on a phone can use the mobile browser, or the Android app (from Google Play or F-Droid) or the iOS app. Whoever you invite does not have to own a computer to join.

## Why it is worth a look

- **You can embed it.** There is a web SDK and there are native SDKs, so meetings can live inside your own web application instead of sending users elsewhere.
- **Self-hosting is a supported path.** The project ships Debian packages and a Docker setup for it.
- **End-to-end encryption has a write-up.** The project publishes a [whitepaper](https://jitsi.org/e2ee-whitepaper/) describing its implementation, and a separate [security page](https://jitsi.org/security) covers the rest.

## Running it

Start with the project's free hosted instance at [meet.jit.si](https://meet.jit.si). It shows you how a call feels before you set anything up, and it is the quickest way to find out whether your group will use it.

When you want your own, the project provides Debian packages and a Docker setup. The [devops guide in the handbook](https://jitsi.github.io/handbook/docs/devops-guide/) is where to start; follow the install steps there for the route you pick. Building every component from source is possible too, but the project describes that as a path for advanced users.

## Where it falls short

Self-hosting means monitoring, scaling and updates are yours. If you want your own branding without that work, the project's answer is [Jitsi as a Service (JaaS)](https://jaas.8x8.vc), a paid hosted service from 8x8, the company behind Jitsi. That is a different deal from running your own server, so weigh it as such.

The hosted instance also comes with a contradiction in how the project describes it. The README says you need a Google, Facebook or GitHub account to start a meeting on meet.jit.si, while the homepage says no account is needed, "ever". If "no sign-up" matters to the people you invite, settle that point before you promise it to anyone.

## What to do next

Open [meet.jit.si](https://meet.jit.si), start a meeting and send the link to one person. If it works for your group, read the [devops guide](https://jitsi.github.io/handbook/docs/devops-guide/) and the rest of the [handbook](https://jitsi.github.io/handbook/). Questions go to the [community forum](https://community.jitsi.org), and the code is in the [repository](https://github.com/jitsi/jitsi-meet). The project's page is at [jitsi.org/meet](https://jitsi.org/meet).

*An overview based on the project's own documentation as of [stable/jitsi-meet_11248](https://github.com/jitsi/jitsi-meet/releases/tag/stable/jitsi-meet_11248) (2026-09-14), not a hands-on review.*
