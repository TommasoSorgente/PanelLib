#!/bin/bash

echo "RUNNING PARTITIONING ALGORITHM"
./run_partitioning.sh
echo "DONE!"
echo ""
echo ""

echo "RUNNING EXTRACTION ALGORITHM"
./run_extraction.sh
echo "DONE!"
echo ""
echo ""

echo "RUNNING PHOTOVOLTAIC ALGORITHM"
./run_photovoltaic.sh
echo "DONE!"
echo ""
echo ""
