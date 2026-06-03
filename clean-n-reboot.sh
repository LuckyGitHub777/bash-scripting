#!/usr/bin/env bash
# clean-n-reboot.sh - Safe system cleanup helper with dry-run behavior by default.

set -euo pipefail
IFS=$'\n\t'

usage() {
  cat <<'EOF'
Usage: ./clean-n-reboot.sh [--apply] [--reboot]

Default is dry-run. Use --apply to run cleanup commands.
Use --reboot only with --apply if you want to reboot after cleanup.
EOF
}

run_or_print() {
  if [[ "$APPLY" -eq 1 ]]; then
    "$@"
  else
    printf 'Would run:'
    printf ' %q' "$@"
    printf '\n'
  fi
}

main() {
  APPLY=0
  local reboot_after=0

  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        return 0
        ;;
      --apply)
        APPLY=1
        ;;
      --reboot)
        reboot_after=1
        ;;
      *)
        printf 'Unknown option: %s\n' "$arg" >&2
        usage >&2
        return 1
        ;;
    esac
  done

  printf 'Safe cleanup helper\n'

  if command -v apt-get >/dev/null 2>&1; then
    run_or_print sudo apt-get clean
    run_or_print sudo apt-get autoremove -y
  else
    printf 'apt-get not found. Skipping apt cleanup.\n'
  fi

  if [[ "$reboot_after" -eq 1 ]]; then
    if [[ "$APPLY" -ne 1 ]]; then
      printf 'Dry run: reboot requested but not applied. Use --apply --reboot to reboot.\n'
      return 0
    fi

    read -r -p "Reboot this system now? [y/N] " answer
    case "$answer" in
      y|Y|yes|YES)
        sudo reboot
        ;;
      *)
        printf 'Reboot cancelled.\n'
        ;;
    esac
  else
    printf 'Cleanup step complete. Reboot not requested.\n'
  fi
}

main "$@"
