#!/bin/bash

# Define arrays for each cargo bay's inventory
forward_bay=("Space Suits" "Oxygen Tanks" "Repair Kits")
midship_bay=("Food Supplies" "Water Containers" "Medical Equipment")
aft_bay=("Spare Pars" "Fuel Cells" "Scientific Instruments")

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Please specify a cargo bay: forward, midship or aft"
    exit 1
fi

# Display inventory based on the argument
if [ "$1" = "forward" ]; then
    # Your code here
    echo "Forward Bay Inventory:"
    i=1
    for item in "${forward_bay[@]}"; do
        echo "$i. $item"
        ((i++))
    done
elif [ "$1" = "midship" ]; then
    # Your code here
    echo "Midship Bay Inventory:"
    i=1
    for item in "${midship_bay[@]}"; do
        echo "$i. $item"
        ((i++))
    done
elif [ "$1" = "aft" ]; then
    # Your code here
    echo "Aft Bay Inventory:"
    i=1
    for item in "${aft_bay[@]}"; do
        echo "$i. $item"
        ((i++))
    done
else
    # Your code here
    echo "Invalid cargo bay. Choose forward, midship or aft"
    exit 1
fi
