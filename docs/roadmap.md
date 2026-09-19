# Stage 0 product roadmap

This repository is the **Stage-0 product/ISO extraction** for Josh OS.

The canonical integration repository is [joshuaparris-max/JoshOS](https://github.com/joshuaparris-max/JoshOS). This repo exists to make desktop/product ideas cheap to prototype and easy to boot, not to become a second canonical Josh OS.

## Detailed roadmaps

- [Stage 0 hardening](STAGE0_HARDENING_ROADMAP.md) — build reliability, VM boot proof, product concepts, accessibility, first-run/recovery UX and Wayland hand-off.
- [Upstream sync policy](UPSTREAM_SYNC.md) — prevents copied JoshOS assets and code from silently drifting.

## Stage 0A — reliable live image

- [x] browser shell;
- [x] ArchISO pipeline;
- [ ] reconcile current build-script drift with JoshOS;
- [ ] automated QEMU boot smoke test;
- [ ] manual VirtualBox validation;
- [ ] embedded source/build metadata;
- [ ] documented supported VM settings;
- [ ] deterministic “desktop ready” evidence.

**Exit criterion:** a fresh checkout repeatedly produces a live ISO that demonstrably reaches the Josh desktop.

## Stage 0B — canonical desktop model

- [x] move/resize/focus/minimise/maximise;
- [x] edge snapping;
- [x] dock/menu bar/clock;
- [x] themes/wallpapers/accents;
- [x] notifications;
- [x] About/Files/Terminal/Editor/Settings prototypes;
- [ ] canonical App model;
- [ ] canonical Window model;
- [ ] canonical Command model;
- [ ] typed Settings model;
- [ ] notification data/render separation;
- [ ] implementation-neutral documentation for each model.

Successful models are promoted to JoshOS.

## Stage 0C — keyboard and accessibility

- [ ] global launcher / command palette;
- [ ] switch windows from keyboard;
- [ ] keyboard snap/maximise/minimise/close;
- [ ] full dock/launcher keyboard navigation;
- [ ] visible focus;
- [ ] logical accessibility semantics;
- [ ] reduced motion;
- [ ] zoom/text-scale stress tests;
- [ ] automated accessibility checks where useful.

## Stage 0D — start/first-run/recovery prototypes

Use Stage 0 to cheaply design the visible product experience that later spans multiple real layers.

- [ ] firmware/start-screen visual language prototype;
- [ ] boot-menu visual language prototype;
- [ ] OS boot-splash prototype using real milestone vocabulary;
- [ ] first-run flow;
- [ ] login/session prototype only after account semantics are defined;
- [ ] recovery UI information architecture;
- [ ] diagnostics/export UX.

These are product prototypes; firmware/bootloader mechanisms live in JoshBIOS and canonical OS mechanisms live in JoshOS.

## Stage 0E — prepare the Wayland port

- [ ] separate shell state/model from DOM rendering;
- [ ] document DOM-only assumptions;
- [ ] conformance tests for window/focus/snap behaviour;
- [ ] generate shared design values from one token source;
- [ ] spike Smithay and wlroots in canonical JoshOS;
- [ ] choose compositor toolkit by evidence;
- [ ] port concepts rather than browser implementation details.

## Stage 1 — canonical Linux-backed Josh desktop

Stage 1 belongs primarily in JoshOS.

Target:

```text
Josh apps
    ↓
Josh desktop shell
    ↓
Josh Wayland compositor
    ↓
Josh services
    ↓
Linux kernel + mature drivers
```

This extraction should become thinner as the canonical implementation becomes easier to iterate.

## Native-kernel convergence

The independent Josh kernel is **already real and already in JoshOS**. It is not a future JoshOS-Stage0 Stage 3.

The long-term goal is for the same product concepts to run over:

1. Stage-0 browser prototype;
2. Linux/Wayland production desktop;
3. native Josh userspace/kernel.

JoshOS-Stage0 contributes by proving concepts cheaply and handing them upstream.

## End state for this repo

Choose deliberately between:

- keeping JoshOS-Stage0 as a thin, automatically synced Stage-0/demo extraction; or
- archiving it once JoshOS can provide the same rapid product iteration without duplication.

There should never be two canonical Josh desktops.
