#!/bin/bash

check_item() {
    local item="$1"
    echo "Checking: $item"
    
    # Check if item exists
    if [ ! -e "$item" ]; then
        echo "Exists: No"
        exit 1
    else
        echo "Exists: Yes"
    fi

    # Check if it's a file
    if [ -f "$item" ]; then
        echo "Type: File"
    # Check if it's a directory 
    elif [ -d "$item" ]; then
        echo "Type: Directory"
    fi

    if [ -r "$item" ]; then
        echo "Readable: Yes"
    else
        echo "Readable: No"
    fi
    
}

# Main script
if [ $# -eq 0 ]; then
    echo "Please provide a file or directory name as an argument."
    exit 1
fi

check_item "$1"
