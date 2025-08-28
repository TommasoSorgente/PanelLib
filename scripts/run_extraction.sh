#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

extractionSubmodulePath="$scriptDir/../extraction_of_roof_pitches"

cd "$extractionSubmodulePath/code"

# MATLAB executable
matlabExe="/home/tommaso/MATLAB2025/bin/matlab"
output_folder="$scriptDir/../data/output_extraction"

echo "Running: $matlabExe"
"$matlabExe" -batch "main" || { echo "MATLAB Error"; exit 1; }

rm -rf "buildings_Segm"

mkdir -p "$scriptDir/../data/output_extraction_single_building"
cp -r "$output_folder/building918" "$scriptDir/../data/output_extraction_single_building"

echo "done!"
