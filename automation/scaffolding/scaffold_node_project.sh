#!/bin/bash

list_of_files=(
    "src/app.js"
    "src/config/database.js"
    "src/controllers/authController.js" 
    "src/controllers/userController.js"
    "src/middleware/auth.js"
    "src/middleware/error.js"
    "src/models/User.js"
    "src/routes/auth.js"
    "src/routes/users.js"
    "src/utils/logger.js"
    "src/utils/validation.js"
    "tests/auth.test.js"
    "tests/users.test.js"
    ".env"
    "package.json"
)

for filepath in "${list_of_files[@]}"; do
    filedir=$(dirname "$filepath")
    filename=$(basename "$filepath")

    if [ ! -d "$filedir" ] && [ "$filedir" != "." ]; then
        mkdir -p "$filedir"
        echo "Creating directory: $filedir for the file $filename"
    fi

    if [ ! -e "$filepath" ] || [ ! -s "$filepath" ]; then
        touch "$filepath"
        echo "Creating empty file: $filepath"
    else
        echo "$filename already exists"
    fi
done