%% Works with CCIV_SingleComp.m to perform group analysis and graphing using the single computation data
% Danny Lasky, 8/23

tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
inputDir = "P:\AndersonLabCultures\output 05-11-23";
outputDir = "P:\AndersonLabCultures\figures 06-13-23";
sheetName = "Acceptable Cells (No RS > 20)";
cellType = "All";
 
if cellType == "All"
    fullExcel = readtable(tablePath, 'Sheet', sheetName);
elseif cellType == "Healthy"
    fullExcel = readtable(tablePath, 'Sheet', sheetName);
    fullExcel(ismember(fullExcel.HealthyCell, 'no'), :) = [];
end

protocol    = fullExcel.Protocol;
genotype    = fullExcel.Genotype;
seeding     = fullExcel.Seeding;
drugs       = fullExcel.Drugs;
adiporon    = fullExcel.AdipoRon;
sweeps      = fullExcel.Sweeps;
DIC         = fullExcel.DIC;

cd(inputDir)

%% Create filters for all Excel rows for protocol and genotype
F.VC = contains(protocol,'VC-IV');
F.VR = strcmp(protocol,'CA3-CCIV');
F.Si = contains(protocol,'CA3-CCIV(-60)');

F.Amy_WT = contains(genotype,"Amy WT");
F.Amy_TR = contains(genotype,"Amy TR");
F.Tau_WT = contains(genotype,"Tau WT");
F.Tau_TR = contains(genotype,"Tau TR");

F.NoAmySeed = contains(seeding,"NA");
F.PBS = contains(seeding,"PBS");
F.PFF = contains(seeding,"PFF");

F.AllDrugs = contains(drugs,"25 μM D-APV, 10 μM DNQX, 10 μM bicuculline methiodide");

F.AdipoRon = contains(adiporon,"10 microM");
F.NoAdipoRon = contains(adiporon,"No");
F.DMSO = contains(adiporon,"DMSO");

F.FiveSweeps = sweeps == 5;

