#!/usr/bin/env bash
# extract-ext-IP-using-dig.sh - Show the external IP address using DNS, with a curl fallback.

set -euo pipefail
IFS=$'\n\t'

main() {
  local ip=""

  if command -v dig >/dev/null 2>&1; then
    ip="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null | tail -n 1 || true)"
  fi

  if [[ -z "$ip" ]] && command -v curl >/dev/null 2>&1; then
    ip="$(curl -fsS https://api.ipify.org 2>/dev/null || true)"
  fi

  if [[ -z "$ip" ]]; then
    printf 'Unable to determine external IP. Install dig or curl and check network access.\n' >&2
    return 1
  fi

  printf 'External IP: %s\n' "$ip"
}

main "$@"
