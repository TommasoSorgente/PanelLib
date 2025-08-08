#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

extractionSubmodulePath="$scriptDir/../extraction_of_roof_piches"

cd "$extractionSubmodulePath/code"

# MATLAB executable
matlabExe="/home/tommaso/MATLAB2025/bin/matlab"

"$matlabExe" -batch "main"

echo "done!"
