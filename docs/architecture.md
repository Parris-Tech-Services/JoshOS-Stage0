# Architecture

## Layers, and who owns them today

| Layer | Stage 1 | Stage 2 | Stage 3 |
|---|---|---|---|
| Desktop UI | **Josh** | Josh | Josh |
| Window system | Linux (prototype in browser) → **Josh** | Josh | Josh |
| System services | Linux (systemd, PipeWire, NetworkManager) | **Josh** where it earns its place | Josh |
| Kernel | Linux | Linux | **Josh (experimental)** |
| Hardware | — | — | — |

The rule for moving a layer leftward: *replace a component only when owning it
buys conceptual integrity we can't get otherwise.* Replacing NetworkManager to
say we wrote it ourselves is vanity. Replacing it because the Josh model of
"devices" genuinely can't sit on top of it is a reason.

## The shell prototype

`shell/` is the Josh Window System modelled in a browser. The rendering is
throwaway. These concepts are not:

- **Window record.** `{ id, appId, title, x, y, w, h, state, prev }`. Geometry
  and state live in the window manager, never in the app.
- **Focus stack.** A single ordered list. The top of the stack is focused; there
  is no separate "active" concept to get out of sync.
- **Snap zones.** Computed from pointer position against desktop bounds. Left
  half, right half, top = maximise. One function, `snapZoneFor()`.
- **App registry.** An app is `{ id, name, glyph, width, height, mount() }`.
  It fills a body element and knows nothing else about the system.

That last boundary is the important one. When apps become real processes
talking to a real compositor over Wayland, the app contract barely changes:
declare identity, receive a surface, draw into it.

## Design tokens

`design/tokens.json` is the single source of truth for colour, spacing,
typography, radius, motion and chrome dimensions. `scripts/build-tokens.mjs`
generates `design/tokens.css`.

The native compositor and Settings app are expected to read the *same JSON*.
This is what stops the prototype and the real desktop from drifting apart, and
it is why the tokens live at the repo root rather than inside `shell/`.

## Non-goals for stage 1

- Hardware drivers of any kind.
- A browser engine. (See [ADR-0001](decisions/0001-linux-kernel-for-stage-1.md).)
- Binary compatibility with anything.
- Mobile or touch.
