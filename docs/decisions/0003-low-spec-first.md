# ADR 0003 — Low-spec-first reference hardware

**Status:** Accepted  
**Date:** 2026-09-19  
**Scope:** Josh OS Linux-backed product track and Stage 0 acceptance baseline

## Context

Josh OS needs one deliberately modest reference class so product decisions are
tested against constrained hardware instead of being accidentally optimised for
modern developer machines.

The Compaq 610 remains valuable for firmware and boot-path work, but its
GM45/GMA 4500-era graphics platform does not meet the project's H.264
hardware-decode requirement for the browser/video milestone. Making it the
product-performance reference would force the desktop and browser programme to
optimise around a video-decode limitation that is older than the intended
minimum product baseline.

## Decision

The low-spec product reference moves to **Intel Gen5 Ironlake or newer**.

The target class is approximately:

- first-generation Intel Core i3-era hardware from around 2010 or newer;
- Intel Ironlake integrated graphics or a newer GPU generation;
- **2 GiB RAM as the low-memory floor**;
- **4 GiB RAM as the preferred low-spec validation configuration**;
- SATA HDD is permitted for worst-case responsiveness testing; SSD results must
  be reported separately rather than silently changing the baseline.

The exact laptop or desktop SKU is still to be selected and recorded after
physical inventory. "Gen5 Ironlake or newer" is the architectural floor, not a
claim that every machine in that generation is already supported.

## Video-decode requirement

The product browser path must have a viable hardware-accelerated H.264 decode
route on the reference class. The project finding used for this decision is
that the older GM45/GMA 4500 Gen4 platform does not provide the required H.264
VA-API path, while the reference floor moves to Gen5 Ironlake or newer.

A browser test that merely plays video through CPU software decoding does not
prove the low-spec video milestone.

## Compaq 610 boundary

DadLAN Laptop #10 / Compaq 610 remains:

- the first concrete JoshBIOS/JoshBootloader physical boot target;
- a firmware-identification and recovery target;
- useful for proving conservative legacy-PC boot behaviour.

It is **not** the low-spec product-performance reference and must not be used to
set browser/video performance requirements.

## Acceptance implications

Low-spec product testing should measure at least:

- cold boot to usable session;
- idle memory after login;
- browser launch;
- ordinary page responsiveness;
- H.264 video playback with hardware decode proven where applicable;
- audio playback;
- profile/login persistence across reboot;
- recovery from browser/session crash.

Results must name the exact CPU, GPU, RAM and storage configuration.

## Consequences

This deliberately raises the product GPU floor by roughly one generation while
keeping the reference machine old and memory-constrained. It separates two
different engineering questions:

1. **Can JoshBIOS/JoshBootloader boot old hardware safely?**
2. **Can the Josh OS product provide a usable modern web/video experience on a
   deliberately low-end supported machine?**

Those questions now have separate targets and must not be conflated.
