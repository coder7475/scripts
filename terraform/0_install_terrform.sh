#!/usr/bin/env bash
set -euo pipefail

# Detect OS/ARCH in HashiCorp naming
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH_RAW="$(uname -m)"

case "${ARCH_RAW}" in
  x86_64|amd64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: ${ARCH_RAW}"
    exit 1
    ;;
esac

# Find latest stable Terraform version from HashiCorp releases index
LATEST_VERSION="$(
  curl -fsSL https://releases.hashicorp.com/terraform/ \
  | grep -Eo 'terraform_[0-9]+\.[0-9]+\.[0-9]+' \
  | head -n 1 \
  | cut -d_ -f2
)"

ZIP="terraform_${LATEST_VERSION}_${OS}_${ARCH}.zip"
URL="https://releases.hashicorp.com/terraform/${LATEST_VERSION}/${ZIP}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

echo "Downloading Terraform ${LATEST_VERSION} (${OS}_${ARCH}) ..."
curl -fL "${URL}" -o "${tmpdir}/${ZIP}"

# Unzip to a directory on PATH (system-wide)
sudo unzip -o "${tmpdir}/${ZIP}" -d /usr/local/bin

# Ensure executable bit (usually already set)
sudo chmod +x /usr/local/bin/terraform

echo "Installed to /usr/local/bin/terraform"
terraform -version

