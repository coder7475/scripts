#!/bin/bash
# setup_git_config.sh
# A simple script to configure git user name and email

# Ask for name and email
read -p "Enter your Git user name: " username
read -p "Enter your Git email: " email

# Ask whether to set globally or locally
read -p "Do you want to set this globally? (y/n): " global_choice

# Apply configuration
if [[ "$global_choice" =~ ^[Yy]$ ]]; then
  git config --global user.name "$username"
  git config --global user.email "$email"
  echo "✅ Git global configuration set successfully!"
else
  git config user.name "$username"
  git config user.email "$email"
  echo "✅ Git local configuration set successfully!"
fi

# Show the result
echo
echo "Current Git configuration:"
git config --list | grep 'user\.'