%% Find Excel rows for all groups divided by CC-IV and genotype (All Drugs, Five Sweeps, Non-AdipoRon, no amy seeding)
VC.Amy_WT.Rows = find(F.VC + F.Amy_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
VC.Amy_TR.Rows = find(F.VC + F.Amy_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
VC.Tau_WT.Rows = find(F.VC + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);
VC.Tau_TR.Rows = find(F.VC + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);

VR.Amy_WT.Rows = find(F.VR + F.Amy_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
VR.Amy_TR.Rows = find(F.VR + F.Amy_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
VR.Tau_WT.Rows = find(F.VR + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);
VR.Tau_TR.Rows = find(F.VR + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);

Si.Amy_WT.Rows = find(F.Si + F.Amy_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
Si.Amy_TR.Rows = find(F.Si + F.Amy_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon + F.NoAmySeed == 6);
Si.Tau_WT.Rows = find(F.Si + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);
Si.Tau_TR.Rows = find(F.Si + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 5);

VC.Tau_WT_PBS.Rows = find(F.VC + F.Tau_WT + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VC.Tau_WT_PFF.Rows = find(F.VC + F.Tau_WT + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VC.Tau_TR_PBS.Rows = find(F.VC + F.Tau_TR + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VC.Tau_TR_PFF.Rows = find(F.VC + F.Tau_TR + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);

VR.Tau_WT_PBS.Rows = find(F.VR + F.Tau_WT + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VR.Tau_WT_PFF.Rows = find(F.VR + F.Tau_WT + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VR.Tau_TR_PBS.Rows = find(F.VR + F.Tau_TR + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
VR.Tau_TR_PFF.Rows = find(F.VR + F.Tau_TR + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);

Si.Tau_WT_PBS.Rows = find(F.Si + F.Tau_WT + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
Si.Tau_WT_PFF.Rows = find(F.Si + F.Tau_WT + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
Si.Tau_TR_PBS.Rows = find(F.Si + F.Tau_TR + F.PBS + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);
Si.Tau_TR_PFF.Rows = find(F.Si + F.Tau_TR + F.PFF + F.AllDrugs + F.FiveSweeps + F.NoAdipoRon == 6);

%% Find Excel rows for all groups divided by CC-IV and genotype (All Drugs, Five Sweeps,  WITH AdipoRon, no amy seeding)
VC.Tau_WT_A.Rows = find(F.VC + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
VC.Tau_WT_D.Rows = find(F.VC + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);
VC.Tau_TR_A.Rows = find(F.VC + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
VC.Tau_TR_D.Rows = find(F.VC + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);

VR.Tau_WT_A.Rows = find(F.VR + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
VR.Tau_WT_D.Rows = find(F.VR + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);
VR.Tau_TR_A.Rows = find(F.VR + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
VR.Tau_TR_D.Rows = find(F.VR + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);

Si.Tau_WT_A.Rows = find(F.Si + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
Si.Tau_WT_D.Rows = find(F.Si + F.Tau_WT + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);
Si.Tau_TR_A.Rows = find(F.Si + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.AdipoRon == 5);
Si.Tau_TR_D.Rows = find(F.Si + F.Tau_TR + F.AllDrugs + F.FiveSweeps + F.DMSO == 5);

%% Get counts of all recording types
VC.Amy_WT.Count     = length(VC.Amy_WT.Rows);
VC.Amy_TR.Count     = length(VC.Amy_TR.Rows);
VC.Tau_WT.Count     = length(VC.Tau_WT.Rows);
VC.Tau_TR.Count     = length(VC.Tau_TR.Rows);
VC.Tau_WT_A.Count   = length(VC.Tau_WT_A.Rows);
VC.Tau_WT_D.Count   = length(VC.Tau_WT_D.Rows);
VC.Tau_TR_A.Count   = length(VC.Tau_TR_A.Rows);
VC.Tau_TR_D.Count   = length(VC.Tau_TR_D.Rows);

VR.Amy_WT.Count     = length(VR.Amy_WT.Rows);
VR.Amy_TR.Count     = length(VR.Amy_TR.Rows);
VR.Tau_WT.Count     = length(VR.Tau_WT.Rows);
VR.Tau_TR.Count     = length(VR.Tau_TR.Rows);
VR.Tau_WT_A.Count   = length(VR.Tau_WT_A.Rows);
VR.Tau_WT_D.Count   = length(VR.Tau_WT_D.Rows);
VR.Tau_TR_A.Count   = length(VR.Tau_TR_A.Rows);
VR.Tau_TR_D.Count   = length(VR.Tau_TR_D.Rows);

Si.Amy_WT.Count     = length(Si.Amy_WT.Rows);
Si.Amy_TR.Count     = length(Si.Amy_TR.Rows);
Si.Tau_WT.Count     = length(Si.Tau_WT.Rows);
Si.Tau_TR.Count     = length(Si.Tau_TR.Rows);
Si.Tau_WT_A.Count   = length(Si.Tau_WT_A.Rows);
Si.Tau_WT_D.Count   = length(Si.Tau_WT_D.Rows);
Si.Tau_TR_A.Count   = length(Si.Tau_TR_A.Rows);
Si.Tau_TR_D.Count   = length(Si.Tau_TR_D.Rows);

VC.Tau_WT_PBS.Count = length(VC.Tau_WT_PBS.Rows);
VC.Tau_WT_PFF.Count = length(VC.Tau_WT_PFF.Rows);
VC.Tau_TR_PBS.Count = length(VC.Tau_TR_PBS.Rows);
VC.Tau_TR_PFF.Count = length(VC.Tau_TR_PFF.Rows);

VR.Tau_WT_PBS.Count = length(VR.Tau_WT_PBS.Rows);
VR.Tau_WT_PFF.Count = length(VR.Tau_WT_PFF.Rows);
VR.Tau_TR_PBS.Count = length(VR.Tau_TR_PBS.Rows);
VR.Tau_TR_PFF.Count = length(VR.Tau_TR_PFF.Rows);

Si.Tau_WT_PBS.Count = length(Si.Tau_WT_PBS.Rows);
Si.Tau_WT_PFF.Count = length(Si.Tau_WT_PFF.Rows);
Si.Tau_TR_PBS.Count = length(Si.Tau_TR_PBS.Rows);
Si.Tau_TR_PFF.Count = length(Si.Tau_TR_PFF.Rows);

%% Find group means and sd for days in culture
VC.Amy_WT.DIC = DIC(VC.Amy_WT.Rows);
VC.Amy_TR.DIC = DIC(VC.Amy_TR.Rows);
VC.Tau_WT.DIC = DIC(VC.Tau_WT.Rows);
VC.Tau_WT_A.DIC = DIC(VC.Tau_WT_A.Rows);
VC.Tau_WT_D.DIC = DIC(VC.Tau_WT_D.Rows);
VC.Tau_TR.DIC = DIC(VC.Tau_TR.Rows);
VC.Tau_TR_A.DIC = DIC(VC.Tau_TR_A.Rows);
VC.Tau_TR_D.DIC = DIC(VC.Tau_TR_D.Rows);

VC.Amy_WT.DIC_Mn = mean(VC.Amy_WT.DIC);
VC.Amy_TR.DIC_Mn = mean(VC.Amy_TR.DIC);
VC.Tau_WT.DIC_Mn = mean(VC.Tau_WT.DIC);
VC.Tau_WT_A.DIC_Mn = mean(VC.Tau_WT_A.DIC);
VC.Tau_WT_D.DIC_Mn = mean(VC.Tau_WT_D.DIC);
VC.Tau_TR.DIC_Mn = mean(VC.Tau_TR.DIC);
VC.Tau_TR_A.DIC_Mn = mean(VC.Tau_TR_A.DIC);
VC.Tau_TR_D.DIC_Mn = mean(VC.Tau_TR_D.DIC);

VC.Amy_WT.DIC_Sd = std(VC.Amy_WT.DIC);
VC.Amy_TR.DIC_Sd = std(VC.Amy_TR.DIC);
VC.Tau_WT.DIC_Sd = std(VC.Tau_WT.DIC);
VC.Tau_WT_A.DIC_Sd = std(VC.Tau_WT_A.DIC);
VC.Tau_WT_D.DIC_Sd = std(VC.Tau_WT_D.DIC);
VC.Tau_TR.DIC_Sd = std(VC.Tau_TR.DIC);
VC.Tau_TR_A.DIC_Sd = std(VC.Tau_TR_A.DIC);
VC.Tau_TR_D.DIC_Sd = std(VC.Tau_TR_D.DIC);

%% Get values from Excel sheet for hand-written pre and post VR, CM, RS, and RM and compute means and stdevs
[VC, VR, Si] = CCIV_ReadParams(fullExcel, VC, VR, Si);
cd(outputDir)

%% Create box plots for resting potential, membrane capacitance, membrane resistance, and series resistance for each time point
yLimitType = "Figure";    % Options: "Off", "Figure"
graphType = "None";     % "All", "Amy", "Tau", "PFF", "AdipoRon", "DMSO", "None"
CCIV_GraphParams(VC, VR, Si, yLimitType, graphType, cellType)

%% Create box plots for resting potential, membrane capacitance, membrane resistance, and series resistance averaged across time points
yLimitType = "Tile";      % Options: "Off", "Tile"
graphType = "None";         % "All", "Amy", "AdipoRon", "DMSO", "None"
Box = CCIV_CombineTimes(VC, VR, Si, yLimitType, graphType, cellType);

%% Get values from Matlab output for computed spike parameters
cd(inputDir)
[VR, Si] = CCIV_ReadSpikes(fullExcel, VR, Si);
cd(outputDir)

%% Create box plots for rheobase parameters, spiking properties, and voltage sag curve fit variables
graphType = "AdipoRon Special";    % "All", "Amy Rheo", "AdipoRon Rheo", "Amy Special", "AdipoRon Special", "None"
Box = CCIV_GraphSpikes(VR, Si, graphType, cellType);

%% Create plots for spike count, interval ratio, latency, peak, and width across all current steps
nSteps = 30;
ISteps = -100:20:480;
graphType = "None";              % Options: "All", "Count", "Interval", "Latency", "Peak", "Width, "None"
[VR, Si] = CCIV_GraphSteps(VR, Si, nSteps, ISteps, cellType, graphType);

%% Single spike plots
graphType = "None";              % Options: "All", "Tau", "Amy", "Inset", "None"
[VR, Si] = CCIV_OneSpike(VR, Si, nSteps, ISteps, cellType, graphType);

%% Final Figures
graphType = "5";                % "All", "1", "2", "3", "4", "5", "6", "None"
[VC, VR, Si] = FinalFigures(VC, VR, Si, nSteps, ISteps, graphType);
