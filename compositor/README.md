# Josh Window System — the real thing

Stage 1. Nothing is written yet, deliberately: this directory holds the plan,
not placeholder code. Fake scaffolding in a repo is a lie about progress.

## The choice: Smithay vs wlroots

| | **Smithay** (Rust) | **wlroots** (C) |
|---|---|---|
| Language | Rust | C |
| Model | A library of parts you assemble | A more complete framework |
| Control | Total — you write the compositor loop | More is done for you |
| Users | Cosmic (System76), Niri | Sway, Hyprland, river |
| Learning cost | Higher | Lower |

**Leaning Smithay.** A compositor is the one place where a memory-safety bug
takes the whole session with it, and the Josh window model is unusual enough
that "assemble from parts" beats "adapt a framework". System76 building Cosmic
on it is decent evidence it's viable for a full desktop.

This is not locked in. Prototype a hello-world in both before committing —
that's a week, and it's the cheapest week in the project.

## Build order

Each step should end with something visibly working.

1. **Boot to a black screen.** Compositor starts under a TTY, initialises DRM,
   opens a session via libseat. Nothing renders. Getting here is the hard part.
2. **One window.** Accept a Wayland client, allocate a surface, composite it.
   Test with `weston-terminal` or `foot`.
3. **Input.** libinput: pointer, keyboard, focus follows click.
4. **The window model.** Port `snapZoneFor()`, the focus stack and the window
   record from `shell/shell.js`. The logic transfers almost directly; only
   rendering changes.
5. **Decorations.** Server-side, drawn from `design/tokens.json`.
6. **XWayland.** For everything not yet ported.
7. **Shell surfaces.** Panel, dock and notifications as layer-shell clients,
   which means the shell is just another Wayland client — worth it for the
   conceptual clarity.

## Things that will hurt

- Getting DRM/KMS and libseat right on a real machine, with no window system to
  debug from. Develop nested inside an existing compositor first.
- Multi-monitor, hotplug and scaling. These are where compositors go to die.
- Suspend/resume and VT switching.

## Prerequisites before starting

Finish stage 0. The interaction model should be settled before it costs a
thousand lines of Rust to change your mind about it.
