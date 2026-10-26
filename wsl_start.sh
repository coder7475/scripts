#!/usr/bin/env bash
# ==============================================================================
# WSL / Ubuntu Environment Bootstrap Entry Point
# ==============================================================================
# Forwards execution to the canonical bootstrap script located in bootstrap/wsl_start.sh.
# Maintains backward compatibility with:
#   curl -fsSL https://raw.githubusercontent.com/coder7475/scripts/main/wsl_start.sh | bash
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_SCRIPT="$SCRIPT_DIR/bootstrap/wsl_start.sh"

if [[ -f "$TARGET_SCRIPT" ]]; then
  exec bash "$TARGET_SCRIPT" "$@"
else
  # Fallback for when piped directly via curl
  bash <(curl -fsSL "https://raw.githubusercontent.com/coder7475/scripts/main/bootstrap/wsl_start.sh") "$@"
fi
