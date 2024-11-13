#!/bin/bash

echo "Running a successful command:"
ls /home
echo "Exit status: $?"

echo "Running a command that will fail:"
ls /nonexistent_directory
echo "Exit status: $?"

echo "Running a background process:"
sleep 2 &
echo "Process ID of last background command: $!"