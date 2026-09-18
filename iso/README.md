# Bootable Josh OS image

Josh OS now has a Stage 0 live-image pipeline. It deliberately uses ArchISO's
current `releng` profile for the low-level BIOS/UEFI boot plumbing, then layers
the Josh OS shell on top.

This is **not** the future Josh compositor. The ISO boots Linux, autologs into a
small X11/Openbox compatibility session, and launches the browser shell in
Chromium kiosk mode. That makes the interaction model testable in VirtualBox
now, while ADR-0002 still governs the real Stage 1 compositor: Wayland, not
X11.

## What boots

1. ArchISO handles BIOS/UEFI boot and the live root filesystem.
2. LightDM autologs in as the disposable `josh` live user.
3. A minimal Openbox host session starts.
4. Chromium opens `file:///opt/josh-os/shell/index.html` full-screen.
5. VirtualBox guest utilities are included for better VM integration.

The live user has passwordless sudo because this image is a development image,
not a security boundary or production installer.

## Build on Arch Linux

```sh
sudo pacman -S archiso
sudo ./scripts/build-iso.sh
```

The result is written to `out/josh-os-*.iso`.

The builder copies `/usr/share/archiso/configs/releng` at build time instead of
vendoring Arch's bootloader profile. This keeps the boot plumbing aligned with
the installed ArchISO version and keeps Josh-specific files small enough to
understand.

## Build in GitHub Actions

The **Build Josh OS ISO** workflow builds inside a privileged Arch Linux
container and uploads `josh-os-iso` as a workflow artifact. It also publishes a
`SHA256SUMS` file beside the ISO.

## VirtualBox

Create a VM with:

- Type: Linux / Arch Linux (64-bit), or Other Linux (64-bit)
- RAM: 4096 MB
- CPUs: 2
- Graphics controller: VMSVGA
- Video memory: 128 MB
- 3D acceleration: off for the first boot
- Optical drive: attach `josh-os-*.iso`
- Secure Boot: off

BIOS and UEFI are both inherited from ArchISO's releng profile. Start with BIOS
for the simplest first test; UEFI can be enabled afterwards.

Expected result: after the normal boot sequence, Josh OS fills the display and
the browser chrome is hidden. Chromium is automatically relaunched if it exits.

## Honest boundary

A successful ISO build proves the image is structurally buildable. It does not
prove every VirtualBox host/graphics combination boots correctly. The roadmap
keeps a separate manual VirtualBox boot check for that reason.
