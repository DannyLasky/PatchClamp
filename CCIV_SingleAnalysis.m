%% Large revision/overhaul to "Analyze_CCIV_MJ_EW2_OR1.m"
% Can be run manually be selecting file path or automatically through assigning Excel rows from the namefile sheet
% Throughout this script, tims is in ms, voltage is in mV, current is in pA, resistance is in MOhms, and capacitance is in pF
% Danny Lasky, 8/23

%% Set hard-coded variables. runType can be 'Manual' or 'Excel'
runType = "Excel";                  % Can be either "Manual" or "Excel"
versionNum = 'v8';                  % Version number setting for keeping track of you changes
onMac = 0;                          % Toggle between 0 (not on Mac) and 1 (on Mac)
displayFrames = [];                 % For viewing spike detection process             
displaySweeps = [1, 5, 10, 18, 28]; % For viewing spikes in final output
setI.Current = 240;                 % in pA

if onMac == 1
    mainDir = '/Volumes/mathewjones/AndersonLabCultures';
    outputDir = '/Volumes/mathewjones/AndersonLabCultures/output 05-11-23';
else
    mainDir = 'P:\AndersonLabCultures';
    outputDir = 'P:\AndersonLabCultures\output 05-11-23';
end

tableName = 'Namefile 04-27-23.xlsx';
protocol = '/Users/Shared/AndersonLabCultures/protocols & configs/CA3-CCIV.prt.axgx';

%% Select files to be run manually
if runType == "Manual"
    % File paths for the CCIV protocol that generated the data, the data itself, and what type of data each file is
    protocolFile{1} = '/Users/Shared/AndersonLabCultures/protocols & configs/CA3-CCIV.prt.axgx';
    dataFile{1}     = '/Users/Shared/AndersonLabCultures/lasky/11-07-22/11-07-22 007.axgd';
    dataType{1}     = 'Amy WT';
    
    protocolFile{2} = '/Users/Shared/AndersonLabCultures/protocols & configs/CA3-CCIV.prt.axgx';
    dataFile{2}     = '/Users/Shared/AndersonLabCultures/lasky/11-07-22/11-07-22 008.axgd';
    dataType{2}     = 'Amy WT';

%% Select files to be run automatically through Excel "NameFile" Sheet
elseif runType == "Excel"
    ExcelRows = 190:196;                            % Rows in Excel sheet to be analyzed
    tablePath = fullfile(mainDir, tableName);
    [fullExcel, MatlabRows, ExcelRows, protocolFile, dataFile, dataType, researcher, outputFile] = ReadExcel(ExcelRows, tablePath, protocol);
else
    error('runType must be set to "Manual" or "Excel" to locate data to run')
end

%% ––––––––––––––––––––– DO NOT CHANGE ANYTHING PAST HERE. THIS IS THE END OF THE INPUT CUSTOMIZATION –––––––––––––––––––––

%% Begin main computational loop
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
    PRT.data      = cat(2, protocolFull.columnData{2:end}) * 1e12;      % Convert from A to pA
    PRT.IStepVals = PRT.data(round(0.5.*size(PRT.data, 1)),:);          % In pA
    nSteps        = length(PRT.IStepVals);

%% Read data file & extract useful info
    currentFile = dataFile{fileNum};
    dataFileFull = read_axograph(currentFile);
    DATA.time = dataFileFull.columnData{1} * 1e3;                   % Convert from s to ms
    DATA.sweepInterval = mean(diff(DATA.time));                     % In ms
    DATA.data = cat(2, dataFileFull.columnData{2:end}) * 1e3;       % Convert from V to mV
    nSweeps = width(DATA.data);                        
    nReps = floor(nSweeps./nSteps);

    graphName = strcat(researcher{fileNum}, " ", outputFile{fileNum});
    graphGeno = dataType{fileNum};
    cd(outputDir)

%% Find current application window
    activeCurr      = sign(abs(PRT.data));
    currAppFilt     = sum(activeCurr,1) ~= 0;
    currAppSteps    = find(currAppFilt == 1);
    stimWindow      = find(PRT.data(:,currAppSteps(1)));
    stimTime        = DATA.time(stimWindow);

    sweepTime       = DATA.time;
    sweepPts        = length(sweepTime);
    sweepWindow     = 1:sweepPts;

