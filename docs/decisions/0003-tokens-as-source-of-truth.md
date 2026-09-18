# ADR-0003: One token file for every surface

**Status:** accepted
**Date:** 2026-09-18

## Context

The shell prototype is web. The real compositor will be native. Two codebases
describing the same visual language will drift — that is not a risk, it is a
certainty.

## Decision

`design/tokens.json` is the single source of truth. The web prototype consumes
generated CSS; native code reads the same JSON at build time.

No component in any language defines a colour, spacing value, radius or timing
locally. `design/tokens.css` is generated and must never be hand-edited.

## Consequences

Adding a colour is a deliberate act with a diff, which is the point — it is how
principle 3 (*restraint over expressiveness*) gets enforced by tooling rather
than by willpower. Native code needs a small token loader; that is cheap
compared to two divergent design systems.
