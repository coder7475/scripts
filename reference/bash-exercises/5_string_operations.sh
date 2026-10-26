#!/bin/bash

echo "Step 2: String Length"

STRING="Hello, World!"
LENGTH=${#STRING}

echo "The string is: $STRING"
echo "Its length is: $LENGTH"

echo -e "\nStep 3: Finding Character Position"

STRING="abcdefghijklmnopqrstuvwxyz"
CHAR="j"

POSITION=$(expr index "$STRING" "$CHAR")

echo "The string is: $STRING"
echo "We're looking for the character: $CHAR"
echo "It is at position: $POSITION"

echo -e "\nStep 4: Substring Extraction"

STRING="The quick brown fox jumps over the lazy dog"
START=10
LENGTH=5

SUBSTRING=${STRING:$START:$LENGTH}

echo "The original string is: $STRING"
echo "Extracting 5 characters starting from position 10:"
echo "The substring is: $SUBSTRING"

echo -e "\nStep 5: String Replacement"

STRING="The quick brown fox jumps over the lazy dog"
echo "Original string: $STRING"

# Replace the first occurrence of 'o' with 'O'
NEW_STRING=${STRING/o/O}
echo "Replacing first 'o' with 'O': $NEW_STRING"

# Replace all occurrences of 'o' with 'O'
NEW_STRING=${STRING//o/O}
echo "Replacing all 'o' with 'O': $NEW_STRING"

# Replace 'quick' with 'slow' if it's at the beginning of the string
NEW_STRING=${STRING/#quick/slow}
echo "Replacing 'quick' with 'slow' at the beginning: $NEW_STRING"

# Replace 'dog' with 'cat' if it's at the end of the string
NEW_STRING=${STRING/%dog/cat}
echo "Replacing 'dog' with 'cat' at the end: $NEW_STRING"