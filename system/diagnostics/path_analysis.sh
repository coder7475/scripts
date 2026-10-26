#!/bin/bash

# IMPORTANT #
# PLEASE MODIFY "..." #
# IMPORTANT #

# Display the full PATH
echo "Full PATH:"
echo $PATH
echo ""

echo "Directories in PATH:"
echo $PATH | tr ':' '\n'
echo ""

# Count and display the number of directories in PATH
echo "Number of directories in PATH: "
echo $PATH | tr ':' '\n' | wc -l
echo ""
# List the first 5 directories in PATH
echo "First 5 directories in PATH:"
echo $PATH | tr ':' '\n' | head -n 5
echo "..."
