# PatchClamp
- Patch clamp scripts for the 2023 AdipoRon paper with the Jones and Anderson Labs
- Code will grouped by the master scripts (headers) that run specific functions (bullet points) within them
- Small functions that are used throughout the scripts and unchanged functions written by others will be at the end
- All this code can be found in the Jones Lab drive under Jones_Maganti_Shared > jonesLab_code > Projects > PatchClamp

### CCIV_SingleAnalysis: Analysis of single current clamp files
- CCIV_SpikeDetect: Performs spike detection on current clamp files
- CCIV_SingleGraph: Graphs many spike parameters vs. the amount of current injected: spike count, interval, latency, height, and width

### CCIV_GroupAnalysis: Runs all other functions for compiling, analyzing, and graphing current clamp data across multiple files. Uses the single recording Matlab outputs of CCIV_SingleAnalysis and Excel sheet data
- CCIV_ReadParams: Reads all of the single file data into matrices
- CCIV_GraphParams: Graphs passive parameters (resistance, capacitance, and resting potential) at all time points
- CCIV_CombineTimes: Graphs passive parameters (resistance, capacitance, and resting potential) averaged across time points
- CCIV_ReadSpikes: Get values from Matlab output for computed spike parameters
- CCIV_GraphSpikes: Create box plots for rheobase parameters, spiking properties, and voltage sag curve fit variables
- CCIV_GraphSteps: Create plots for spike count, interval ratio, latency, peak, and width across all current steps
- CCIV_OneSpike: Calculates the percentage of cells that fire no spikes, exactly one spike, or one or more spikes at each current step
- FinalFigures: Compiles code from other graphing scripts and produces final figures that were worked up for the 2023 paper

### VCIV_SingleAnalysis: Performs IV curve calculations and finds maximum positive and negative current for voltage clamp files

### VCIV_GroupAnalysis: Performs group calculations for IV curves and maximum positive and negative currents. Uses the single recording Excel outputs of VCIV_SingleAnalysis

## Small functions
- ReadExcel: Reads in Excel data for various scripts
- MyBoxPlot: Custom box plot graphing used in many scripts

## Pre-written functions
- read_axograph: Reads in AxoGraph files (by Matt Jones)
- fitexptau1: Performs curve fitting for a single exponential decay (written previously by someone in the Jones Lab)
- fitexptau2: Performs curve fitting for a double exponential decay (written previously by someone in the Jones Lab)
- scalebars: Produces graphical scale bars (by Matt Jones)
- padcat: Pads a matrix being made from separate vectors with NaN values (https://www.mathworks.com/matlabcentral/fileexchange/22909-padcat)
- shadedErrorBar: Creates a nice shaded error bar for line plots (https://www.mathworks.com/matlabcentral/fileexchange/26311-raacampbell-shadederrorbar)
