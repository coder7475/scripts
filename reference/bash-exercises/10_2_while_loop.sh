#!/bin/bash

count=5

echo "Countdown:"

while [ $count -gt 0 ]; do 
    echo $count
    count=$((count - 1))
    sleep 1
done

echo 

echo "Blast off!"

echo 
