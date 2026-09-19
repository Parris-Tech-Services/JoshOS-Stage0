#!/usr/bin/env bash
set -euo pipefail

iso="${1:?usage: smoke-network-platform.sh <josh-os.iso> [log]}"
log="${2:-network-boot.log}"
qemu="${QEMU:-qemu-system-x86_64}"
timeout_seconds="${NETWORK_SMOKE_TIMEOUT:-300}"
monitor="${log}.monitor"

command -v "$qemu" >/dev/null
command -v python3 >/dev/null
mkdir -p "$(dirname "$log")"
rm -f "$log" "$monitor"
: > "$log"

"$qemu" \
  -machine q35 \
  -m 2048 \
  -boot order=d \
  -cdrom "$iso" \
  -nic user,model=e1000 \
  -display none \
  -serial "file:$log" \
  -monitor "unix:$monitor,server=on,wait=off" \
  -no-reboot \
  >/dev/null 2>&1 &
pid=$!

cleanup() {
  if kill -0 "$pid" >/dev/null 2>&1; then
    kill "$pid" >/dev/null 2>&1 || true
    wait "$pid" 2>/dev/null || true
  fi
  rm -f "$monitor"
}
trap cleanup EXIT

send_monitor_command() {
  local command="$1"
  python3 - "$monitor" "$command" <<'PY'
import socket
import sys
import time

path, command = sys.argv[1], sys.argv[2]
last_error = None
for _ in range(40):
    client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    try:
        client.connect(path)
        client.settimeout(1.0)
        try:
            client.recv(4096)
        except socket.timeout:
            pass
        client.sendall((command + "\n").encode("ascii"))
        client.close()
        raise SystemExit(0)
    except OSError as exc:
        last_error = exc
        client.close()
        time.sleep(0.05)

print(f"QEMU monitor command failed: {last_error}", file=sys.stderr)
raise SystemExit(1)
PY
}

boot_key_sent=0
for _ in $(seq 1 "$timeout_seconds"); do
  # serial-getty can leave its login prompt on the same line as the readiness
  # marker (for example: "archiso login: JOSHOS_NETWORK_READY"). Check the
  # failure token first because it contains the success token as a prefix.
  if grep -qF 'JOSHOS_NETWORK_READY_FAIL' "$log"; then
    cat "$log" >&2
    exit 1
  fi
  if grep -qF 'JOSHOS_NETWORK_READY' "$log"; then
    echo "Josh OS Stage 0 QEMU Internet smoke test passed."
    exit 0
  fi

  # TCG on hosted runners can make a 15-second guest bootloader countdown take
  # minutes of wall-clock time. Keep booting the real ISO, but press Enter as
  # soon as the visible ArchISO menu proves it is ready for input.
  if (( ! boot_key_sent )) && grep -q 'Automatic boot in' "$log"; then
    send_monitor_command "sendkey ret"
    boot_key_sent=1
    echo "Josh OS Stage 0 smoke: skipped the bootloader countdown."
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