%% Perform spike counting
    [upCrossIdx, upCrossTimes, downCrossIdx, downCrossTimes, spontanIdx, excludeIdx, reboundIdx, rheo]  = CCIV_SpikeDetect(stimWindow, sweepTime, ...
        sweepPts, sweepWindow, DATA, PRT, nSweeps, nSteps, nReps, displayFrames, currentFile, stimTime, graphName, graphGeno, displaySweeps);

%% Prepare variables
    step.UpCrossIdx         = cell(nReps, 1);
    step.UpCrossTimes       = cell(nReps, 1);
    step.DownDownIdx        = cell(nReps, 1);
    step.DownCrossTimes     = cell(nReps, 1);
    step.nSpikes            = cell(nSteps, 1);

    step.SpikeIntRatio      = cell(nSteps, 1);
    step.SpikeLatency       = cell(nSteps, 1);
    step.SpikeIntRatio(:)   = {NaN(nReps, 1)};
    step.SpikeLatency(:)    = {NaN(nReps, 1)};

    step.nSpikesMn          = NaN(nSteps, 1);
    step.nSpikesSd          = NaN(nSteps, 1);
    step.SpikeIntRatioMn    = NaN(nSteps, 1);
    step.SpikeIntRatioSd    = NaN(nSteps, 1);
    step.SpikeLatencyMn     = NaN(nSteps, 1);
    step.SpikeLatencySd     = NaN(nSteps, 1);

    step.SpikePeak          = cell(nSteps, 1);
    step.SpikePeak(:)       = {NaN(nReps, 1)};
    step.SpikePeakMn        = NaN(nSteps, 1);
    step.SpikePeakSd        = NaN(nSteps, 1);

    step.SpikeWidth         = cell(nSteps, 1);
    step.SpikeWidth(:)      = {NaN(nReps, 1)};
    step.SpikeWidthMn       = NaN(nSteps, 1);
    step.SpikeWidthSd       = NaN(nSteps, 1);

%% Begin spike parameter computation loop for each currency step
    for n = 1:nSteps
        step.UpCrossIdx = upCrossIdx(n:nSteps:end);
        step.UpCrossTimes = upCrossTimes(n:nSteps:end);
        step.DownCrossIdx = downCrossIdx(n:nSteps:end);
        step.DownCrossTimes = downCrossTimes(n:nSteps:end);
        for m = 1:nReps

            %% Compute spike count
            step.nSpikes{n}(m) = length(step.UpCrossTimes{m});

            %% Compute spike interval ratio
            if step.nSpikes{n}(m) >= 3
                step.SpikeIntRatio{n}(m) = (step.UpCrossTimes{m}(3) - step.UpCrossTimes{m}(2)) / (step.UpCrossTimes{m}(2) - step.UpCrossTimes{m}(1));
            end

            %% Compute first spike timing
            if step.nSpikes{n}(m) >= 1
                step.SpikeLatency{n}(m) = step.UpCrossTimes{m}(1) - stimTime(1);

                %% Compute first spike peak
                sweepNum = 30*(m - 1) + n; 
                step.SpikePeak{n}(m) = max(DATA.data(step.UpCrossIdx{m}(1):step.DownCrossIdx{m}(1), sweepNum));

                %% Compute first spike width
                step.SpikeWidth{n}(m) = step.DownCrossTimes{m}(1) - step.UpCrossTimes{m}(1);

            end
        end
        step.nSpikesMn(n)       = mean(step.nSpikes{n});
        step.nSpikesSd(n)       = std(step.nSpikes{n});
        step.SpikeIntRatioMn(n) = mean(step.SpikeIntRatio{n}, 'omitnan');
        step.SpikeIntRatioSd(n) = std(step.SpikeIntRatio{n}, 'omitnan');
        step.SpikeLatencyMn(n)  = mean(step.SpikeLatency{n}, 'omitnan');
        step.SpikeLatencySd(n)  = std(step.SpikeLatency{n}, 'omitnan');
        step.SpikePeakMn(n)     = mean(step.SpikePeak{n}, 'omitnan');
        step.SpikePeakSd(n)     = std(step.SpikePeak{n}, 'omitnan');
        step.SpikeWidthMn(n)    = mean(step.SpikeWidth{n}, 'omitnan');
        step.SpikeWidthSd(n)    = std(step.SpikeWidth{n}, 'omitnan');
    end

