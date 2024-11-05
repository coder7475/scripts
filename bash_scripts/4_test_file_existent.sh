#!/bin/bash

if cp Documents/test.c /dev/null 2> /dev/null; then
  echo "File exists and is readable"
else
  echo "File does not exist or is not readable"
fi