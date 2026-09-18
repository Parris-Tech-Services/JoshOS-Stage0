# ADR-0001: Linux kernel underneath for stage 1

**Status:** accepted
**Date:** 2026-09-18

## Context

The long-term vision includes a Josh kernel. The question is whether to write it
first, or last.

Evidence from comparable projects:

- **Haiku** — started 2001, has a community, funding and Google Summer of Code
  students. Released R1/beta6 in August 2026. Twenty-five years, still beta.
- **ReactOS** — started in the 90s, released 0.4.16 in September 2026.
- **SerenityOS** — the closest comparison: one very skilled full-time developer
  building a Unix-like OS with its own GUI from scratch. The browser he wrote
  for it had to be spun out into **Ladybird**, now a funded non-profit backed by
  Shopify and a GitHub co-founder, which reached public alpha only in 2026.

The pattern is consistent: the kernel is not what takes the decades. Drivers,
graphics stacks and a browser are. An OS with no wifi, no GPU acceleration and
no browser is not usable, regardless of how good the kernel is.

## Decision

Stage 1 ships on the Linux kernel. Everything the user experiences — compositor,
shell, settings, applications, visual language, installer, ISO — is Josh OS.

Precedent: ChromeOS, Android, SteamOS and elementary OS are all genuinely
distinct operating systems with their own identity. None of them wrote a kernel.

## Consequences

**Good:** a usable desktop exists early. Hardware support is free. Every stage
is bootable, so the project survives contact with real life.

**Bad:** "not a real OS" from purists. Some Josh concepts will fight Linux
assumptions — that friction is the signal for what stage 2 should replace.

**Preserved:** stage 3 still writes an experimental kernel. Owning the userland
first means there's something for it to run.
