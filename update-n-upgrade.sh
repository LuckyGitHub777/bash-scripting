#!/usr/bin/env bash
# update-n-upgrade.sh - Run package update and upgrade commands on apt-based systems.

set -euo pipefail
IFS=$'\n\t'

usage() {
  cat <<'EOF'
Usage: ./update-n-upgrade.sh [--yes]

Runs apt-get update and apt-get upgrade.
Use --yes to skip the confirmation prompt.
EOF
}

main() {
  local assume_yes=0

  case "${1:-}" in
    -h|--help)
      usage
      return 0
      ;;
    --yes|-y)
      assume_yes=1
      ;;
    "")
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      return 1
      ;;
  esac

  if ! command -v apt-get >/dev/null 2>&1; then
    printf 'apt-get not found. This script is intended for apt-based Linux systems.\n' >&2
    return 1
  fi

  if [[ "$assume_yes" -ne 1 ]]; then
    read -r -p "Run apt-get update and upgrade now? [y/N] " answer
    case "$answer" in
      y|Y|yes|YES) ;;
      *) printf 'Cancelled.\n'; return 0 ;;
    esac
  fi

  sudo apt-get update
  sudo apt-get upgrade -y
}

main "$@"
