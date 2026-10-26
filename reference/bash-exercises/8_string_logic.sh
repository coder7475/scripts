#!/bin/bash

STRING1="hello"
STRING2="world"
NUMBER1=5
NUMBER2=10

if [ "$STRING1" = "hello" ] && [ "$STRING2" = "world" ]; then
  echo "Both strings match"
fi

if [ $NUMBER1 -lt 10 ] || [ $NUMBER2 -gt 5 ]; then
  echo "At least one of the number conditions is true"
fi

if [[ "$STRING1" != "$STRING2" ]]; then
  echo "The strings are different"
fi

if [[ -z "$STRING3" ]]; then
  echo "STRING3 is empty or not set"
fi