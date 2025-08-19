# state file generated using paraview version 5.13.1

from paraview.simple import *
import os
import sys

paraview.compatibility.major = 5
paraview.compatibility.minor = 13
paraview.simple._DisableFirstRenderCameraReset()

# Safely clear the Pipeline Browser
sources = list(GetSources().values())
for source in sources:
    Delete(source)
del sources

# Setup view and layout
renderView1 = CreateView('RenderView')
renderView1.UseColorPaletteForBackground = 0
renderView1.Background = [1.0, 1.0, 1.0]
layout1 = CreateLayout(name='Layout #1')
layout1.AssignView(0, renderView1)
SetActiveView(renderView1)

# Ask for district_path
if not sys.argv or len(sys.argv) == 1:
   district_path = input("Input the ABSOLUTE path of the output folder: ").strip()
else:
   district_path = sys.argv[1]
district_dir = os.path.basename(os.path.normpath(district_path))
print(f"Processing district: {district_dir}")

# Define datasets
BufferDatasets       = GroupDatasets(registrationName='BufferDatasets',         Input=[])
RoofDataset          = GroupDatasets(registrationName='RoofDataset',            Input=[])
ModulesDataset       = GroupDatasets(registrationName='ModulesDataset',         Input=[])
TableToPointsDataset = GroupDatasets(registrationName='TableToPointsDataset',   Input=[])

# Load data
for building_dir in filter(lambda d: os.path.isdir(os.path.join(district_path, d)), os.listdir(district_path)):
    building_path = os.path.join(district_path, building_dir)
    print(f"Processing building: {building_dir}")

    for roof_dir in filter(lambda d: os.path.isdir(os.path.join(building_path, d)), os.listdir(building_path)):
        roof_path = os.path.join(building_path, roof_dir)
        print(f"Processing roof: {roof_dir}")

        for module in os.listdir(roof_path):
            module_path = os.path.join(roof_path, module)
            registration_name = f"{roof_dir}/{module}"
            print(f"Loading module: {module_path}")

            if module.endswith('.obj'):
                reader = WavefrontOBJReader(registrationName=registration_name, FileName=module_path)
                if 'buffer' in module:
                    BufferDatasets.Input.append(reader)
                elif 'roof' in module:
                    RoofDataset.Input.append(reader)
                else:
                    ModulesDataset.Input.append(reader)

            elif module.endswith('.txt'):
                csv_reader = CSVReader(registrationName=registration_name, FileName=module_path)
                points_converter = TableToPoints(
                    registrationName=f"{roof_dir}/TableToPoints",
                    Input=csv_reader,
                    XColumn=' module_x',
                    YColumn=' module_y',
                    ZColumn=' module_z',
                    KeepAllDataArrays=1
                )
                TableToPointsDataset.Input.append(points_converter)

# Set buffer view
BufferDatasetsDisplay = Show(BufferDatasets, renderView1, 'GeometryRepresentation')
BufferDatasetsDisplay.Representation = 'Wireframe'
BufferDatasetsDisplay.LineWidth = 5.0
BufferDatasetsDisplay.AmbientColor = [0.0, 0.6, 0.0]

# Set roof view
RoofDatasetDisplay = Show(RoofDataset, renderView1, 'GeometryRepresentation')
RoofDatasetDisplay.Representation = 'Wireframe'
RoofDatasetDisplay.LineWidth = 5.0
RoofDatasetDisplay.AmbientColor = [0.0, 0.0, 0.0]

# Set modules view
ModulesDatasetDisplay = Show(ModulesDataset, renderView1, 'GeometryRepresentation')
ModulesDatasetDisplay.Representation = 'Wireframe'
ModulesDatasetDisplay.LineWidth = 2.0
ModulesDatasetDisplay.AmbientColor = [0.5, 0.5, 0.5]

# Set energy colormap
energy_LUT = GetColorTransferFunction('energy')
energy_LUT.TransferFunction2D = GetTransferFunction2D('energy')
energy_LUT.RGBPoints = [
    212.586, 0.231373, 0.298039, 0.752941,
    228.40162731933594, 0.865003, 0.865003, 0.865003,
    244.21725463867188, 0.705882, 0.0156863, 0.14902
]
energy_LUT.ScalarRangeInitialized = 1.0

# Set energy view
TableToPointsDatasetDisplay = Show(TableToPointsDataset, renderView1, 'GeometryRepresentation')
TableToPointsDatasetDisplay.Representation = 'Points'
TableToPointsDatasetDisplay.ColorArrayName = ['POINTS', ' energy']
TableToPointsDatasetDisplay.LookupTable = energy_LUT
TableToPointsDatasetDisplay.PointSize = 20.0
TableToPointsDatasetDisplay.RenderPointsAsSpheres = 0

energy_LUT.RescaleTransferFunctionToDataRange(False)

# Set energy legend
energy_LUTColorBar = GetScalarBar(energy_LUT, renderView1)
energy_LUTColorBar.WindowLocation = 'Any Location'
energy_LUTColorBar.Title = 'energy [kW]'
energy_LUTColorBar.ComponentTitle = ''
energy_LUTColorBar.TitleColor = [0.0, 0.0, 0.0]
energy_LUTColorBar.TitleFontSize = 20
energy_LUTColorBar.LabelColor = [0.0, 0.0, 0.0]
energy_LUTColorBar.LabelFontSize = 20
energy_LUTColorBar.ScalarBarLength = 0.33
energy_LUTColorBar.Visibility = 1

# Final rendering
renderView1.ResetCamera()
renderView1.Update()
