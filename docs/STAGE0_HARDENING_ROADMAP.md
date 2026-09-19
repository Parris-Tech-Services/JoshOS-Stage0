# Stage 0 hardening roadmap

This repository is the extracted Stage-0 Josh OS product shell and ArchISO compatibility image.

It is **not** the canonical Josh OS integration repository. Canonical product concepts and the native kernel live in `joshuaparris-max/JoshOS`.

The purpose of this repo is to make the visible Josh desktop easy to iterate, boot, test and demonstrate while the production compositor and native kernel mature.

## What Stage 0 is good for

Stage 0 should remain excellent at:

- rapid interaction design;
- window-model experimentation;
- design-token testing;
- first-run/settings UX prototypes;
- keyboard navigation;
- accessibility semantics;
- bootable live-image demonstrations;
- virtual-machine testing;
- screenshots/demos;
- testing product concepts before expensive native implementation.

It should not pretend Chromium/Openbox is the final architecture.

---

# S0 — Stop source-of-truth drift

Current problem: some files began as copies of JoshOS and have already diverged.

Examples observed:

- shared design tokens are currently identical;
- shell implementation has diverged;
- ISO build scripts have diverged;
- JoshOS fixed an ArchISO VirtualBox guest-package conflict that may not exist here yet.

## Decide ownership per file family

### Canonical in JoshOS

Prefer JoshOS as source of truth for:

- design tokens;
- canonical App/Window/Setting concepts;
- product roadmap;
- architecture decisions;
- final Stage-0 shell changes intended to ship in Josh OS.

### Local to JoshOS-Stage0

Keep local ownership for:

- extraction-specific CI;
- demonstration packaging;
- experiments intentionally not promoted upstream;
- compatibility wrappers.

## Required work

- [ ] add explicit upstream commit/reference metadata;
- [ ] classify every duplicated path as canonical-copy, local-fork or generated;
- [ ] add a sync check for files meant to remain identical;
- [ ] document intentional deltas;
- [ ] stop manually copying files without recording provenance.

See `docs/UPSTREAM_SYNC.md`.

---

# S1 — Build reliability

The live ISO must build repeatably before adding features.

- [ ] pin or record ArchISO base expectations;
- [ ] remove/confine packages known to conflict with current releng profiles;
- [ ] validate required overlay files;
- [ ] fail clearly when packages disappear/rename;
- [ ] checksum output;
- [ ] record build metadata inside the image;
- [ ] keep CI artefact retention policy explicit;
- [ ] add a build-only quick validation path;
- [ ] cache only where it cannot hide dependency drift.

## Build metadata

Expose in `/etc/josh-os-release`:

- Stage;
- source repository;
- git commit;
- build timestamp or reproducible build identifier;
- ArchISO/base identifier where available;
- design-token version.

---

# S2 — Automated boot smoke test

The current value of Stage 0 increases substantially if CI proves the ISO starts.

Add a VM test that confirms:

1. ISO boots;
2. LightDM/session starts;
3. Chromium launches the Josh shell;
4. a deterministic “desktop ready” marker can be observed.

Possible evidence should be chosen for reliability:

- serial/systemd marker;
- test-only HTTP/file marker;
- VM screenshot plus machine-readable readiness;
- process/service state from a controlled guest agent only if it does not become a product dependency.

Do not rely only on “mkarchiso exited 0”.

---

# S3 — VirtualBox and QEMU matrix

Test both because they catch different assumptions.

## QEMU

- UEFI and BIOS where the ArchISO supports it;
- 2/4/8 GiB RAM;
- common resolutions;
- virtio storage/network where useful.

## VirtualBox

- EFI on/off where applicable;
- VMSVGA;
- multiple resolutions;
- keyboard/mouse;
- clean shutdown/restart.

Keep guest additions optional and do not let one package conflict break the base live image.

---

# S4 — Shell architecture hardening

The browser prototype has useful concepts. Stabilise them before porting.

## App

Define:

- stable app ID;
- display name;
- icon/glyph asset;
- preferred/default window geometry;
- capabilities;
- commands;
- lifecycle hooks.

## Window

Define:

- ID;
- owning app;
- title;
- geometry;
- state;
- focus;
- z/stacking;
- workspace;
- capabilities such as resizable/minimisable.

## Command

Create a system-wide command model for:

- app actions;
- global launcher;
- keyboard shortcuts;
- menu actions;
- automation/testing later.

## Notification

Separate notification data from its DOM rendering.

## Settings

Use typed settings with:

- key;
- type;
- default;
- scope;
- validation;
- persistence owner.

These concepts should map cleanly to future Wayland/native implementations.

---

# S5 — Keyboard-first desktop

Before adding more visual features:

