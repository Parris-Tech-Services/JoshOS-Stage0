# ADR-0002: Wayland, not X11

**Status:** accepted
**Date:** 2026-09-18

## Context

A new desktop needs a display server protocol. X11 has thirty-odd years of
compatibility and tooling. Wayland is the direction the Linux desktop has
already committed to.

## Decision

Wayland. Josh OS ships a Wayland compositor and uses XWayland for legacy apps.

## Rationale

Writing an X11 window manager means inheriting X11's model — a model whose
complexity is exactly what principle 1 (*one way to do each thing*) exists to
avoid. In Wayland the compositor *is* the window manager, which collapses two
concepts into one. That is a conceptual-integrity win, not just a modernity one.

## Consequences

Some older applications need XWayland. Screen capture, global hotkeys and
accessibility go through portals rather than being free — more work, but the
security model is coherent rather than "any client can read any window".
