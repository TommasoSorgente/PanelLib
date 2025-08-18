#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Submodules
partitioningSubmodulePath="$scriptDir/../PiP-partitioning"
extractionSubmodulePath="$scriptDir/../extraction_of_roof_piches"
photovoltaicSubmodulePath="$scriptDir/../photovoltaic_energy"

#

echo "compiling Partitioning submodule"
cd "$partitioningSubmodulePath"
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
echo "Partitioning submodule done!"

#

echo "compiling Extraction submodule"
CGAL_path="$extractionSubmodulePath/CGAL-apps"
output_path="$extractionSubmodulePath/code"
cd $CGAL_path
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=$output_path -DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE=$output_path 
make 
echo "Extraction submodule done!"

#

echo "compiling Photovoltaic submodule"
cd "$photovoltaicSubmodulePath"
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j4
echo "Photovoltaic submodule done!"

echo "All done!"
