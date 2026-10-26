#!/bin/bash

# update_git.sh - Script to update Git to the latest version
# Exit immediately if a command exits with a non-zero status
set -e

# Print each command before executing
set -x

echo "Starting Git update process..."

# Update package lists
sudo apt update

# Make sure the Git PPA is added
if ! grep -q "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  echo "Adding Git PPA repository..."
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
else
  echo "Git PPA already added."
fi

# Get current Git version before update
CURRENT_VERSION=$(git --version | awk '{print $3}')
echo "Current Git version: $CURRENT_VERSION"

# Install/update Git
echo "Updating Git to the latest version..."
sudo apt install -y git

# Verify update
NEW_VERSION=$(git --version | awk '{print $3}')
echo "Updated Git version: $NEW_VERSION"

if [ "$CURRENT_VERSION" = "$NEW_VERSION" ]; then
  echo "Git is already at the latest version ($NEW_VERSION)."
else
  echo "Successfully updated Git from $CURRENT_VERSION to $NEW_VERSION."
fi

echo "Git update process completed!"
