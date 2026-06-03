#!/usr/bin/env bash
# fix-zsh-corrupt-history.sh - Create a safe repaired copy of a corrupted Zsh history file.

set -euo pipefail
IFS=$'\n\t'

usage() {
  cat <<'EOF'
Usage: ./fix-zsh-corrupt-history.sh [--apply]

Creates a backup of ~/.zsh_history and writes a cleaned copy to ~/.zsh_history.repaired.
Use --apply to replace ~/.zsh_history with the repaired copy after backup.
EOF
}

main() {
  local apply=0

  case "${1:-}" in
    -h|--help)
      usage
      return 0
      ;;
    --apply)
      apply=1
      ;;
    "")
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      return 1
      ;;
  esac

  local history_file="${ZSH_HISTORY:-$HOME/.zsh_history}"
  local timestamp backup_file repaired_file

  if [[ ! -f "$history_file" ]]; then
    printf 'Zsh history file not found: %s\n' "$history_file" >&2
    return 1
  fi

  timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
  backup_file="${history_file}.backup.${timestamp}"
  repaired_file="${history_file}.repaired"

  cp "$history_file" "$backup_file"
  strings "$history_file" > "$repaired_file"

  printf 'Backup created:   %s\n' "$backup_file"
  printf 'Repaired copy:    %s\n' "$repaired_file"

  if [[ "$apply" -eq 1 ]]; then
    mv "$repaired_file" "$history_file"
    printf 'Applied repaired history to: %s\n' "$history_file"
  else
    printf 'Dry run complete. Review the repaired copy before applying.\n'
  fi
}

main "$@"
