#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

photovoltaicSubmodulePath="$scriptDir/../photovoltaic_energy"

executable="$photovoltaicSubmodulePath/build/photovoltaic_energy"
#parameters="Parameters_Building.csv"
parameters="$scriptDir/../parameters_files/Parameters_Building_Summer.csv"

echo "Running: $executable $parameters"
"$executable" "$parameters" 

echo "done!"
