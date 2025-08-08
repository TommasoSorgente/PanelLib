#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

photovoltaicSubmodulePath="$scriptDir/../photovoltaic_energy"

cd "$photovoltaicSubmodulePath"

executable="build/photovoltaic_energy"
parameters="Parameters.csv"
#parameters="$scriptDir/../tests/building/Parameters_Building_Summer.csv"

./$executable $parameters 

echo "done!"
