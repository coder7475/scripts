#!/bin/bash

echo "Demostration of break:"

for i in {1..10}; do
    if [ $i -eq 6 ]; then
        echo "Breaking the loop at $i"
        break
    fi
    echo $i
done

echo 

echo "Demonstration of continue (Priting odd numbers):"

for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo $i
done