%% Prepare variables
    rep.UpCrossTimes        = cell(nSteps, 1);
    rep.nSpikes             = zeros(nSteps, 1);
    rep.MaxSpikes           = zeros(nReps, 1);

    halfMax.SpikeCalc       = NaN(nReps, 1);
    halfMax.StepI           = NaN(nReps, 1);
    halfMax.Step            = NaN(nReps, 1);

    halfMax.nSpikes         = NaN(nReps, 1);
    halfMax.SpikeIntRatio   = NaN(nReps, 1);
    halfMax.SpikeLatency    = NaN(nReps, 1);
    halfMax.SpikePeak       = NaN(nReps, 1);
    halfMax.SpikeWidth      = NaN(nReps, 1);

    setI.Step = find(PRT.IStepVals == setI.Current);
    setI.nSpikes            = NaN(nReps, 1);
    setI.SpikeIntRatio      = NaN(nReps, 1);
    setI.Latency            = NaN(nReps, 1);

    Vr                      = NaN(1,nReps);
    dV                      = NaN(1,nReps);
    Rm                      = NaN(1,nReps);
    Cm                      = NaN(1,nReps);

    fit1.graphWindow = 1:stimWindow(1) + stimWindow(end) - 1;
    fit1.x                  = cell(1,nReps);
    fit1.xZeroed            = cell(1,nReps);
    fit1.xGraph             = cell(1,nReps);
    fit1.y                  = cell(1,nReps);
    fit1.yGraph             = cell(1,nReps);

    fit1.ConGuess           = NaN(1,nReps);
    fit1.AmpGuess           = NaN(1,nReps);
    fit1.TauGuess           = NaN(1,nReps);

    fit1.GuessInitial{m}    = cell(1,nReps);
    fit1.GuessEst{m}        = cell(1,nReps);
    fit1.Options{m}         = cell(1,nReps);
    fit1.ParamFit{m}        = cell(1,nReps);

    fit1.Est                = cell(1,nReps);
    fit1.Amp                = NaN(1,nReps);
    fit1.Tau                = NaN(1,nReps);
    fit1.Con                = NaN(1,nReps);
    fit1.SSE                = NaN(1,nReps);

%% Save off spike parameters at current for half max spike count and at set applied current
   for m = 1:nReps
        rep.StartSweep = (m-1).*nSteps+1;
        rep.UpCrossTimes = upCrossTimes(rep.StartSweep:rep.StartSweep+nSteps-1);
        for n = 1:nSteps
            rep.nSpikes(n) = length(rep.UpCrossTimes{n});
        end

        if sum(rep.nSpikes) > 0
            [rep.MaxSpikes(m), rep.MaxSpikesStep(m)] = max(rep.nSpikes);
            ramp = 1e-12*(1:nSteps)';           % For adding a minimum value to prevent error from identical values

            halfMax.SpikeCalc(m) = rep.MaxSpikes(m)./2;
            halfMax.StepI(m) = interp1(ramp + rep.nSpikes, PRT.IStepVals, halfMax.SpikeCalc(m), 'nearest');
            halfMax.Step(m) = find(PRT.IStepVals == halfMax.StepI(m));
            
            halfMax.nSpikes(m)          = step.nSpikes{halfMax.Step(m)}(m);
            halfMax.SpikeIntRatio(m)    = step.SpikeIntRatio{halfMax.Step(m)}(m);
            halfMax.SpikeLatency(m)     = step.SpikeLatency{halfMax.Step(m)}(m);
            halfMax.SpikePeak(m)        = step.SpikePeak{halfMax.Step(m)}(m);
            halfMax.SpikeWidth(m)       = step.SpikeWidth{halfMax.Step(m)}(m);

            setI.nSpikes(m)             = step.nSpikes{setI.Step}(m);
            setI.SpikeIntRatio(m)       = step.SpikeIntRatio{setI.Step}(m);
            setI.SpikeLatency(m)        = step.SpikeLatency{setI.Step}(m);
            setI.SpikePeak(m)           = step.SpikePeak{setI.Step}(m);
            setI.SpikeWidth(m)          = step.SpikeWidth{setI.Step}(m);
        end