- [ ] global launcher shortcut;
- [ ] cycle windows;
- [ ] move focus without mouse;
- [ ] snap left/right/full;
- [ ] close/minimise/maximise;
- [ ] dock/launcher keyboard navigation;
- [ ] Settings fully navigable;
- [ ] terminal/editor usable without pointer.

Keyboard semantics should become part of the canonical product contract in JoshOS.

---

# S6 — Accessibility prototype

Use the browser environment to prototype semantics cheaply.

- [ ] landmark roles;
- [ ] dialog/window semantics;
- [ ] focus trapping only where correct;
- [ ] visible focus;
- [ ] accessible names for controls;
- [ ] logical reading order;
- [ ] reduced motion;
- [ ] high contrast experiments;
- [ ] zoom/text scaling stress tests;
- [ ] automated accessibility checks where useful.

Promote successful concepts upstream rather than keeping them Stage-0-only.

---

# S7 — Window model

Extend carefully:

- [ ] keyboard snapping;
- [ ] quarter tiling only if useful;
- [ ] workspaces only if product strategy adopts them;
- [ ] multi-monitor simulation;
- [ ] minimum/maximum geometry;
- [ ] restore-state semantics;
- [ ] fullscreen distinct from maximise;
- [ ] modal/transient window model only when an app needs it.

Avoid copying every Windows/macOS behaviour by default.

---

# S8 — Launcher and command palette

Prototype one coherent entry point for:

- applications;
- settings;
- system commands;
- recent items later;
- file/search integration later.

Search should operate over structured providers rather than hard-coded DOM items.

---

# S9 — Settings that map to reality

Stage 0 can prototype:

- Appearance;
- Wallpaper;
- Accent;
- Keyboard;
- Accessibility;
- About.

For fake/unimplemented hardware controls, show a clearly labelled design prototype only in design/dev modes, not the normal live product.

The canonical Josh rule remains: **do not ship dead toggles**.

---

# S10 — First-run prototype

Prototype the future Josh OS first-run flow here because it is cheap to change.

Screens to test:

1. language/keyboard;
2. accessibility/display;
3. network concept;
4. device name;
5. account model only after architecture exists;
6. update/privacy choices only if real;
7. welcome.

The prototype should emit a structured first-run state model that can later be implemented natively.

---

# S11 — Boot/start visual continuity

Stage 0 does not own firmware or JoshBootloader, but it should help define the shared visual system.

Create design assets/tokens for:

- firmware splash;
- bootloader menu;
- OS boot splash;
- recovery;
- first-run;
- desktop.

Keep early-boot assets simpler than browser/desktop assets because those environments have tighter constraints.

---

# S12 — Recovery UX prototype

Prototype the wording/information architecture for:

- normal boot;
- previous version;
- repair;
- diagnostics;
- safe/rescue mode;
- reinstall/repair.

This is a UX prototype; actual recovery mechanisms live in firmware/bootloader/OS.

---

# S13 — Product testing

Add deterministic tests for concepts that should survive the port:

- snap-zone calculation;
- focus transitions;
- minimise/maximise restore;
- command registration;
- settings validation;
- app registration;
- launcher search;
- persistence migration.

DOM rendering tests matter less than invariant tests for the conceptual model.

---

# S14 — Design-token pipeline

Keep `design/tokens.json` implementation-neutral.

Improve it to support generation for:

- CSS;
- Rust compositor constants later;
- C/native constants later;
- early-boot constrained palette/assets.

Add schema validation and generated-file drift checks.

---

# S15 — Wayland hand-off preparation

Before production compositor work:

- [ ] document each shell concept in implementation-neutral language;
- [ ] identify DOM-only assumptions;
- [ ] separate state/model from rendering;
- [ ] record compositor protocol needs;
- [ ] create a small conformance suite for the window model;
- [ ] spike Smithay and wlroots in canonical JoshOS work;
- [ ] port concepts, not browser implementation patterns.

---

# S16 — Demo quality

A demo image should:

- boot reliably;
- explain that it is Stage 0;
- show build ID;
- offer a short guided “what works” path;
- avoid implying unsupported native capabilities;
- be easy to reset.

Truthful demos build more confidence than fake completeness.

---

# Stage-0 exit criteria

Stage 0 is “done enough” when:

1. the live image builds reliably;
2. VM boot is automatically proven;
3. desktop concepts are documented independent of browser rendering;
4. keyboard navigation is coherent;
5. key accessibility semantics are proven;
6. first-run/recovery/start UX has been prototyped;
7. duplicated canonical assets have an explicit sync mechanism;
8. the Wayland implementation can begin without rediscovering the product model.

After that, most new product engineering belongs in canonical JoshOS rather than expanding this extraction forever.
