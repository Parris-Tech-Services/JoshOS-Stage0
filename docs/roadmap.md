# Roadmap

Each stage must produce something bootable and usable. If a stage can't be
daily-driven at the end of it, it has been scoped wrong.

## Stage 0 — Shell prototype  ← *we are here*

Design the interaction model and visual language at speed, in a browser.

- [x] Window manager: move, resize, focus, minimise, maximise
- [x] Edge snapping with preview
- [x] Dock with running indicators, menubar, clock
- [x] Design token pipeline
- [x] Light/dark themes, accent colours, wallpapers
- [x] Notifications
- [x] Apps: About, Files, Terminal, Editor, Settings
- [ ] Keyboard-driven window management (the thing all three reference OSes do badly)
- [ ] Global launcher / command palette
- [ ] Window tiling beyond halves
- [x] ArchISO build pipeline that boots the browser shell as a live desktop
- [ ] Manual VirtualBox smoke test on the produced ISO

**Exit criteria:** you can look at it and say "yes, that's Josh OS" — or change
it cheaply until you can.

## Stage 1 — Josh OS 1.x: real desktop, Linux underneath

Everything the user experiences is Josh OS. Linux is an implementation detail.

- [x] Choose the base: Arch via `archiso`
- [ ] Wayland compositor: `smithay` (Rust) or `wlroots` (C) — see `compositor/`
- [ ] Port the window model from the prototype
- [ ] Shell: panel, dock, launcher, notifications as real surfaces
- [ ] Settings backed by real system services
- [ ] Bootable ISO with an installer
- [ ] Application packaging story

**Exit criteria:** it boots on real hardware and you use it for a week.

## Stage 2 — Josh OS 2.x: own more of the userland

Replace Linux system services where Josh's model genuinely differs. Not before.

- [ ] Josh file service
- [ ] Josh device/session model
- [ ] Josh application format

## Stage 3 — Josh OS 3.x: experimental Josh kernel

Boots in QEMU. Runs the Josh userland. Not expected to replace Linux on real
hardware, and that's fine — the point is owning the whole stack conceptually.

## Honest sizing

Stage 0 is weeks. Stage 1 is a serious year or more of evenings, and the
compositor alone is months. Haiku has been at this since 2001 and is still in
beta; ReactOS since the 90s and still on 0.4.x. Both have teams.

That is not an argument against doing it. It is an argument for making every
stage shippable, so the project survives contact with real life.