%% Compute steady state resistance from smallest negative step (last fifth for least activity)
        smallestNegI = max(PRT.IStepVals(PRT.IStepVals < 0));       % Find the smallest negative step 
        smallestNegStep = find(PRT.IStepVals == smallestNegI) + (m-1) * nSteps;
        
        smallestNegPRT = find(PRT.IStepVals == smallestNegI);
        activeNegStep = find(PRT.data(:,smallestNegPRT));   % Finds all timepoints in which a current is applied for the smallest negative step

        endActiveNegStepLen = length(activeNegStep)/5;
        endActiveNegStepInd = activeNegStep(end)-endActiveNegStepLen+1:activeNegStep(end); % Last fifth of active negative step

%% Compute resting membrane voltage from resting step (last fifth for matching Rm window)
        restingStep = find(PRT.IStepVals == 0) + (m-1) * nSteps;
        Vr(m) = mean(DATA.data(endActiveNegStepInd, restingStep));

%% Finish computing steady state resistance
        dV(m) = mean(DATA.data(endActiveNegStepInd, smallestNegStep)) - Vr(m);  % Calculate voltage change at steady state after stimulation (V)    
        Rm(m) = dV(m)/smallestNegI * 1e3;    % Calculate steady state resistance R = V/I, mV and pA used, multiply by 1e3 to get in MOhms

%% Compute capacitance by fitting a single exponential to the smallest negative current step
        fit1.x{m}           = stimTime;
        fit1.xZeroed{m}     = fit1.x{m} - fit1.x{m}(1);
        fit1.xGraph{m}      = sweepTime(fit1.graphWindow);

        fit1.y{m}           = DATA.data(activeNegStep, smallestNegStep);    % Mean for current applied across all smallest negative step sweeps
        fit1.yGraph{m}      = DATA.data(fit1.graphWindow, smallestNegStep);

        fit1.ConGuess(m)    = mean(fit1.y{m}(end-99:end));
        fit1.AmpGuess(m)    = mean(maxk(fit1.y{m}, 50)) - mean(mink(fit1.y{m}, 50));
        
        fit1.AtCon = fit1.xZeroed{m}(fit1.ConGuess(m) > fit1.y{m});
        fit1.TauGuess(m) = fit1.AtCon(1) / 2;

        fit1.GuessInitial{m}    = [fit1.AmpGuess(m), fit1.TauGuess(m), fit1.ConGuess(m)];
        fit1.GuessEst{m}        = fit1.AmpGuess(m) .* exp(-fit1.xZeroed{m} ./ fit1.TauGuess(m)) + fit1.ConGuess(m);
        fit1.Options{m}         = optimset('TolFun', 1e-15, 'MaxIter', 10000);
        fit1.ParamFit{m}        = fminsearch('fitexptau1', fit1.GuessInitial{m}, fit1.Options{m}, fit1.xZeroed{m}, fit1.y{m});
    
        fit1.Amp(m) = fit1.ParamFit{m}(1);
        fit1.Tau(m) = fit1.ParamFit{m}(2);
        fit1.Con(m) = fit1.ParamFit{m}(3);
        fit1.Est{m} = fit1.Amp(m) .* exp(-fit1.xZeroed{m} ./ fit1.Tau(m)) + fit1.Con(m);
        fit1.SSE(m) = sum((fit1.Est{m} - fit1.y{m}) .^ 2);
        
        Cm(m) = fit1.Tau(m) ./ Rm(m) * 1000;        % to convert to pF
    end

