#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "Error: No hostname provided."
  echo "Usage: $0 <new-hostname>"
  exit 1
fi

# Store the provided hostname argument
NEW_HOSTNAME="$1"

echo "Setting hostname to $NEW_HOSTNAME..."

# Set the hostname (requires root privileges)
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

# Verify the hostname change
echo "New hostname:"
hostnamectl

echo "Hostname has been successfully changed to $NEW_HOSTNAME."
