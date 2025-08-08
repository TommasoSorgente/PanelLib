#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

extractionSubmodulePath="$scriptDir/../extraction_of_roof_piches"

cd "$extractionSubmodulePath/code"

# MATLAB executable
matlabExe="/home/tommaso/MATLAB2025/bin/matlab"
output_folder="$scriptDir/../data/output_extraction"

"$matlabExe" -batch "main"

rm -r "buildings_Segm"

mkdir "$scriptDir/../data/single_building"
cp "$output_folder/building918" "$scriptDir/../data/single_building"

echo "done!"
