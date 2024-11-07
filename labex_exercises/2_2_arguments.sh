#!/bin/bash

echo "Total number of arguments: $#"
echo "All arguments:"

count=1

for arg in "$@"; do 
    echo "Agument $count: $arg"
    count=$((count+1))
done