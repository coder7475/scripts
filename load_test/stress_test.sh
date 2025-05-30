#!/bin/bash

echo "Generating CPU load for testing..."
# Only install stress if it's not already present
if ! command -v stress &> /dev/null; then
    echo "Installing stress package..."
    sudo apt-get install -y stress
fi

# Generate Some stress
stress --cpu 4 --timeout 60

echo "Load test complete. Check the dashboard for metrics."