#!/bin/bash

# This script demonstrates the difference between $@ and $* 
# $@ treats each argument as a separate item
# $* combines all arguments into a single string

echo "Using \$@:"
for arg in "$@"; do
  echo "Argument: $arg"
done

echo "Using \$*:"
for arg in "$*"; do
  echo "Argument: $arg"
done

# Example output when running: ./15_4_at_vs_star.sh "hello world" foo bar
#
# Using $@:
# Argument: hello world
# Argument: foo  
# Argument: bar
#
# Using $*:
# Argument: hello world foo bar
#
# $@ preserves arguments with spaces as single items
# $* joins all arguments with spaces into one string