# PanelLib

<p align="center"><img src="pipeline.png" width="750"></p>

Algorithm for estimating the photovoltaic (PV) energy potential of building roofs, relative to the paper "Geometry-aware estimation of photovoltaic energy from aerial LiDAR point clouds".

The code is based on three submodules:
 - `PiP-partitioning` is used to partition the input point cloud;
 - `facades_recognition` is used to identify the roof slopes in each building;
 - `photovoltaic_energy` is used to estimate the PV energy produced by each building.


## How to get it 

Clone the repository using --recursive:

```
git clone --recursive https://github.com/TommasoSorgente/PanelLib.git
```

## Content of the repository

- `data` meshes, building files and sun database used in the paper, relative to the city of Genoa:
   - `buildings`, `single_building` output of the roof extraction and characterization algorithm (https://github.com/chiararomanengo/extraction_of_roof_piches) relative to the whole city and a single building;
   - `city_summer`, `city_summer` meshes of the portion of Genoa considered in the paper, with summer and winter vegetation;
   - `sun` sun database derived from the public repository https://climate.onebuilding.org/WMO_Region_6_Europe/ITA_Italy/LG_Liguria/ITA_LG_Genoa.161210_TMYx.2007-2021.zip (note that, in the paper we used private sun data and, therefore, the results may differ);
- `external` links to external libraries;
- `src` the source code;
- `main.cpp` example of usage;
- `Parameters.csv` parameters file containing all required input;
- `tests` parameters files for reproducing the paper results;

## How to use it

Build through CMake by running the following instructions, being `${REPO_ROOT}` the folder where this `README.md` lies.

```
cd ${REPO_ROOT}
mkdir build
cd build
cmake ..
make
```

The executable will be available in `${REPO_ROOT}/build`.
After that, set the `Parameters.csv` file and launch 

```
cd ${REPO_ROOT}/build
./photovoltaic_energy ${REPO_ROOT}/Parameters.csv
```

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
