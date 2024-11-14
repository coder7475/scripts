#!/bin/bash
# Script to update, upgrade, and autoremove packages

# Function to check if a command was successful
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed"
        exit 1
    fi
}

echo "Starting system update and upgrade..."

# Run apt update
sudo apt update
check_status "apt update"

# Run apt upgrade with automatic yes to prompts
sudo apt upgrade -y
check_status "apt upgrade"

# Run apt autoremove to remove unnecessary packages
sudo apt autoremove -y
check_status "apt autoremove"

echo "System update, upgrade, and autoremove completed successfully."
