# ADR 0004 — Firefox is the default Josh OS browser

**Status:** Accepted  
**Date:** 2026-09-19  
**Scope:** Josh OS Linux-backed product track and Stage 0

## Context

The existing product image and acceptance harness were built around Chromium.
That work proves useful system behaviours, but the low-spec-first decision
changes the browser requirement.

For the Gen5 Ironlake-or-newer reference class, the project has decided to use
**Firefox** because it retains the legacy Intel VA-API path needed by this
hardware class, while the Chromium path under evaluation no longer provides
the required legacy Intel decode route.

This is a product decision. Chromium-specific implementation already merged to
the canonical JoshOS repository is evidence and salvage material, not the
future browser contract.

## Decision

**Firefox is the default browser shipped by Josh OS.**

Chromium is not part of the low-spec base-image acceptance path. It may remain
available later as an optional compatibility/application package, but it must
not define the browser APIs, persistence model or product acceptance criteria.

## What is salvaged from the Chromium harness

The following behaviours are browser-agnostic and must be retained while the
harness is adapted to Firefox:

- persistent home/profile storage across reboot;
- local deterministic media fixture and playback-progress verification;
- PipeWire/Pulse audio-sink stream verification;
- browser crash/relaunch and session-recovery testing;
- download creation, content verification and persistence;
- network, DNS, TLS and certificate preflight;
- secret-store/keyring integration as a product capability;
- two-boot persistence testing;
- the human-assisted YouTube acceptance sequence:
  boot → browser → YouTube → sign in → play video → hear sound → reboot →
  remain signed in.

Those tests should be expressed in browser-neutral terms wherever practical.

## What must be replaced

The following are Chromium implementation details and are not carried forward
as requirements:

- Chrome DevTools Protocol orchestration;
- Chromium managed-policy JSON;
- Chromium command-line feature flags;
- Chromium remote-debugging-port assumptions;
- Chromium singleton-lock cleanup;
- Chromium-specific cookie-database paths;
- `chromium --version` reporting;
- `--user-data-dir`, `--password-store` and other Chromium launcher flags.

Firefox-specific automation may replace CDP where automated browser control is
actually needed, but the acceptance contract must stay above the automation
mechanism.

## Hardware decode acceptance

On the low-spec reference machine, a successful video test must distinguish
hardware decode from CPU-only playback. A page rendering video frames is not,
by itself, proof of the low-spec requirement.

## Human boundary

Automated CI can prove packaging, startup, deterministic media playback, audio
stream creation, downloads, persistence plumbing and crash recovery.

Google/YouTube authentication and audible real-world playback on the physical
reference machine remain human-assisted acceptance tests. Tests must never
export browser cookies, passwords or tokens.

## Consequences

The existing Chromium harness is **not thrown away**. Its valuable product
tests are retained and adapted, while Chromium-specific control and policy code
is removed from the acceptance contract.

This keeps the browser decision replaceable in the future without repeating the
work on persistence, audio, downloads, crash recovery and reboot behaviour.
