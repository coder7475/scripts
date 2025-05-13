#!/bin/bash

# Check if a file is provided
if [ -z "$1" ]; then
  echo "Usage: run_cpp <filename.cpp>"
  exit 1
fi

# Remove extension and get filename base
filename=$(basename "$1" .cpp)
dir=$(dirname "$1")
output="$dir/$filename.out"

# Compile
g++ -std=c++17 "$1" -o "$output"

# Check if compilation succeeded
if [ $? -eq 0 ]; then
  echo "Compiled successfully. Running $output..."
  echo "-------------------------------"
  "$output"
else
  echo "Compilation failed."
fi
