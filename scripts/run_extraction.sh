#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

extractionSubmodulePath="$scriptDir/extraction_of_roof_piches"

cd "$extractionSubmodulePath/code"

# MATLAB executable (modifica se diverso o usa `matlab` se è nel PATH)
matlabExe="/home/tommaso/matlab/bin/matlab"

# Lancia recognition (MATLAB batch mode)
"$matlabExe" -batch "main"

echo "done!"
