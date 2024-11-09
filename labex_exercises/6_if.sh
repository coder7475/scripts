#!/bin/bash

NAME="George"
if [ "$NAME" = "John" ]; then
  echo "John Lennon"
elif [ "$NAME" = "Paul" ]; then
  echo "Paul McCartney"
elif [ "$NAME" = "George" ]; then
  echo "George Harrison"
elif [ "$NAME" = "Ringo" ]; then
  echo "Ringo Starr"
else
  echo "Unknown member"
fi