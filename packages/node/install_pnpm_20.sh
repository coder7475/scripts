#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print each command before executing
set -x

echo "Installing pnpm package manager using Node.js v20 and corepack..."

# Check if Node.js is installed and if it's version 20
if ! command -v node &>/dev/null || [[ $(node -v) != v20* ]]; then
  echo "Node.js v20 is not installed. Installing Node.js v20..."

  # Install Node.js v20 using the NodeSource repository
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs

  # Verify Node.js installation
  echo "Node.js version:"
  node --version
fi

# Enable corepack (included with Node.js v20)
echo "Enabling corepack..."
sudo corepack enable

# Install pnpm using corepack
echo "Installing pnpm using corepack..."
corepack prepare pnpm@latest --activate

# Verify installation
echo "pnpm installed successfully:"
pnpm --version

echo "pnpm installation completed successfully!"
