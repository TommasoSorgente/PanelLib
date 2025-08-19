#!/bin/bash

set -e  # stop at first error

echo "RUNNING PARTITIONING ALGORITHM"
echo "===== $(date) =====" >> run_partitioning.log
./run_partitioning.sh > "run_partitioning.log" 2> "run_partitioning_err.log"
echo "DONE!"
echo ""

echo "RUNNING EXTRACTION ALGORITHM"
echo "===== $(date) =====" >> run_extraction.log
./run_extraction.sh > "run_extraction.log" 2> "run_extraction_err.log"
echo "DONE!"
echo ""

echo "RUNNING PHOTOVOLTAIC ALGORITHM"
echo "===== $(date) =====" >> run_photovoltaic.log
./run_photovoltaic.sh > "run_photovoltaic.log" 2> "run_photovoltaic_err.log"
echo "DONE!"
echo ""
