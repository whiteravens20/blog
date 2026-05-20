---
layout: post
title: "archivum-null: Why Immutable Storage Matters for Legal Evidence"
date: 2026-05-20
tags: [archivum-null, privacy, legal-tech, zero-trust, self-hosting, evidence]
author: Taylor
description: >
  Legal teams need chain-of-custody proof that cloud providers can't give.
  archivum-null is a forensic-grade, zero-trust file relay that restores
  custody by design — not by promise.
---

## TL;DR

Cloud e-discovery platforms ask you to trust a third party with your client's
sensitive files. That breaks chain-of-custody requirements the moment a subpoena
lands on the provider's desk. **archivum-null** is a self-hosted, zero-trust file
relay: the server never sees plaintext, never holds encryption keys, and stores
only cryptographically sealed blobs with immutable metadata. You keep data
jurisdiction, you keep custody, and you keep the audit trail. *(The commands
below are drawn from the project's documentation; I have not executed them in a
live environment.)*

---

## The Problem: Cloud Archival vs. Chain of Custody

When a legal team prepares evidence for discovery, every hand-off must be
documented. Who touched the file? When? Did it change? Courts in the EU and the
US have repeatedly rejected evidence when the chain is ambiguous.

Commercial cloud storage — even with "enterprise encryption" — fails this test at
three points:

1. **Third-party control.** The provider holds the infrastructure. A subpoena,
   warrant, or national-security letter can compel disclosure without your
   knowledge. GDPR Article 32 mandates "appropriate technical and organisational
   measures" to protect personal data; handing the keys to a US cloud operator
   under the CLOUD Act is a tension many firms simply ignore.

2. **No native audit proof.** Most platforms offer activity logs, but those logs
   are themselves mutable by the provider. If the log can be altered, it is not
   evidence — it is a courtesy note.

3. **Jurisdiction roulette.** Your client's data may be replicated across
   regions with conflicting discovery rules. You cannot reliably assert privilege
   when you do not know which legal regime applies.

The result: firms either accept an unprovable chain of custody, or they bolt
expensive e-discovery appliances onto already-expensive cloud contracts.

---

## How archivum-null Works: Encryption First, Relay Second

archivum-null is not a cloud storage service. It is a **relay**: a temporary
holding point between sender and receiver where the operator is mathematically
incapable of reading the payload.

### Architecture at a Glance

```
┌──────────────────────────────────────────────┐
│  Sender Browser                              │
│  1. Select file                              │
│  2. Generate AES-256-GCM key (WebCrypto)     │
│  3. Encrypt file client-side, chunk-by-chunk │
│  4. Upload ciphertext to relay               │
│  5. Receive vault URL with key in fragment   │
│     (fragment is NEVER sent over HTTP)       │
└──────────────────────────────────────────────┘
               │  HTTPS (encrypted blobs only)
               ▼
┌──────────────────────────────────────────────┐
│  archivum-null Relay                         │
│  Stores: vault_id, ciphertext, timestamps,   │
│          download limits                     │
│  NEVER stores: keys, plaintext, filenames,   │
│                identity, persistent IP logs  │
└──────────────────────────────────────────────┘
```

The URL fragment (`#BASE64_KEY.BASE64_FILENAME`) is the critical detail.
Browsers do not include the fragment in HTTP requests. The key lives entirely in
the sender's and receiver's browsers. A server compromise yields only
indistinguishable ciphertext.

### Step-by-Step Evidence Flow

1. **Client-side encryption.** Before a single byte leaves the laptop, the file
   is split into 5 MB chunks. Each chunk is encrypted with AES-256-GCM using a
   unique IV and the chunk index as Additional Authenticated Data (AAD). This
   prevents reordering attacks — if an attacker shuffles chunks, decryption
   fails.

2. **Zero-knowledge upload.** The relay receives only ciphertext and vault
   configuration (TTL, max downloads). It cannot derive the plaintext even with
   full physical access to the disk.

3. **Tamper-evident download.** When the recipient opens the vault URL, the
   browser downloads the ciphertext, decrypts it locally, and compares the
   decrypted filename against the one encoded in the URL fragment. A mismatch
   triggers an explicit tamper warning.

4. **Ephemeral expiry.** Vaults auto-delete after a configurable TTL (default 24
   hours, max 7 days) or after exhausting their download limit. No forensic
   residue sits on the server indefinitely.