%% Calculate means and standard deviations of spike step parameters
    rheo.StepIMn            = mean(rheo.StepI, 'omitnan');
    rheo.StepISd                = std(rheo.StepI, 'omitnan');
    rheo.nSpikesMn              = mean(rheo.nSpikes, 'omitnan');
    rheo.nSpikesSd              = std(rheo.nSpikes, 'omitnan');
    rheo.LatencyMn              = mean(rheo.Latency, 'omitnan');
    rheo.LatencySd              = std(rheo.Latency, 'omitnan');
    rheo.ThreshMn               = mean(rheo.Thresh, 'omitnan');
    rheo.ThreshSd               = std(rheo.Thresh, 'omitnan');
    rheo.WidthMn                = mean(rheo.Width, 'omitnan');
    rheo.WidthSd                = std(rheo.Width, 'omitnan');
    rheo.PeakMn                 = mean(rheo.Peak, 'omitnan');
    rheo.PeakSd                 = std(rheo.Peak, 'omitnan');
    rheo.AmpMn                  = mean(rheo.Amp, 'omitnan');
    rheo.AmpSd                  = std(rheo.Amp, 'omitnan');
    rheo.FWHAMn                 = mean(rheo.FWHA, 'omitnan');
    rheo.FWHASd                 = std(rheo.FWHA, 'omitnan');

    halfMax.StepIMn             = mean(halfMax.StepI);
    halfMax.StepISd             = std(halfMax.StepI);
    halfMax.nSpikesMn           = mean(halfMax.nSpikes);
    halfMax.nSpikesSd           = std(halfMax.nSpikes);
    halfMax.SpikeIntRatioMn     = mean(halfMax.SpikeIntRatio, 'omitnan');
    halfMax.SpikeIntRatioSd     = std(halfMax.SpikeIntRatio, 'omitnan');
    halfMax.SpikeLatencyMn      = mean(halfMax.SpikeLatency, 'omitnan');
    halfMax.SpikeLatencySd      = std(halfMax.SpikeLatency, 'omitnan');
    halfMax.SpikePeakMn         = mean(halfMax.SpikePeak, 'omitnan');
    halfMax.SpikePeakSd         = std(halfMax.SpikePeak, 'omitnan');
    halfMax.SpikeWidthMn        = mean(halfMax.SpikeWidth, 'omitnan');
    halfMax.SpikeWidthSd        = std(halfMax.SpikeWidth, 'omitnan');

    setI.nSpikesMn              = step.nSpikesMn(setI.Step);
    setI.nSpikesSd              = step.nSpikesSd(setI.Step);
    setI.SpikeIntRatioMn        = step.SpikeIntRatioMn(setI.Step);
    setI.SpikeIntRatioSd        = step.SpikeIntRatioSd(setI.Step);
    setI.SpikeLatencyMn         = step.SpikeLatencyMn(setI.Step);
    setI.SpikeLatencySd         = step.SpikeLatencySd(setI.Step);
    setI.SpikePeakMn            = step.SpikePeakMn(setI.Step);
    setI.SpikePeakSd            = step.SpikePeakSd(setI.Step);
    setI.SpikeWidthMn           = step.SpikeWidthMn(setI.Step);
    setI.SpikeWidthSd           = step.SpikeWidthSd(setI.Step);

%% Compute voltage sag by fitting a double exponential to the largest negative current step
    largestNegI = min(PRT.IStepVals);
    largestNegStep = find(PRT.IStepVals == largestNegI);
    
    fit2.x              = stimTime;
    fit2.xZeroed        = stimTime - stimTime(1);
    fit2.graphWindow    = 1:stimWindow(1) + stimWindow(end) - 1;
    fit2.xGraph         = sweepTime(fit2.graphWindow);
    fit2.y              = mean(DATA.data(activeNegStep, largestNegStep:nSteps:nSweeps), 2);  % Mean for current applied across all largest negative step sweeps
    fit2.yGraph         = mean(DATA.data(fit2.graphWindow, largestNegStep:nSteps:nSweeps), 2);

    fit2.ConGuess       = mean(fit2.y(end-99:end));    
    fit2.FastAmpGuess   = mean(maxk(fit2.y, 50)) - mean(mink(fit2.y, 50));
    fit2.SlowAmpGuess   = mean(mink(fit2.y, 50)) - fit2.ConGuess - fit2.FastAmpGuess * 0.125;
    
    atCon = fit2.xZeroed(fit2.ConGuess > fit2.y);
    fit2.FastTauGuess = atCon(1) / 2;

    yAve = movmean(fit2.y, 20);
    [~,yMinIdx] = min(yAve);
    yMinTime = fit2.xZeroed(yMinIdx);

    xSeg = fit2.xZeroed(yAve > fit2.ConGuess);
    xSegPostDecline = xSeg(xSeg > yMinTime);
    if isempty(xSegPostDecline)
        fit2.SlowTauGuess = 0;
    else
        fit2.SlowTauGuess = xSegPostDecline(1) / 2;
    end

    fit2.GuessInitial   = [fit2.FastAmpGuess, fit2.FastTauGuess, fit2.SlowAmpGuess, fit2.SlowTauGuess, fit2.ConGuess];
    fit2.GuessEst       = fit2.FastAmpGuess .* exp(-fit2.xZeroed ./ fit2.FastTauGuess) + fit2.SlowAmpGuess .* exp(-fit2.xZeroed ./ fit2.SlowTauGuess) + fit2.ConGuess;
    fit2.Options        = optimset('TolFun', 1e-15, 'MaxIter', 10000);
    fit2.ParamFit       = fminsearch('fitexptau2', fit2.GuessInitial, fit2.Options, fit2.xZeroed, fit2.y);

    [fit2.FastTau, FastTauIdx] = min([fit2.ParamFit(2), fit2.ParamFit(4)]);
    fit2.SlowTau = max([fit2.ParamFit(2), fit2.ParamFit(4)]);

    if FastTauIdx == 1
        fit2.FastAmp = fit2.ParamFit(1);
        fit2.SlowAmp = fit2.ParamFit(3);
    elseif FastTauIdx == 2
        fit2.FastAmp = fit2.ParamFit(3);
        fit2.SlowAmp = fit2.ParamFit(1);
    end

    fit2.Con    = fit2.ParamFit(5);
    fit2.Est  = fit2.FastAmp .* exp(-fit2.xZeroed ./ fit2.FastTau) + fit2.SlowAmp .* exp(-fit2.xZeroed ./ fit2.SlowTau) + fit2.Con;
    fit2.SSE  = sum( (fit2.Est - fit2.y) .^2 );

