# Stage 0 product roadmap

This repository is the **Stage-0 product/ISO extraction** for Josh OS.

The canonical integration repository is [joshuaparris-max/JoshOS](https://github.com/joshuaparris-max/JoshOS). This repo exists to make desktop/product ideas cheap to prototype and easy to boot, not to become a second canonical Josh OS.

The live product track now targets a **real Wayland session** hosted by labwc. The existing `shell/` browser desktop remains intact as the **reference prototype for the Josh window model and design language**, not the shipping Stage 0 desktop. See [ADR 0002](decisions/0002-real-wayland-session-for-stage-0.md).

## Detailed roadmaps

- [Stage 0 hardening](STAGE0_HARDENING_ROADMAP.md) — build reliability, VM boot proof, product concepts, accessibility, first-run/recovery UX and Wayland hand-off.
- [Upstream sync policy](UPSTREAM_SYNC.md) — prevents copied JoshOS assets and code from silently drifting.

## Stage 0A — reliable live image

- [x] browser shell;
- [x] ArchISO pipeline;
- [ ] **TASK-00656** reconcile current build-script drift with JoshOS;
- [ ] **TASK-00657** automated QEMU boot smoke test;
- [ ] **TASK-00658** manual VirtualBox validation;
- [ ] **TASK-00659** embedded source/build metadata;
- [ ] **TASK-00660** documented supported VM settings;
- [ ] **TASK-00661** deterministic “desktop ready” evidence.

**Exit criterion:** a fresh checkout repeatedly produces a live ISO that demonstrably reaches the Josh desktop.

## Stage 0B — canonical desktop model

- [x] move/resize/focus/minimise/maximise;
- [x] edge snapping;
- [x] dock/menu bar/clock;
- [x] themes/wallpapers/accents;
- [x] notifications;
- [x] About/Files/Terminal/Editor/Settings prototypes;
- [ ] **TASK-00668** canonical App model;
- [ ] **TASK-00669** canonical Window model;
- [ ] **TASK-00670** canonical Command model;
- [ ] **TASK-00671** typed Settings model;
- [ ] **TASK-00672** notification data/render separation;
- [ ] **TASK-00673** implementation-neutral documentation for each model.

Successful models are promoted to JoshOS.

## Stage 0C — keyboard and accessibility

- [ ] **TASK-00674** global launcher / command palette;
- [ ] **TASK-00675** switch windows from keyboard;
- [ ] **TASK-00676** keyboard snap/maximise/minimise/close;
- [ ] **TASK-00677** full dock/launcher keyboard navigation;
- [ ] **TASK-00678** visible focus;
- [ ] **TASK-00679** logical accessibility semantics;
- [ ] **TASK-00680** reduced motion;
- [ ] **TASK-00681** zoom/text-scale stress tests;
- [ ] **TASK-00682** automated accessibility checks where useful.

## Stage 0D — start/first-run/recovery prototypes

Use Stage 0 to cheaply design the visible product experience that later spans multiple real layers.

- [ ] **TASK-00683** firmware/start-screen visual language prototype;
- [ ] **TASK-00684** boot-menu visual language prototype;
- [ ] **TASK-00685** OS boot-splash prototype using real milestone vocabulary;
- [ ] **TASK-00686** first-run flow;
- [ ] **TASK-00687** login/session prototype only after account semantics are defined;
- [ ] **TASK-00688** recovery UI information architecture;
- [ ] **TASK-00689** diagnostics/export UX.

These are product prototypes; firmware/bootloader mechanisms live in JoshBIOS and canonical OS mechanisms live in JoshOS.

## Stage 0E — prepare the Wayland port

- [ ] **TASK-00690** separate shell state/model from DOM rendering;
- [ ] **TASK-00691** document DOM-only assumptions;
- [ ] **TASK-00692** conformance tests for window/focus/snap behaviour;
- [ ] **TASK-00693** generate shared design values from one token source;
- [ ] **TASK-00694** spike Smithay and wlroots in canonical JoshOS;
- [ ] **TASK-00695** choose compositor toolkit by evidence;
- [ ] **TASK-00696** port concepts rather than browser implementation details.

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
