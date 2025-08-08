#!/bin/bash

# Path to this script's directory
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

partitioningSubmodulePath="$scriptDir/../PiP-partitioning"

cd "$partitioningSubmodulePath"

executable="bin/PiP-partitioning"
output_folder="$scriptDir/../data/output_partitioning"
las_file="$scriptDir/../data/pointcloud.las"
polys="$scriptDir/../data/footprints/edifici-3820.shp"

mkdir $output_folder

export LD_LIBRARY_PATH=$partitioningSubmodulePath/external/proj/install-Linux/lib:$LD_LIBRARY_PATH

echo "$executable -L $output_folder -l $las_file -p $polys"
./$executable -L $output_folder -l $las_file -p $polys

echo "done!"