%% Compute means and standard deviations to save off
    C.inputResistanceMn  = mean(Rm);
    C.inputResistanceSd  = std(Rm);
    C.restingPotentialMn = mean(Vr);
    C.restingPotentialSd = std(Vr);
    C.capacitanceMn      = mean(Cm);
    C.capacitanceSd      = std(Cm);

%% Graph computational work
    CCIV_SingleGraph(graphName, graphGeno, displaySweeps, DATA, PRT, C, step, rheo, halfMax, fit1, fit2)

%% Compute counts of rebound and spontaneous spikes and prepare to save off
    spontan.Sweeps = sum(~cellfun('isempty', spontanIdx));
    spontan.Spikes = sum(cellfun('prodofsize', spontanIdx));
    
    exclude.Sweeps = sum(~cellfun('isempty', excludeIdx));
    exclude.Spikes = sum(cellfun('prodofsize', excludeIdx));

    rebound.Sweeps = sum(~cellfun('isempty', reboundIdx));
    rebound.Spikes = sum(cellfun('prodofsize', reboundIdx));

    exclude.Idx = excludeIdx;
    spontan.Idx = spontanIdx;
    rebound.Idx = reboundIdx;

%% Perform calculations for spike length and frequency checks
    longSpikeCheck      = 0;
    shortSpikeCheck     = 0;
    closeSpikesCheck    = 0;

    for m = 1:length(upCrossTimes)
        crossLengths = downCrossTimes{m} - upCrossTimes{m};
        longSpikeCheck = longSpikeCheck + sum(crossLengths > 20);
        shortSpikeCheck = shortSpikeCheck + sum(crossLengths < 0.2);
    
        upCrossDiffs = diff(upCrossTimes{m});
        closeSpikesCheck = closeSpikesCheck + sum(upCrossDiffs < 2);
    end

    longRheoCheck = sum(rheo.Width > 20);
    shortRheoCheck = sum(rheo.Width < 0.2);

%% Calculate a few more parameters to save off
    rep.MaxSpikesMn = mean(rep.MaxSpikes, 'omitnan');
    rep.MaxSpikesSd = std(rep.MaxSpikes, 'omitnan');

    rep.SpikeCountRatio = step.nSpikes{end} ./ rep.MaxSpikes';
    rep.SpikeCountRatioMn = mean(rep.SpikeCountRatio, 'omitnan');
    rep.SpikeCountRatioSd = std(rep.SpikeCountRatio, 'omitnan');

    newIntRatio.Steps = mean(step.SpikeIntRatioMn, 'omitnan'); 
    newIntRatio.Sweeps = mean(cell2mat(step.SpikeIntRatio), 'omitnan');

