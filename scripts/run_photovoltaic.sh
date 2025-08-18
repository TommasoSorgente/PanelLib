#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

photovoltaicSubmodulePath="$scriptDir/../photovoltaic_energy"

executable="$photovoltaicSubmodulePath/build/photovoltaic_energy"
parameters="Parameters.csv"
#parameters="$scriptDir/../tests/building/Parameters_Building_Summer.csv"

echo "Running: $executable $parameters"
"$executable" "$parameters" 

echo "done!"
