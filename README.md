# TO DO
- controllare la richiesta di password quando si clona
- scrivere il readme con tutte le dipendenze da librerie e moduli esterni
- valutare se scrivere o uniformare i readme dei singoli submodules
- creare drive coi dati
- ripulire gli output degli script
- correggere nome "extraction_of_roof_piches"
- sottomettere


# PanelLib

Algorithm for estimating the photovoltaic (PV) energy potential of building roofs, relative to the paper "Geometry-aware estimation of photovoltaic energy from aerial LiDAR point clouds".

<p align="center"><img src="pipeline.png" width="1000"></p>

The code is based on three submodules:
- `PiP-partitioning` used to partition an input point cloud representing a city (or a part of it) according to a given list of building footprints;
- `extraction_of_roof_piches` used to identify the boundaries and slopes of the roof pitches in each building;
- `photovoltaic_energy` used to estimate the PV energy produced by each building.

## How to get it 

Clone the repository using --recursive:

```
git clone --recursive https://github.com/TommasoSorgente/PanelLib.git
```

## Content of the repository

- `scripts` bash scripts for compiling and running all the executables;
- `data` meshes, building files and sun database used in the paper, relative to the city of Genoa:
   - `pointcloud.las` point cloud representing the buildings of area #3820 of Genoa georeferenced with EPSG 7791 (from the public geoportal https://mappe.comune.genova.it/MapStore2/#/viewer/1000003072);
   - `footprints` ESRI shapefile representing the buildings footprints of area #3820 of Genoa (from the public geoportal https://mappe.comune.genova.it/MapStore2/#/viewer/1000003072);
   - `city_summer`, `city_winter` meshes of area #3820 of Genoa considered in the paper, with summer and winter vegetation;
   - `sun` sun database derived from the public repository https://climate.onebuilding.org/WMO_Region_6_Europe/ITA_Italy/LG_Liguria/ITA_LG_Genoa.161210_TMYx.2007-2021.zip (note that, in the paper we used private sun data and, therefore, the results may differ);
- `parameters_files` parameters files for reproducing the paper results;

## How to build it

Build through CMake by launching the script `build.sh` in the `scripts` folder.
The following libraries are required:
- CGAL 5.5 (or higher)
- MATLAB modules: 
- **TBD**

Download the data from **TBD**.

## How to use it

In the `scripts` folder, launch the scripts `run_partitioning.sh` and `run_extraction.sh` (in this order) to compute the results of the first two submodules.
The output will be stored in the `data` folder, and has to be computed only once.

Then, set the `Parameters.csv` file according to your needs. 
You can find two examples in the `scripts` folder (for a single building and a whole city), and pre-set parameters files for reproducing the paper results in the `parameters_files` folder.

When launched with the script `run_photovoltaic_building.sh` the program exports .obj meshes of each roof, buffered roof, and PV system, a list of the PV modules installable on each roof with energy details, and shows a preview of the results.

Instead, due to the large number of buildings, with the script `run_photovoltaic_city.sh` the program does not export meshes, and a `output_photovoltaic_city.csv` file is generated with the number of roofs, PV modules and energy of each building.

In both cases, the output of this step is generated in the `data` folder, with one subdirectory per each building.

## Reproduce paper results

In the `parameters_files` folder, we provide predefined parameters files for reproducing Fig. 10, 11, 12, 13, and 14 of the paper.

To do so, modify the `parameters` variable in the `run_photovoltaic_building.sh` (or `run_photovoltaic_city.sh`) script with one of the pre-set parameters configurations and launch it.

After running the script, open ParaView and launch the Python script `visualize_building.py` or `visualize_city.py`.

A pop-up will ask you to specify the ABSOLUTE path of (i) the output folder you want to visualize (e.g., `/home/tommaso/PanelLib/data/output_photovoltaic_single_building`) in the first case, or (ii) the location of the modules file (e.g., `/home/tommaso/PanelLib/data/output_photovoltaic_city.csv`) and the mesh file (e.g., `/home/tommaso/PanelLib/data/city_summer.obj`) in the second case.

Note that, for reproducing Fig. 10(b) you will have to change the color scale to `Cold and Hot`.

## Authors

- Tommaso Sorgente (CNR-IMATI Genova, Italy)
- Chiara Romanengo (CNR-IMATI Genova, Italy)
- Daniela Cabiddu  (CNR-IMATI Genova, Italy)

## Citing us

If you use PanelLib in your academic projects, please consider citing us using the following BibTeX entry:

```
@article{-,
  title={Geometry-aware estimation of photovoltaic energy from aerial LiDAR point clouds},
  author={Romanengo, Chiara and Sorgente, Tommaso and Cabiddu, Daniela and Belussi, Lorenzo and Danza, Ludovico and Ghellere, Matteo and Mortara, Michela},
  journal={Computers & Graphics},
  volume={-},
  number={-},
  pages={-},
  year={2025},
  publisher={Elsevier}
}
```
