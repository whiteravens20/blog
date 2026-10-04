# Security — White Ravens Blog

## Reporting a vulnerability

Report vulnerabilities privately through GitHub's [private vulnerability reporting](https://github.com/whiteravens20/blog/security/advisories/new). Please do not open a public issue or pull request for a security bug.

Include the address or the file concerned, the steps that reproduce the problem and the impact you expect. You will get a first reply within a week.

## Scope

This repository holds a static Jekyll site: no backend, no forms, no accounts and no user input. The production deployment is [blog.whiteravens.net](https://blog.whiteravens.net) on GitHub Pages, built from `main`. Only that version is supported.

## What is in place

- **Nothing from third parties in the layout**: styles, fonts and the one script ship from the site itself. The only other request the layout makes is to our own visit counter.
- **Dependencies**: the gems are scanned for known vulnerabilities on every push and pull request and once a week, and a pull request cannot add one with a known high-severity vulnerability. A finding accepted as unreachable is listed in `.trivyignore` with its justification. Dependabot proposes a new version only after it has been public for a week.
- **Code**: CodeQL analyses the site's script and plugin.
- **CI/CD**: workflows run with least-privilege `permissions:`; every action is pinned to a commit SHA and checked against the tag it names; deploys use GitHub's OIDC-based Pages deployment, with no long-lived token.
