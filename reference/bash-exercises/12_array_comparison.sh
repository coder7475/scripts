#!/bin/bash

# Initialize the arrays
a=(3 5 8 10 6)
b=(6 5 4 12)
c=(14 7 5 7)

# Initialize an array to store common elements between a and b
z=()

# Compare arrays a and b
for x in "${a[@]}"; do
  for y in "${b[@]}"; do
    if [ $x = $y ]; then
      z+=($x)
    fi
  done
done

echo "Common elements between a and b: ${z[@]}"

# Initialize an array to store common elements among a, b, and c
j=()

# Compare array c with the common elements found in z
for i in "${c[@]}"; do
  for k in "${z[@]}"; do
    if [ $i = $k ]; then
      j+=($i)
    fi
  done
done

echo "Common elements among a, b, and c: ${j[@]}"