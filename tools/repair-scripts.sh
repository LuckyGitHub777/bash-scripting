#!/usr/bin/env bash
# repair-scripts.sh - Normalize .sh files, add shebangs if missing, and set executable bits.

set -euo pipefail
IFS=$'\n\t'

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

normalize_line_endings() {
  local file="$1"
  if command -v perl >/dev/null 2>&1; then
    perl -pi -e 's/\r\n?/\n/g' "$file"
  else
    sed -i 's/\r$//' "$file"
  fi
}

ensure_shebang() {
  local file="$1"
  local first_line

  first_line="$(sed -n '1p' "$file" || true)"
  if [[ "$first_line" != "#!"* ]]; then
    local tmp_file
    tmp_file="$(mktemp)"
    {
      printf '%s\n' '#!/usr/bin/env bash'
      printf '\n'
      cat "$file"
    } > "$tmp_file"
    mv "$tmp_file" "$file"
  fi
}

find . -type f -name "*.sh" -not -path "./archive/*" -print0 |
while IFS= read -r -d '' file; do
  printf 'Processing: %s\n' "$file"
  normalize_line_endings "$file"
  ensure_shebang "$file"
  chmod +x "$file"
done

printf 'Repair complete. Review scripts, then run ShellCheck if available.\n'
