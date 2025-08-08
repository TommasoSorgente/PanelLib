#!/bin/bash

# Main folder to start from 
MAIN_FOLDER="./City_Summer/"

# Name of the output file
OUTPUT="./modules_summer.txt"

# Find all .txt files (excluding any previous output)
FILES=$(find "$MAIN_FOLDER" -type f -name "*.txt" ! -name "$OUTPUT")

# Remove the output file if it already exists
rm -f "$OUTPUT"

# Take the header from the first file found
for f in $FILES; do
    head -n 1 "$f" > "$OUTPUT"
    break
done

# Append the data from all files (excluding the header)
for f in $FILES; do
    tail -n +2 "$f" >> "$OUTPUT"
done

echo "Merge completed: $OUTPUT"
