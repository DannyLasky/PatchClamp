%% Set hard-coded variables. runType can only be 'Excel'
% Danny Lasky, 8/23

runType = "Excel";
onMac = 0;
setRestingPot = -60;
displaySweeps = [1, 3, 5, 7, 9, 11];
versionNum = 'v4';

if onMac == 1
    mainDir = '/Volumes/mathewjones/AndersonLabCultures';
    outputDir = '/Volumes/mathewjones/AndersonLabCultures/output 05-11-23';
else
    mainDir = 'P:\AndersonLabCultures';
    outputDir = 'P:\AndersonLabCultures\temp';
end

tableName = 'Namefile 04-27-23.xlsx';
protocol = '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx';

%% Read in Excel data
if runType == "Excel"
    ExcelRows = 542:778;
    tablePath = fullfile(mainDir, tableName);
    [fullExcel, MatlabRows, ExcelRows, protocolFile, dataFile, dataType, researcher, outputFile] = ReadExcel(ExcelRows, tablePath, protocol);
end

%% Begin computational loop
for fileNum = 1:length(dataFile)
    disp(['Analyzing file #' num2str(fileNum) ' of ' num2str(length(dataFile)) ])

%% Adjust file paths for new drive and Windows vs Mac
    if onMac == 1
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/Users/Shared/','/Volumes/mathewjones/');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/Users/Shared/','/Volumes/mathewjones/');
    else
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/Users/Shared/','P:\');
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/','\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/Users/Shared/','P:\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/','\');
    end

