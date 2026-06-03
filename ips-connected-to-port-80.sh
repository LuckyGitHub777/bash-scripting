#!/usr/bin/env bash
# ips-connected-to-port-80.sh - Show established TCP connections involving port 80.

set -euo pipefail
IFS=$'\n\t'

main() {
  if ! command -v ss >/dev/null 2>&1; then
    printf 'The ss command is required. Install iproute2 or use netstat as an alternative.\n' >&2
    return 1
  fi

  printf 'Established TCP connections involving port 80:\n'
  ss -tn state established '( sport = :80 or dport = :80 )' || true
}

main "$@"
