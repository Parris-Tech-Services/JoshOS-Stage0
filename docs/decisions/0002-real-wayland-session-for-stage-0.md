# ADR 0002 — Real Wayland session for Stage 0

**Status:** Accepted  
**Date:** 2026-09-19  
**Scope:** JoshOS-Stage0 product/live-image track

## Context

The original Stage 0 live image used LightDM, Openbox and Chromium in kiosk mode to display the browser shell. That was useful for rapidly proving the Josh visual language and window-model ideas, but it cannot become a normal desktop session.

A Chromium window can render the browser prototype, but it cannot act as the system compositor for unrelated native applications. Firefox, a terminal, a package manager, a file manager and other Linux applications cannot become real managed windows *inside* the browser shell. Bridging the shell to host processes would still leave the browser as an artificial boundary around the desktop.

The browser prototype is nevertheless valuable. It contains the fastest-to-change reference implementation of Josh window behaviour and consumes the canonical design-token source.

## Decision

Stage 0 will use a real Wayland session built from existing Linux components:

- **labwc** as the wlroots-based stacking compositor;
- **seatd/libseat** for seat access;
- **greetd** for unattended live-session startup;
- **XWayland** for applications that still require X11 compatibility;
- **Waybar** for the Josh-styled panel/dock surface;
- **Fuzzel** for the application launcher;
- packaged Linux applications for browser, terminal, calculator, files, text editing and package management.

Labwc is selected because its floating/stacking window model is closer to the Josh prototype than tiling-first alternatives, while remaining small and based on wlroots. It is an integration component, not the future Josh compositor.

The live image will expose an **Install JoshOS** entry. Installation will use branded Calamares configuration; Josh OS will not implement disk partitioning itself.

## Browser prototype boundary

The repository's `shell/` directory is **not deleted, rewritten into the session, or treated as the shipping desktop**.

It is retained as:

- the reference prototype for the Josh App/Window/Command/Settings concepts;
- a cheap environment for interaction and accessibility experiments;
- a consumer of the same design tokens as the real session.

New session work should port **concepts and visual tokens**, not browser/DOM implementation patterns.

## Design-token ownership

`design/tokens.json` remains the implementation-neutral source of truth for the Stage 0 visual language. Generated compositor, Waybar, Fuzzel and GTK configuration must come from that token source. Generated files are not hand-edited and CI must detect drift.

## What is deferred

This decision does **not** implement or select the final Josh compositor.

The native Josh compositor remains canonical future work in `joshuaparris-max/JoshOS`. Stage 0 uses labwc to obtain mature Linux hardware/application support while the native stack develops.

The following remain deferred to canonical JoshOS work:

- Josh-owned Wayland/compositor implementation;
- native window-management protocol decisions beyond the product model;
- GPU/DRM/KMS driver ownership;
- native userspace integration.

## What this does not change

The long-term architecture remains:

```text
JoshFirmware
→ JoshBIOS
→ JoshBootloader
→ Josh Boot Protocol
→ Josh native kernel
→ native userspace/services
→ Josh compositor/desktop
→ applications
```

Stage 0 remains a Linux-backed product track and rapid prototype. It is not a replacement native operating system and does not move kernel/bootloader ownership into this repository.

## Consequences

Positive:

- real Firefox/terminal/files/editor/package-manager windows can run normally;
- the live image represents a usable Linux desktop rather than a kiosk demonstration;
- XWayland provides compatibility without making X11 the session architecture;
- the design-token and browser-model work remains reusable;
- installer work can install the same session users see live.

Costs:

- the image gains more Linux desktop packages and configuration;
- session startup, panel/launcher integration and application packaging become real integration surfaces;
- Calamares is not in Arch's official repositories and therefore needs a reproducible package build/source in CI.

## Verification requirement

This decision is not considered delivered merely because packages are listed in the ISO.

CI must eventually prove:

1. unattended boot reaches the Josh Wayland session;
2. panel/dock/launcher are visible;
3. a real terminal executes a command;
4. a real browser loads a page;
5. the Josh network check passes;
6. Calamares installs to a blank virtual disk and that disk boots into the same Josh session.

Anything not covered by automated evidence must be listed as unverified.
