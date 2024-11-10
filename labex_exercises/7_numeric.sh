#!/bin/bash

NUMBER=10

if [ $NUMBER -lt 5 ]; then
  echo "The number is less than 5"
elif [ $NUMBER -eq 10 ]; then
  echo "The number is exactly 10"
elif [ $NUMBER -gt 15 ]; then
  echo "The number is greater than 15"
else
  echo "The number is between 5 and 15, but not 10"
fi