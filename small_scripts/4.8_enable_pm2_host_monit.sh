#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print each command before executing
set -x

echo "Setting up PM2 system monitoring..."

# Check if PM2 is installed
if ! command -v pm2 &>/dev/null; then
  echo "Error: PM2 is not installed. Please install PM2 first."
  echo "You can install it with: npm install -g pm2"
  exit 1
fi

# Save current PM2 processes before making changes
echo "Saving current PM2 process list..."
pm2 save

# Enable PM2 system monitoring
echo "Enabling PM2 system monitoring..."
pm2 set pm2:sysmonit true

# Update PM2 to apply changes
echo "Updating PM2..."
pm2 update

# Verify system monitoring is enabled
echo "Verifying system monitoring status..."
pm2 conf | grep sysmonit

echo "PM2 system monitoring has been successfully enabled!"
