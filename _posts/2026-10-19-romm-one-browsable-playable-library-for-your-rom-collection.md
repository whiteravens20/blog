---
layout: post
title: "RomM: One Browsable, Playable Library for Your ROM Collection"
date: 2026-10-19
tags:
  - self-hosting
  - gaming
  - emulation
author: Taylor
description: "RomM turns a messy folder of ROMs into one browsable library that plays in the browser and syncs saves between your devices."
---

RomM turns a messy folder of ROMs into one browsable library that plays in the browser and syncs saves between your devices.

## TL;DR

[RomM](https://github.com/rommapp/romm) is a free, self-hosted app that scans the game files you already have, adds cover art and details, and lets you browse and play the collection from a web page. It is for anyone who plays on emulators and is tired of file names as a catalogue and saves stuck on one device. Try the live demo first; running your own starts with the project's Quick Start Guide.

## The situation: a pile of files and saves in the wrong place

If you play on emulators, your collection probably lives in several places: a folder on the desktop, an external drive, an SD card in a handheld. The only catalogue is the file name, and every console has its own emulator with its own setup.

Then there are saves. You play for an hour on the handheld, sit down at the PC later, and the progress is on the other device. Syncing by hand works until you forget once.

RomM is built for that mess: one library for the whole collection, on your server, for you or for the household.

## What it is like to use

### Scan, and get a library

You point RomM at your ROM folder and run a scan. Each game comes back with cover art, screenshots and details pulled from metadata providers such as IGDB, ScreenScraper, LaunchBox and MobyGames. You can add custom artwork from SteamGridDB and track achievements from RetroAchievements. The result is a browsable library instead of a list of files. Multi-disk games, DLCs, mods, hacks and manuals are handled too, and the platform list runs past 400, from consoles to arcade and computers.

### Play in the browser

Open a game and play it. Many games run in the browser with EmulatorJS, and Flash games with Ruffle. The project also lists js-dos, PICO-8 and EasyRPG as built in. Nothing to install on the client.

### Saves that follow you

Saves and states sync across your devices, with conflict resolution when two devices disagree. The project says saves written in the browser upload within seconds. RetroArch Cloud Sync and ES-DE and Pegasus exports are on the project's list as well. The [saves and states docs](https://docs.romm.app/latest/using/saves-and-states/) explain how it works.

### Patch a romhack or translation

A built-in [ROM patcher](https://docs.romm.app/latest/using/rom-patcher/) applies romhacks and fan translations, so you don't need a separate patching tool.

### Share it with the household

RomM has [per-user permissions](https://docs.romm.app/latest/administration/users-and-roles/), parental controls and [OIDC single sign-on](https://docs.romm.app/latest/administration/oidc/), with providers such as Authelia, Authentik and Keycloak. Everyone gets their own account on one shared library.

### Take it to other screens

Three official apps carry the library beyond the browser:

- **Argosy** on Android handhelds (Anbernic, Retroid Pocket, Odin and similar) has a gamepad-first interface. It downloads games on demand, syncs saves and tracks achievements.
- **Grout** is a lightweight client for handheld custom firmwares: Allium, Batocera, Knulli, MinUI, muOS, NextUI, Onion, ROCKNIX, Spruce and TrimUI. It downloads games, box art and BIOS files wirelessly and syncs saves as you play.
- **The Playnite plugin** adds your RomM collection to Playnite on Windows.

Pairing a device with the server works with a QR code in Argosy and the Playnite plugin.

## Why it is worth a look

- **Metadata and reach.** Ten-plus metadata providers and more than 400 platforms mean the library looks finished, not half-labelled.
- **Saves are the point.** Sync with conflict resolution is part of the core app, not an afterthought.
- **Free, no strings.** RomM is AGPL-3.0, with no paid features, and the project says there is no tracking and your data stays on your server.

## Running it

Start with the [live demo](https://demo.romm.app/). It shows the library and the in-browser player without setting up anything.

To run your own, the project's route is its [Quick Start Guide](https://docs.romm.app/latest/Getting-Started/Quick-Start-Guide/). If setup goes wrong, the docs have a [troubleshooting page](https://docs.romm.app/latest/Troubleshooting/Scanning-Issues/) for scanning problems.

If you would rather not wire up the stack yourself, the project points to a hosted deploy on Hostinger, starting at $6.49/mo, with a [setup guide](https://docs.romm.app/latest/install/hostinger/). Signups through the project's link send a share of the revenue back to the project.

## Where it falls short

The official apps cover Windows (Playnite), Android handhelds and Linux-based handheld firmwares. Clients for iOS, macOS, Steam Deck and Android TV exist, but community members make them, and the team says it does not regularly review their source code. If one of those is your main screen, you are relying on third-party work.

## What to do next

Open the [demo](https://demo.romm.app/) and click through a library. If it fits, follow the [Quick Start Guide](https://docs.romm.app/latest/Getting-Started/Quick-Start-Guide/) to run your own. The project's home is [romm.app](https://romm.app), the code is at [github.com/rommapp/romm](https://github.com/rommapp/romm), and questions go to the [Discord](https://discord.gg/invite/romm).

*An overview based on the project's own documentation as of [5.4.0](https://github.com/rommapp/romm/releases/tag/5.4.0) (2026-10-10), not a hands-on review.*
