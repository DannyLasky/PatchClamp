function [fullExcel, MatlabRows, ExcelRows, protocolFile, dataFile, dataType, researcher, outputFile] = ReadExcel(ExcelRows, tablePath, protocol)
%% Short function that works with CCIV_SingleComp.m to read in data from the NameFile Excel sheet
% Danny Lasky, 8/23

%% Read in data
MatlabRows = ExcelRows - 1;             % Offset by 1 row since 1st row becomes the table header in Matlab
fullExcel = readtable(tablePath);
ExcelArr = fullExcel(MatlabRows,:);

%% Remove rows that do not use the current clamp protocol
protocolRows    = contains(ExcelArr.ProtocolPath, protocol);
ExcelArr        = ExcelArr(protocolRows, :);
MatlabRows      = MatlabRows(protocolRows);
ExcelRows       = MatlabRows + 1;

%% Create empty matrices
protocolFile = cell(1, height(ExcelArr));
dataFile     = cell(1, height(ExcelArr));
dataType     = cell(1, height(ExcelArr));
researcher   = cell(1, height(ExcelArr));
outputFile   = cell(1, height(ExcelArr));

%% Fill matrices
for n = 1:height(ExcelArr)
    protocolFile(n) = ExcelArr{n,'ProtocolPath'};        
    dataFile(n)     = ExcelArr{n,'FilePath'};
    dataType(n)     = ExcelArr{n,'Genotype'};
    researcher(n)   = ExcelArr{n,'Researcher'};
    outputFile(n)   = ExcelArr{n,'FileNum'};
end
    