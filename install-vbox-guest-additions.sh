#!/usr/bin/env bash
# install-vbox-guest-additions.sh - Helper for preparing a Linux guest for VirtualBox Guest Additions.

set -euo pipefail
IFS=$'\n\t'

usage() {
  cat <<'EOF'
Usage: ./install-vbox-guest-additions.sh [--install-prereqs]

This helper prints the common preparation steps for VirtualBox Guest Additions.
Use --install-prereqs to install common build prerequisites on apt-based systems.
EOF
}

main() {
  local install_prereqs=0

  case "${1:-}" in
    -h|--help)
      usage
      return 0
      ;;
    --install-prereqs)
      install_prereqs=1
      ;;
    "")
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      return 1
      ;;
  esac

  printf 'VirtualBox Guest Additions helper\n'
  printf 'Kernel: %s\n' "$(uname -r)"

  if [[ "$install_prereqs" -eq 1 ]]; then
    if ! command -v apt-get >/dev/null 2>&1; then
      printf 'apt-get not found. Install build tools using your distribution package manager.\n' >&2
      return 1
    fi

    sudo apt-get update
    sudo apt-get install -y build-essential dkms linux-headers-"$(uname -r)"
  else
    cat <<'EOF'

Next steps:
1. In the VirtualBox menu, choose Devices > Insert Guest Additions CD image.
2. Mount the CD image if it does not mount automatically.
3. Review the installer before running it.
4. Run the installer with sudo only if you trust the source.

For apt-based systems, rerun this script with --install-prereqs to install common prerequisites.
EOF
  fi
}

main "$@"
