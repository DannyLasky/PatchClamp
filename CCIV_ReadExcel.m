function [fullExcel, MatlabRows, protocolFile, dataFile, dataType, researcher, outputFile] = CCIV_ReadExcel(ExcelRows, tablePath)
%% Short function that works with CCIV_SingleComp.m to read in data from the NameFile Excel sheet
% Last updated 12-7-22 by Danny Lasky
MatlabRows = ExcelRows - 1;             % Offset by 1 row since 1st row becomes the table header in Matlab
fullExcel = readtable(tablePath);
ExcelArr = fullExcel(MatlabRows,:);

protocolFile = cell(1,length(ExcelRows));
dataFile     = cell(1,length(ExcelRows));
dataType     = cell(1,length(ExcelRows));
researcher   = cell(1,length(ExcelRows));
outputFile   = cell(1,length(ExcelRows));

for n = 1:length(ExcelRows)
    protocolFile(n) = ExcelArr{n,'ProtocolPath'};        
    dataFile(n)     = ExcelArr{n,'FilePath'};
    dataType(n)     = ExcelArr{n,'Genotype'};
    researcher(n)   = ExcelArr{n,'Researcher'};
    outputFile(n)   = ExcelArr{n,'FileNum'};
end