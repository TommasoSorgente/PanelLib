#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Submodules
partitioningSubmodulePath="/../$scriptDir/PiP-partitioning"
extractionSubmodulePath="/../$scriptDir/extraction_of_roof_piches"
photovoltaicSubmodulePath="/../$scriptDir/photovoltaic_energy"

echo "compiling Partitioning submodule"
cd $partitioningSubmodulePath
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

echo "compiling Extraction submodule"
cd $extractionSubmodulePath
./build.sh
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

echo "compiling Photovoltaic submodule"
cd $photovoltaicSubmodulePath
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j4

echo "done!"
