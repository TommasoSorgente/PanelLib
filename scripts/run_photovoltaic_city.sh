#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

photovoltaicSubmodulePath="$scriptDir/../photovoltaic_energy"

executable="$photovoltaicSubmodulePath/build/photovoltaic_energy"
parameters="Parameters_City.csv"
#parameters="$scriptDir/../parameters_files/Parameters_City_Summer.csv"

echo "Running: $executable $parameters"
"$executable" "$parameters" 

echo "done!"
echo ""
echo "Merging PV modules"

# Main folder to start from 
MAIN_FOLDER="../data/output_photovoltaic/"

# Name of the output file
OUTPUT="../data/output_photovoltaic_modules.csv"

# Remove the output file if it already exists
rm -f "$OUTPUT"

# Find all .txt files (excluding any previous output) 
FILES=$(find "$MAIN_FOLDER" -type f -name "*.txt" ! -wholename "$OUTPUT")

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
