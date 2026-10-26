#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <process-name>"
  exit 1
fi

PROCESS_NAME="$1"

# Find PIDs of all processes containing the specified name
# Using ps and awk to get PIDs, excluding grep itself and this script's process
PIDS=$(ps aux | grep "$PROCESS_NAME" | grep -v grep | grep -v $0 | awk '{print $2}')

# Check if any PIDs were found
if [ -z "$PIDS" ]; then
  echo "No processes containing '$PROCESS_NAME' found"
  exit 0
fi

# Display found processes before killing
echo "Found the following processes containing '$PROCESS_NAME':"
for PID in $PIDS; do
  ps -p "$PID" -o pid,ppid,user,%cpu,%mem,cmd
done

# Kill each process
for PID in $PIDS; do
  if kill "$PID" 2>/dev/null; then
    echo "Successfully terminated process $PID"
  else
    echo "Failed to terminate process $PID"
  fi
done

# Verify no processes remain
echo -e "\nChecking for any remaining processes containing '$PROCESS_NAME':"
ps aux | grep "$PROCESS_NAME" | grep -v grep | grep -v $0
