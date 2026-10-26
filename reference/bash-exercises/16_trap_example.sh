#!/bin/bash

cleanup_and_exit() {
  echo -e "\nSignal received! Cleaning up..."
  echo "Performing cleanup tasks..."
  # Add any necessary cleanup code here
  echo "Cleanup completed."
  echo "Exiting script gracefully."
  exit 0
}

trap cleanup_and_exit SIGINT SIGTERM

echo "This script will run until you press Ctrl+C."
echo "Press Ctrl+C to see the trap function in action and exit gracefully."

count=1
while true; do
  echo "Script is running... (iteration $count)"
  sleep 1
  ((count++))
done