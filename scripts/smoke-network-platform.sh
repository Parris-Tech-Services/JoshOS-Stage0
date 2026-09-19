#!/usr/bin/env bash
set -euo pipefail

iso="${1:?usage: smoke-network-platform.sh <josh-os.iso> [log]}"
log="${2:-network-boot.log}"
qemu="${QEMU:-qemu-system-x86_64}"
timeout_seconds="${NETWORK_SMOKE_TIMEOUT:-180}"

command -v "$qemu" >/dev/null
mkdir -p "$(dirname "$log")"
: > "$log"

"$qemu" \
  -machine q35 \
  -smp 2 \
  -m 2048 \
  -boot order=d \
  -cdrom "$iso" \
  -nic user,model=e1000 \
  -display none \
  -serial "file:$log" \
  -monitor none \
  -no-reboot \
  >/dev/null 2>&1 &
pid=$!

cleanup() {
  if kill -0 "$pid" >/dev/null 2>&1; then
    kill "$pid" >/dev/null 2>&1 || true
    wait "$pid" 2>/dev/null || true
  fi
}
trap cleanup EXIT

for _ in $(seq 1 "$timeout_seconds"); do
  if grep -q '^JOSHOS_NETWORK_READY' "$log"; then
    echo "Josh OS Stage 0 QEMU Internet smoke test passed."
    exit 0
  fi
  if grep -q '^JOSHOS_NETWORK_READY_FAIL' "$log"; then
    cat "$log" >&2
    exit 1
  fi
  if ! kill -0 "$pid" >/dev/null 2>&1; then
    echo "Josh OS Stage 0 exited before Internet readiness." >&2
    cat "$log" >&2
    exit 1
  fi
  sleep 1
done

echo "Josh OS Stage 0 Internet smoke test timed out." >&2
cat "$log" >&2
exit 1
