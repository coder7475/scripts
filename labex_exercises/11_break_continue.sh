#!/bin/bash

echo "Demostration of break:"

for i in {1..10}; do
    if [ $i -eq 6 ]; then
        echo "Breaking the loop at $i"
        break
    fi
    echo $i
done