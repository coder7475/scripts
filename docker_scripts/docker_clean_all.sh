#!/bin/bash

echo "Cleaning up Docker system... This will remove all unused images, containers, networks, and volumes."
docker system prune -a --volumes -f

echo "Cleanup complete!"
