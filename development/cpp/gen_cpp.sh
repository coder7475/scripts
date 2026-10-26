#!/bin/bash

# Default file name if not provided
filename=${1:-main.cpp}

# Check if file already exists
if [ -f "$filename" ]; then
    echo "Error: '$filename' already exists."
    exit 1
fi

# Create the C++ template
cat <<EOF >"$filename"
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    int t;
    vector<int> v;
    // Your code here

    return 0;
}
EOF

# Make it clear
echo "C++ template created: $filename"
