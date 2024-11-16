#!/bin/bash

# Check nginx config syntax
if sudo nginx -t; then
    echo "Nginx config test successful. Reloading..."
    sudo systemctl reload nginx
else
    echo "Nginx config test failed. Not reloading."
    exit 1
fi