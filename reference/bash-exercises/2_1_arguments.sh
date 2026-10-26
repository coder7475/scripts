#!/bin/bash


if [ $# -eq 0 ]; then
    echo "No arguments provided."
elif [ $# -eq 1 ]; then
    echo "one argument is provided: $1"
elif [ $# -eq 2 ]; then
    echo "Two arguments provided: $1 and $2"
else
    echo "More than two arguments provided"
    echo "First argument: $1"
    echo "Second argument: $2"
    echo "Third argument: $3"
    echo "Total number of arguments: $#"
fi