5. **Immutable metadata.** While the file content is encrypted, the relay logs
   creation time, expiry, and download count are plain metadata. Because the
   operator does not possess the decryption key, these logs describe an
   indistinguishable blob — proving *that* a transfer occurred, *when* it
   occurred, and *how many times* it was accessed, without revealing *what* was
   transferred.

---

## Immutable Logs as Audit Evidence

What does the relay log actually prove in court? It proves **bounded possession**.

The metadata record shows:

- A vault was created at `2026-05-20T09:14:00Z`.
- It expired at `2026-05-21T09:14:00Z`.
- It was downloaded exactly twice.
- The blob size was 4.2 MB.

Because the operator cannot decrypt the blob, the log does not reveal the
filename, the parties' identities, or the file's content. But it does provide a
**tamper-resistant timeline**: the server cannot forge a download count it did
not observe, and it cannot retroactively alter the creation timestamp without
invalidating its own database integrity.

For legal teams, this is the sweet spot. You can demonstrate to a court that a
4.2 MB package was transmitted at a specific time, without exposing the package's
contents to the relay operator. Contrast this with conventional cloud storage,
where the provider's logs are a black box you are contractually forbidden to
audit.

---

## Deploying in Ten Minutes (Docker Compose)

If your firm already runs a VPS and a reverse proxy, archivum-null slots in as a
private service behind a WireGuard tunnel.

**1. Clone and configure:**

```bash
git clone https://github.com/whiteravens20/archivum-null.git
cd archivum-null
cp .env.example .env
```

**2. Edit `.env` with production minimums:**

```bash
ADMIN_PASSWORD=<generate with openssl rand -base64 32>
HOST_BIND_ADDRESS=<your WireGuard tunnel IP>
# Optional: add Cloudflare Turnstile keys for abuse protection
```

**3. Start the container:**

```bash
docker compose pull && docker compose up -d
```

**4. Validate posture:**

```bash
./scripts/check-deployment.sh --tunnel-iface wg0
```

The script confirms that port 3000 is bound only to the tunnel interface, that
the container runs as non-root with a read-only filesystem, and that no egress
paths exist for a compromised container to phone home.

For a bare-metal or Proxmox LXC route, the project also ships a one-line
installer:

```bash
bash -c "$(wget -qLO - https://github.com/whiteravens20/archivum-null/raw/main/scripts/install-lxc.sh)"
```

---

## Gotchas and Honest Limits

**Not legal advice.** This post explains technical architecture, not regulatory
compliance strategy. Always consult qualified counsel before substituting a
tool for an existing e-discovery workflow.

**Client-side trust boundary.** The zero-knowledge guarantee evaporates if the
sender's or receiver's device is compromised. A malicious browser extension can
read the URL fragment. State-level adversaries with client access are outside
the threat model. Protect endpoints first.

**Compromised server serving bad JavaScript.** If an attacker gains control of
the relay and serves a modified frontend, they could exfiltrate keys. Mitigate
this by pinning known-good releases, running integrity checks, and keeping the
admin panel behind a strict IP allowlist.

**No built-in long-term archival.** Vaults are intentionally ephemeral. For
cases requiring multi-year retention, export decrypted files to a
write-once-read-many (WORM) storage tier after receipt.

**TLS is mandatory.** WebCrypto requires a secure context. Without HTTPS (or
`localhost` for development), encryption routines refuse to initialise. Plan
for a reverse proxy with valid certificates.

**Jurisdiction still matters.** Self-hosting keeps the physical disk under your
control, but the data inside the encrypted blob may still be subject to discovery
orders directed at the sender or receiver. The relay's inability to decrypt does
not create attorney-client privilege where none existed.

---

## Wrap-Up: Custody by Design, Not by Promise

Legal technology is full of vendors who promise "secure" and "compliant"
archives while retaining the master keys. archivum-null inverts that model. By
placing encryption entirely in the browser, by treating the server as a
blind courier, and by making every vault ephemeral and tamper-evident, the tool
gives legal teams something cloud providers cannot sell: **a chain of custody
anchored in mathematics, not in a terms-of-service clause.**

If you handle sensitive discovery, privilege review, or cross-border data
transfers, try archivum-null on a private homelab. Star the repo, open an issue
with your compliance use-case, or contribute a hardening guide for your
jurisdiction. The project is open source, privacy-first, and maintained under
the White Ravens non-profit umbrella — no accounts, no tracking, and no
permission required.

*Disclaimer: This article is for informational purposes only and does not
constitute legal advice. Consult a qualified attorney before deploying any
technology in a regulated legal workflow.*
