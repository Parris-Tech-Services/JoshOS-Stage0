# Stage 0 extraction sync policy

This repository is intentionally **not** the canonical whole Josh OS repository.

Canonical integration lives in:

- https://github.com/joshuaparris-max/JoshOS

This repository exists as a smaller Stage 0 product-track extraction for fast iteration on the browser shell, design tokens, ArchISO live-image packaging, and VirtualBox-facing product experiments.

## Rule

Changes that define the long-term Josh OS architecture should land in **JoshOS first**.

Changes specific to the extracted Stage 0 image may land here first, but should be reconciled back into JoshOS when they prove useful. Do not blindly mirror every file: the repositories have different jobs.

## Shared surfaces worth reconciling

- `design/`
- `shell/`
- `iso/`
- `scripts/build-iso.sh`
- VirtualBox/live-image documentation

## Deliberate divergence

JoshOS additionally owns the independent x86-64 Josh kernel, Limine native ISO, boot-protocol adapters, and convergence architecture. Those do not belong here merely for symmetry.
