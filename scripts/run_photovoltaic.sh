#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

photovoltaicSubmodulePath="$scriptDir/photovoltaic_energy"

cd "$photovoltaicSubmodulePath"

executable="build/photovoltaic_energy"
parameters="Parameters.csv"

./$executable $parameters 

echo "done!"
