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

# Load the mesh file
mesh_file = os.path.join(os.path.dirname(__file__), '../../data/city_summer.obj')
if not os.path.exists(mesh_file):
    raise FileNotFoundError(f"Mesh file not found: {mesh_file}")
mesh = OpenDataFile(mesh_file)
mesh_display = Show(mesh, renderView1, 'GeometryRepresentation')
#mesh_display.Name = 'City Mesh'
mesh_display.Representation = 'Surface'

# Load the modules file
modules_file = os.path.join(os.path.dirname(__file__), 'modules_summer.csv')
if not os.path.exists(modules_file):
    raise FileNotFoundError(f"Modules file not found: {modules_file}")
registration_name = f"PV Modules"
csv_reader = CSVReader(registrationName=registration_name, FileName=modules_file)
PVmodules = TableToPoints(
    Input=csv_reader,
    XColumn=' module_x',
    YColumn=' module_y',
    ZColumn=' module_z',
    KeepAllDataArrays=1
)

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
PVmodulesDisplay = Show(PVmodules, renderView1, 'GeometryRepresentation')
PVmodulesDisplay.Representation = 'Points'
PVmodulesDisplay.ColorArrayName = ['POINTS', ' energy']
PVmodulesDisplay.LookupTable = energy_LUT
PVmodulesDisplay.PointSize = 10.0
PVmodulesDisplay.RenderPointsAsSpheres = 0

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
