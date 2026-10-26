#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print each command before executing
set -x

echo "Updating PM2 to the latest version..."

# Check if PM2 is installed
if ! command -v pm2 &>/dev/null; then
  echo "PM2 is not installed. Installing PM2..."
  sudo npm install -g pm2
else
  echo "PM2 is already installed. Updating to the latest version..."

  # Save the current PM2 processes
  echo "Saving current PM2 process list..."
  pm2 save

  # Update PM2 globally
  sudo npm update -g pm2

  # Verify PM2 is updated
  echo "PM2 updated to version:"
  pm2 --version

  # Restart PM2 daemon with updated version
  echo "Restarting PM2 daemon..."
  pm2 update
fi

echo "PM2 update completed successfully!"
