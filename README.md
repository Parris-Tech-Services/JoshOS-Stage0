# Josh OS

A desktop operating system with unusually strong conceptual integrity.

> **Josh OS should feel simpler after you understand it, not more complicated.**
> That applies equally to the interface and to the source code. It is the rule
> every decision in this repo gets measured against.

## What this is

Josh OS borrows deliberately: macOS for visual restraint and consistency,
Windows for familiar window management, Linux for openness and hackability.
It is not aiming to be another theme on top of GNOME.

## What this is *not* (yet)

There is no kernel here, and for stage 1 there deliberately won't be. See
[ADR-0001](docs/decisions/0001-linux-kernel-for-stage-1.md) for why, and
[docs/roadmap.md](docs/roadmap.md) for how the stack gets owned over time.

## Repo layout

| Path | What lives here |
|---|---|
| `design/` | `tokens.json` — the single source of truth for the visual language |
| `shell/` | The Josh Window System prototype, running in a browser |
| `compositor/` | Plan for the real Wayland compositor (stage 2) |
| `iso/` | Bootable Stage 0 live-image integration and VirtualBox path |
| `docs/` | Vision, architecture, roadmap, and architecture decision records |
| `scripts/` | Build tooling |

## Run the shell prototype

No install, no dev server:

```sh
# just open it
xdg-open shell/index.html      # Linux
start shell\index.html         # Windows
```

Or build the single-file version:

```sh
node scripts/build-shell.mjs   # -> dist/josh-os-shell.html
```

## Build a bootable ISO

Josh OS can now be wrapped in an ArchISO live image for VirtualBox testing:

```sh
sudo pacman -S archiso
sudo ./scripts/build-iso.sh
```

That ISO is a **Stage 0 compatibility vehicle**: Linux + LightDM + Openbox host
the browser prototype full-screen. It does not replace the planned native
Wayland compositor. See [iso/README.md](iso/README.md) and
[docs/virtualbox.md](docs/virtualbox.md).

### What works

Movable and resizable windows, focus stack, minimise/maximise, edge snapping
(drag to left/right edge or top), dock with running indicators, menubar clock,
light/dark themes, accent colours, wallpapers, notifications, and five apps:
About, Files, Terminal, Text Editor, Settings.

Try the Terminal — `help` lists what it knows.

## Rebuild design tokens

`design/tokens.css` is generated. Never hand-edit it.

```sh
node scripts/build-tokens.mjs
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). The short version: if a change makes
the system harder to hold in your head, it needs a very good argument.

## Licence

MIT — see [LICENSE](LICENSE). Chosen as a sane default; change it before the
project gets any outside contributors if you want something else.
