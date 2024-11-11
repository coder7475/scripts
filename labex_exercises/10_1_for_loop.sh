#!/bin/bash

echo "Looping through an array"

NAMES=("Robiul" "Hossain" "Fahad")

for name in "${NAMES[@]}"; do
    echo "Hello $name"
done

echo

echo "Looping through a range of numbers"

for i in {1..5}; do
  echo "Number: $i"
done
