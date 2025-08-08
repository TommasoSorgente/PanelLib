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
   - `single_building` pre-computed output of the roof extraction and characterization algorithm relative to a single building (for reproducing paper results);
- `tests` parameters files for reproducing the paper results;

## How to use it

Build through CMake by launching the script `build.sh`.
You can run the whole pipeline at once through the script `run.sh`.

Alternatively, for a manual run:
 - launch the script `run_partitioning.sh`;
 - launch the script `run_extraction.sh`;
 - set the `Parameters.csv` file;
 - launch the script `run_photovoltaic.sh`;

In the `tests` folder, you can find pre-set parameters files for reproducing the paper results.

The algorithm will print the following output files in the output path specified in `Parameters.csv`:
- a summary of the number of roofs, PV modules and energy of each building;
- for each roof, a list of its PV modules with energy details;
- for each roof, if selected, .obj meshes of the roof, the buffered roof, and the PV system;

Moreover, if GUI is selected, a graphical interface will show a preview of the result.

## Reproduce paper results

In the `tests` folder, we provide predefined parameters files for reproducing some of the paper results and figures.

The ones in `building` allow to generate the results presented in Fig. 10, 11, and 12.
After running the executable with one of such parameters configurations, launch ParaView, select `Load State` and pick the file `visualize_building.py` (you may have to select Python among the file types).
A pop-up will ask you to specify the ABSOLUTE path of the output folder you want to visualize. Note that, for reproducing Fig. 10(b) you will have to change the color scale to `Cold and Hot`.

The ones in `city` allow to generate the results presented in Fig. 13 and 14 of the paper.
In this case, due to the huge number of buildings, the program only outputs the list of PV modules of each roof (and not the .obj mesh files).
You can use the script `cat_modules.sh` to merge all modules files into a single one, and load the script `visualize_city.py` from ParaView to visualize them together with the city mesh.

## Authors

- Tommaso Sorgente (CNR-IMATI Genova, Italy)
- Chiara Romanengo (CNR-IMATI Genova, Italy)
- Daniela Cabiddu  (CNR-IMATI Genova, Italy)

## Citing us

If you use PanelLib in your academic projects, please consider citing us using the following BibTeX entry:

```
@article{sorgente2022role,
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
