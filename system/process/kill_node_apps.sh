#!/bin/bash

# Script to kill all running Node.js applications

echo "Looking for Node.js processes..."

# Find all Node.js processes
NODE_PROCESSES=$(ps aux | grep node | grep -v grep | awk '{print $2}')

# Check if any Node.js processes were found
if [ -z "$NODE_PROCESSES" ]; then
  echo "No Node.js processes are currently running."
  exit 0
fi

# Display all found processes
echo "Found the following Node.js processes:"
ps aux | grep node | grep -v grep

# Count the number of processes
NODE_COUNT=$(echo "$NODE_PROCESSES" | wc -l)
echo "Total Node.js processes found: $NODE_COUNT"

# Ask for confirmation before killing
read -p "Do you want to kill all these Node.js processes? (y/n): " CONFIRM

if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
  # Kill all found Node.js processes
  echo "$NODE_PROCESSES" | xargs kill -9
  echo "All Node.js processes have been terminated."
else
  echo "Operation cancelled. No processes were killed."
fi
