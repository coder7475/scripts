#!/bin/bash

# Script to create a system user, an app folder, and set appropriate ownership.
# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <username> <appname>" >&2
    exit 1
fi

# Assign arguments to variables
USERNAME=$1
APPNAME=$2

# Create the system user with no login shell and a descriptive comment
sudo useradd -rms /usr/sbin/nologin -c "Running $APPNAME" $USERNAME
if [[ $? -ne 0 ]]; then
    echo "Failed to create user $USERNAME." >&2
    exit 1
fi

# Create the application directory in /opt
APP_DIR="/opt/$APPNAME"
sudo mkdir -p $APP_DIR
if [[ $? -ne 0 ]]; then
    echo "Failed to create application directory $APP_DIR." >&2
    exit 1
fi

# Change ownership of the app directory to the newly created user
sudo chown $USERNAME:$USERNAME $APP_DIR
if [[ $? -ne 0 ]]; then
    echo "Failed to set ownership of $APP_DIR to $USERNAME." >&2
    exit 1
fi

# Print success message
echo "System user $USERNAME created and assigned ownership of $APP_DIR."