%% Save off computational output to Matlab files
    output.ExcelRows        = ExcelRows{fileNum};
    output.DataFile         = dataFile{fileNum};
    output.DataType         = dataType{fileNum};
    output.Researcher       = researcher{fileNum};
    output.DisplaySweeps    = displaySweeps;
    output.RunType          = runType;
    output.PRT              = PRT;
    output.DATA             = DATA;
    output.byStep           = step;
    output.byRepetition     = rep;
    output.Rheo             = rheo;
    output.HalfMax          = halfMax;
    output.SetCurrent       = setI;
    output.CellParams       = C;
    output.CurveFit1        = fit1;
    output.CurveFit2        = fit2;
    output.Spontan          = spontan;
    output.Exclude          = exclude;
    output.Rebound          = rebound;
    output.NewIntRatio      = newIntRatio;

    saveName = strcat(graphName," Output.mat");
    save(saveName, 'output')

%% Save off computational output back to Excel spreadsheet
    fullExcel{MatlabRows(fileNum), 'VersionNum'}        = {versionNum + ", " + string(datetime('today', 'Format', 'MM/dd/uuuu'))};
    fullExcel{MatlabRows(fileNum), 'RheoIStep_pA'}      = rheo.StepIMn;
    fullExcel{MatlabRows(fileNum), 'RheoCount'}         = rheo.nSpikesMn;
    fullExcel{MatlabRows(fileNum), 'RheoLatency_ms'}    = rheo.LatencyMn;
    fullExcel{MatlabRows(fileNum), 'RheoThresh_mV'}     = rheo.ThreshMn;
    fullExcel{MatlabRows(fileNum), 'RheoAmp_mV'}        = rheo.AmpMn;
    fullExcel{MatlabRows(fileNum), 'RheoPeak_mV'}       = rheo.PeakMn;
    fullExcel{MatlabRows(fileNum), 'RheoWidth_ms'}      = rheo.WidthMn;
    fullExcel{MatlabRows(fileNum), 'RheoFWHA_ms'}       = rheo.FWHAMn;

    fullExcel{MatlabRows(fileNum), 'MaxCount'}          = rep.MaxSpikesMn;
    fullExcel{MatlabRows(fileNum), 'StepHalfMax'}       = halfMax.StepIMn;
    fullExcel{MatlabRows(fileNum), 'CountRatio'}        = rep.SpikeCountRatioMn;

    fullExcel{MatlabRows(fileNum), 'SagFastAmp_mV'}     = fit2.FastAmp;
    fullExcel{MatlabRows(fileNum), 'SagSlowAmp_mV'}     = fit2.SlowTau;
    fullExcel{MatlabRows(fileNum), 'SagFastTau_1ms'}    = fit2.FastTau;
    fullExcel{MatlabRows(fileNum), 'SagSlowTau_1ms'}    = fit2.SlowTau;
    fullExcel{MatlabRows(fileNum), 'SagConstant_mV'}    = fit2.Con;

    fullExcel{MatlabRows(fileNum), 'SpontanSweeps'}     = spontan.Sweeps;
    fullExcel{MatlabRows(fileNum), 'SpontanSpikes'}     = spontan.Spikes;
    fullExcel{MatlabRows(fileNum), 'ExcludeSweeps'}     = exclude.Sweeps;
    fullExcel{MatlabRows(fileNum), 'ExcludeSpikes'}     = exclude.Spikes;
    fullExcel{MatlabRows(fileNum), 'ReboundSweeps'}     = rebound.Sweeps;
    fullExcel{MatlabRows(fileNum), 'ReboundSpikes'}     = rebound.Spikes;

    fullExcel{MatlabRows(fileNum), 'LongSpikeCheck'}    = longSpikeCheck;
    fullExcel{MatlabRows(fileNum), 'ShortSpikeCheck'}   = shortSpikeCheck;
    fullExcel{MatlabRows(fileNum), 'CloseSpikesCheck'}  = closeSpikesCheck;
    fullExcel{MatlabRows(fileNum), 'LongRheoCheck'}     = longRheoCheck;
    fullExcel{MatlabRows(fileNum), 'ShortRheoCheck'}    = shortRheoCheck;

    if longSpikeCheck + shortSpikeCheck + closeSpikesCheck + longRheoCheck + shortRheoCheck == 0
        fullExcel{MatlabRows(fileNum), 'GoodOutput'}      = {'yes'};
    else
        fullExcel{MatlabRows(fileNum), 'GoodOutput'}      = {'no'};
    end

    cd(mainDir)
    writetable(fullExcel, tableName)

    close all
end