%% Read protocol & extract useful info
    protocolFull  = read_axograph(protocolFile{fileNum});
    PRT.time      = protocolFull.columnData{1} * 1e3;                   % Convert from s to ms
    PRT.data      = cat(2, protocolFull.columnData{2:end}) * 1e3;       % Convert from V to mV
    PRT.IStepVals = PRT.data(round(0.5.*size(PRT.data, 1)),:);          % In mV
    nSteps        = length(PRT.IStepVals);

    %% Read data file & extract useful info
    currentFile = dataFile{fileNum};
    dataFileFull = read_axograph(currentFile);
    DATA.time = dataFileFull.columnData{1}* 1e3;                        % Convert from s to ms
    DATA.sweepInterval = mean(diff(DATA.time));                         % In ms
    DATA.data = cat(2, dataFileFull.columnData{2:end}) * 1e12;          % Convert from A to pA

    graphName = strcat(researcher{fileNum}, " ", outputFile{fileNum});
    graphGeno = dataType{fileNum};
    cd(outputDir)

    %% Perform leak subtraction
    [leakStep, leakStepIdx] = max(PRT.IStepVals(PRT.IStepVals < 0));    % Leak step is the smallest negative step
    leakData = DATA.data(:, leakStepIdx);
    leakMultiplier = PRT.IStepVals/PRT.IStepVals(leakStepIdx);
    leakSubtractionData = leakData .* leakMultiplier;
    leakSubtractedData = DATA.data - leakSubtractionData;

    %% Zero each step
    zeroingData = leakSubtractedData(1:450, :);     % Hard coded numbers to protocol
    zeroVals    = mean(zeroingData);
    zeroedData  = leakSubtractedData - zeroVals;

    %% Calculate data for IV curve
    lastThird = zeroedData(2500:3499, :);           % Hard coded numbers to protocol
    lastThirdAve = mean(lastThird);

    %% Calculate minimum current (maximum inward) in first 10 ms following current application
    % Inward current is denoted as negative
    firstTen = zeroedData(504:703, :);              % Hard coded numbers to protocol
    firstTenMin = min(firstTen);

    %% Calculate maximum current (maximum outward) in first 10 ms following current application
    % Outward current is denoted as positive
    firstTenMax = max(firstTen);                    % Hard coded numbers to protocol

    %% Calculate percentiles for graphing
    lowerBound = min(prctile(zeroedData, 3));
    upperBound = max(prctile(zeroedData, 97));

    %% Calculate actual resting potentials for plotting. The ones used above done correctly being in relation to -60 mV
    plotIStepVals = PRT.IStepVals + setRestingPot;

    %% Plot
    figure('units', 'inch', 'pos', [0.5 1.5 15 8])
    t = tiledlayout(2,4);
    title(t, strcat(graphName, " ", graphGeno, " Voltage Clamp"), 'FontSize', 24)

    %% Displays five selected sweeps of current injection (pA) vs time (s)
    t1 = nexttile;
        plot(DATA.time, PRT.data(:, displaySweeps) + setRestingPot, 'LineWidth', 1.5)
        title('Six Holding Potentials', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([0 200])
        ylim([-110 10])
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlabel('Time (ms)', 'FontSize', 16);  
        ylabel('Holding Potential (mV)', 'FontSize', 16);
    t2 = nexttile;
        plot(DATA.time, zeroedData(:, displaySweeps), 'LineWidth', 1.5)
        title('Six Current Responses', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([0 200])
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlabel('Time (ms)', 'FontSize', 16); 
        ylabel('Current (pA)', 'FontSize', 16);
    t3 = nexttile;
        plot(DATA.time, zeroedData(:, displaySweeps), 'LineWidth', 1.5)
        title('Zoomed Intial Responses', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([25 36])
        ylim tight
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlabel('Time (ms)', 'FontSize', 16); 
        ylabel('Current (pA)', 'FontSize', 16);
    t4 = nexttile;
        plot(DATA.time, zeroedData(:, displaySweeps), 'LineWidth', 1.5)
        title('Zoomed Intermediate Responses', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([36 175])
        ylim([lowerBound upperBound])
        xticks([27 101 175])
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlabel('Time (ms)', 'FontSize', 16); 
        ylabel('Current (pA)', 'FontSize', 16); 
    t5 = nexttile;
        plot(plotIStepVals, lastThirdAve, 'k-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'k')
        hold on
        yline(0)
        xline(0)
        title('IV Curve', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([-110 10])
        t5.XAxis.FontSize = 14;
        t5.YAxis.FontSize = 14;
        xlabel('Voltage (mV)', 'FontSize', 16); 
        ylabel('Current (pA)', 'FontSize', 16);
    t6 = nexttile;
        plot(plotIStepVals, firstTenMin, 'k-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'k')
        hold on
        yline(0)
        xline(0)
        title('Max Inward Current', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([-110 10])
        t6.XAxis.FontSize = 14;
        t6.YAxis.FontSize = 14;
        xlabel('Voltage (mV)', 'FontSize', 16); 
        ylabel('Max Inward Current (pA)', 'FontSize', 16);
    t7 = nexttile;
        plot(plotIStepVals, firstTenMax, 'k-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'k')
        hold on
        yline(0)
        xline(0)
        title('Max Outward Current', 'FontSize', 16, 'FontWeight', 'Normal')
        xlim([-110 10])
        t7.XAxis.FontSize = 14;
        t7.YAxis.FontSize = 14;
        xlabel('Voltage (mV)', 'FontSize', 16); 
        ylabel('Max Outward Current (pA)', 'FontSize', 16);
    saveas(gcf, strcat(graphName," VC.png"))

    %% Save output
    fullExcel{MatlabRows(fileNum), 'VersionNum'} = {versionNum + ", " + string(datetime('today', 'Format', 'MM/dd/uuuu'))};
    fullExcel{MatlabRows(fileNum), 'IVCurve1'} = lastThirdAve(1);
    fullExcel{MatlabRows(fileNum), 'IVCurve2'} = lastThirdAve(2);
    fullExcel{MatlabRows(fileNum), 'IVCurve3'} = lastThirdAve(3);
    fullExcel{MatlabRows(fileNum), 'IVCurve4'} = lastThirdAve(4);
    fullExcel{MatlabRows(fileNum), 'IVCurve5'} = lastThirdAve(5);
    fullExcel{MatlabRows(fileNum), 'IVCurve6'} = lastThirdAve(6);
    fullExcel{MatlabRows(fileNum), 'IVCurve7'} = lastThirdAve(7);
    fullExcel{MatlabRows(fileNum), 'IVCurve8'} = lastThirdAve(8);
    fullExcel{MatlabRows(fileNum), 'IVCurve9'} = lastThirdAve(9);
    fullExcel{MatlabRows(fileNum), 'IVCurve10'} = lastThirdAve(10);
    fullExcel{MatlabRows(fileNum), 'IVCurve11'} = lastThirdAve(11);

    fullExcel{MatlabRows(fileNum), 'maxInCurrent1'} = firstTenMin(1);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent2'} = firstTenMin(2);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent3'} = firstTenMin(3);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent4'} = firstTenMin(4);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent5'} = firstTenMin(5);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent6'} = firstTenMin(6);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent7'} = firstTenMin(7);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent8'} = firstTenMin(8);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent9'} = firstTenMin(9);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent10'} = firstTenMin(10);
    fullExcel{MatlabRows(fileNum), 'maxInCurrent11'} = firstTenMin(11);

    fullExcel{MatlabRows(fileNum), 'maxOutCurrent1'} = firstTenMax(1);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent2'} = firstTenMax(2);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent3'} = firstTenMax(3);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent4'} = firstTenMax(4);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent5'} = firstTenMax(5);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent6'} = firstTenMax(6);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent7'} = firstTenMax(7);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent8'} = firstTenMax(8);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent9'} = firstTenMax(9);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent10'} = firstTenMax(10);
    fullExcel{MatlabRows(fileNum), 'maxOutCurrent11'} = firstTenMax(11);
    
    cd(mainDir)
    writetable(fullExcel, tableName)
    close all
end
