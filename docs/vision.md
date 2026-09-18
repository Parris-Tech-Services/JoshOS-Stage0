# Vision

Josh OS is a desktop operating system that borrows the best ideas rather than
copying any one system:

- **macOS** — visual restraint and consistency.
- **Windows** — familiar window management and broad desktop conventions.
- **Linux** — openness, hackability and transparency.

The ambition is not "another Linux distro". It is an OS with unusually strong
**conceptual integrity**: a small number of ideas, applied consistently, that a
person can hold in their head.

## The foundational rule

> Josh OS should feel simpler after you understand it, not more complicated.

This cuts both ways:

- **Interface.** Learning how one window behaves should tell you how every
  window behaves. No special cases, no hidden modes, no setting that only
  applies on Tuesdays.
- **Source code.** Reading one subsystem should make the next one easier, not
  harder. A contributor should be able to hold the architecture in their head
  after a weekend.

## Target shape

```
        ┌─────────────────────┐
        │     Desktop UI      │   windows / dock / menus / settings
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  Josh Window System │   compositor + input
        └──────────┬──────────┘
                   │
      ┌────────────▼────────────┐
      │     System Services     │   files · audio · network
      │                         │   apps · users · devices
      └────────────┬────────────┘
                   │
           ┌───────▼───────┐
           │  Josh Kernel   │
           └───────┬───────┘
                   │
              PC hardware
```

Stage 1 replaces only the top two layers and keeps Linux underneath. That is a
sequencing decision, not a retreat — see [roadmap.md](roadmap.md).
