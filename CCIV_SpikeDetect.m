function [upCrossIdx, upCrossTimes, downCrossIdx, downCrossTimes, spontanIdx, excludeIdx, reboundIdx, rheo]  = CCIV_SpikeDetect(stimWindow, sweepTime, ...
   sweepPts, sweepWindow, DATA, PRT, nSweeps, nSteps, nReps, displayFrames, currentFile, stimTime, graphName, graphGeno, displaySweeps)

% Spike counting taken and modified from spikedetect.m
% Set up to work with CCIV_SingleAnalysis.m
% Danny Lasky, 8/23

%% Prepare variables
upCrossIdx      = cell(nSweeps, 1);
upCrossTimes    = cell(nSweeps, 1);
downCrossIdx    = cell(nSweeps, 1);
downCrossTimes  = cell(nSweeps, 1);
spontanIdx      = cell(nSweeps, 1);
excludeIdx      = cell(nSweeps, 1);
reboundIdx      = cell(nSweeps, 1);
secondDerivAll  = cell(nSweeps, 1);

preStimWindow   = (1:stimWindow(1) - 1)';
postStimWindow  = (stimWindow(end) + 1:sweepPts)';
dt = mean(diff(DATA.time));                             % Sample interval (ms)

rheo.Sweep      = NaN(nReps, 1);
rheo.Step       = NaN(nReps, 1);
rheo.StepI      = NaN(nReps, 1);
rheo.nSpikes    = NaN(nReps, 1);

rheo.StartIdx   = NaN(nReps, 1);
rheo.StartTime  = NaN(nReps, 1);
rheo.Latency    = NaN(nReps, 1);
rheo.Thresh     = NaN(nReps, 1);
rheo.EndIdx     = NaN(nReps, 1);
rheo.EndTime    = NaN(nReps, 1);
rheo.WidthPts   = NaN(nReps, 1);
rheo.Width      = NaN(nReps, 1);

rheo.Peak               = NaN(nReps, 1);
rheo.PeakIdx            = NaN(nReps, 1);
rheo.PeakTime           = NaN(nReps, 1);
rheo.Amp                = NaN(nReps, 1);
rheo.HalfAmp            = NaN(nReps, 1);
rheo.HalfAmpY           = NaN(nReps, 1);
rheo.HalfAmpStartIdx    = NaN(nReps, 1);
rheo.HalfAmpStartTime   = NaN(nReps, 1);
rheo.HalfAmpEndIdx      = NaN(nReps, 1);
rheo.HalfAmpEndTime     = NaN(nReps, 1);
rheo.FWHA               = NaN(nReps, 1);

rheoGraph = 0;

%% Create a logical vector for if a sweep was hyperpolarizing, depolarizing, or 0
sweepStims      = repmat(PRT.IStepVals, 1, nReps);
hyperpolSweep   = sweepStims < 0;
noCurrentSweep  = sweepStims == 0;
depolSweep      = sweepStims > 0;

%% Begin computation and graphing loop
for n = 1:nSweeps
    if any(n == displayFrames)
        displayFlag = 1;
    else
        displayFlag = 0;
    end
    
    %% Get original signal, perform Savitzky-Golay filtering, calculate derivatives
    sweepData = DATA.data(:,n);
    sweepDataSGol = sgolayfilt(sweepData, 3, 11);
    firstDeriv = gradient(sweepDataSGol) ./ gradient(sweepTime); 
    secondDeriv = gradient(firstDeriv) ./ gradient(sweepTime);

    %% Find 1st derivative points above and below threshold of +30 mV/ms and -15 mV
    FirstDerivUpThresh = 30;                                        % mV/ms
    firstDerAbove   = zeros(1, sweepPts);
    firstDerAbove(firstDeriv > FirstDerivUpThresh) = 1;             % Want it as a double, not a logical, so we can use the diff function

    FirstDerivDownThresh = -15;                                     % mV/ms
    firstDerBelow = zeros(1, sweepPts);
    firstDerBelow(firstDeriv < FirstDerivDownThresh) = 1;           % Want it as a double, not a logical, so we can use the diff function

    %% Find 1st derivative points and times crossing above and below threshold
    upCross_1D = zeros(1, sweepPts);
    upCross_1D(diff([0 firstDerAbove]) > 0) = 1;
    upCrossIdx_1D = find(upCross_1D);
    upCrossTimes_1D = sweepTime(upCrossIdx_1D);
    
    downCross_1D    = zeros(1, sweepPts);
    downCross_1D(diff([0 firstDerBelow]) > 0) = 1;
    downCrossIdx_1D = find(downCross_1D);
    downCrossTimes_1D = sweepTime(downCrossIdx_1D);

    %% Remove 1st derivative up cross if it does not have a down cross in the following 10 ms
    validUpCross = zeros(length(upCrossIdx_1D), 1);

    firstDerDownBounds = 10/dt;
    for m = 1:length(upCrossIdx_1D)
        if any(intersect(upCrossIdx_1D(m):upCrossIdx_1D(m) + firstDerDownBounds, downCrossIdx_1D))
            validUpCross(m, 1) = 1;
        end
    end

    if ~isempty(upCrossIdx_1D)
        upCrossIdx_1D(validUpCross == 0) = [];
        upCrossTimes_1D(validUpCross == 0) = [];
    end

    %% Remove 1st derivative up cross if it follows another 1st derivative up cross by 1 ms
    % Caused by signal noise bouncing above and below the threshold. It is also fixed for down crosses in the next section
    validUpCross2 = zeros(length(upCrossIdx_1D), 1);

    firstInterBounds = 1/dt;
    for m = 1:length(upCrossIdx_1D)
        if ~any(intersect(upCrossIdx_1D(m) - firstInterBounds:upCrossIdx_1D(m) - 1, upCrossIdx_1D))     % upCrossIdx_1D(m) - 1 so it value does not intersect itself
            validUpCross2(m, 1) = 1;
        end
    end

    if ~isempty(upCrossIdx_1D)
        upCrossIdx_1D(validUpCross2 == 0) = [];
        upCrossTimes_1D(validUpCross2 == 0) = [];
    end

    %% For each valid 1st derivative up cross, pair it to the soonest 1st deritaive down cross that follows
    validDownCross = zeros(length(downCrossIdx_1D), 1);

    for m = 1:length(upCrossIdx_1D)
        matchedCross = min(downCrossIdx_1D(downCrossIdx_1D > upCrossIdx_1D(m)));
        validDownCross(downCrossIdx_1D == matchedCross) = 1;
    end

    if ~isempty(downCrossIdx_1D)
        downCrossIdx_1D(validDownCross == 0) = [];
        downCrossTimes_1D(validDownCross == 0) = [];
    end

    %% For each valid 1st derivative down cross, pair it to the soonest 1st deritaive up cross that precedes it
    validUpCross3 = zeros(length(upCrossIdx_1D), 1);

    for m = 1:length(downCrossIdx_1D)
        matchedCross = max(upCrossIdx_1D(upCrossIdx_1D < downCrossIdx_1D(m)));
        validUpCross3(upCrossIdx_1D == matchedCross) = 1;
    end

    if ~isempty(upCrossIdx_1D)
        upCrossIdx_1D(validUpCross3 == 0) = [];
        upCrossTimes_1D(validUpCross3 == 0) = [];
    end

    %% Check if original signal was above 0 mV between 1st derivative up and down crosses
    validZeroCross = zeros(length(upCrossIdx_1D), 1);
    for m = 1:length(upCrossIdx_1D)
        cross_1D = upCrossIdx_1D(m):downCrossIdx_1D(m);
        if any(sweepData(cross_1D) > 0)
            validZeroCross(m, 1) = 1;
        end
    end

    if ~isempty(upCrossIdx_1D)
        upCrossIdx_1D(validZeroCross == 0) = [];
        upCrossTimes_1D(validZeroCross == 0) = [];
        downCrossIdx_1D(validZeroCross == 0) = [];
        downCrossTimes_1D(validZeroCross == 0) = [];
    end

    %% Mark rebound and spontaneous spikes and remove depending on circumstances
    if ~isempty(upCrossIdx_1D)
        if hyperpolSweep(n) == 1
            spontanIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, [preStimWindow; stimWindow]));
            excludeIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, [preStimWindow; stimWindow]));
            reboundIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, postStimWindow));
            validStimCross = ismember(upCrossIdx_1D, postStimWindow);
        elseif noCurrentSweep(n) == 1
            spontanIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, sweepWindow));
            excludeIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, sweepWindow));
            validStimCross = [];
        elseif depolSweep(n) == 1
            spontanIdx{n} = upCrossIdx_1D(ismember(upCrossIdx_1D, [preStimWindow; postStimWindow]));
            validStimCross = ismember(upCrossIdx_1D, stimWindow);
        end
        upCrossIdx_1D       = upCrossIdx_1D(validStimCross);
        upCrossTimes_1D     = upCrossTimes_1D(validStimCross);
        downCrossIdx_1D     = downCrossIdx_1D(validStimCross);
        downCrossTimes_1D   = downCrossTimes_1D(validStimCross);
    end

    %% Determine whether the sweep is rheobase and compute related variables
    if any(n == 1:nSteps:nSweeps)
        rRep = (n - 1) / nSteps + 1;
    end

    if rRep > 0 && ~isempty(upCrossIdx_1D) && depolSweep(n) == 1       % Must be in a new repetition, have at least one spike, and during a depolarizing step
        rheo.Sweep(rRep) =  n;
        rheoStep = n - floor((n-1)/nSteps) * nSteps;
        rheo.Step(rRep)     = rheoStep;
        rheo.StepI(rRep)    = PRT.IStepVals(rheoStep);
        rheo.nSpikes(rRep)  = length(upCrossIdx_1D);

        %% For the first spike at rheobase, find the maximum in the 2nd derivative within the preceeding 3 ms of the 1st derivative up cross (threshold)
        secondDerWindow = 3;        % ms
        secondDerBounds = secondDerWindow/dt;

        rheo.WindowStartIdx(rRep)   = upCrossIdx_1D(1) - secondDerBounds;
        rheo.WindowEndIdx(rRep)     = upCrossIdx_1D(1);
        rheo.WindowStartTime(rRep)  = sweepTime(rheo.WindowStartIdx(rRep));
        rheo.WindowEndTime(rRep)    = sweepTime(rheo.WindowEndIdx(rRep));

        [~, rheoMaxTemp] = max(secondDeriv(rheo.WindowStartIdx(rRep):rheo.WindowEndIdx(rRep)));
        
        rheo.StartIdx(rRep)     = upCrossIdx_1D(1) - secondDerBounds + rheoMaxTemp - 1;       % Framing the rheoMax in the context of the entire sweep
        rheo.Latency(rRep)      = sweepTime(rheo.StartIdx(rRep)) - stimTime(1);
        rheo.StartTime(rRep)    = sweepTime(rheo.StartIdx(rRep));
        rheo.Thresh(rRep)       = sweepData(rheo.StartIdx(rRep));

        %% Find the first value crossing back under the rheobase threshold following the rheobase spike
        rheoBelow = zeros(1, sweepPts);
        rheoBelow(sweepData < rheo.Thresh(rRep)) = 1; 
        
        downCrossRheo = zeros(1,1);
        downCrossRheo(diff([0 rheoBelow]) > 0) = 1;
        downCrossRheo       = find(downCrossRheo);

        rheo.EndIdx(rRep)   = min(downCrossRheo(downCrossRheo > rheo.StartIdx(rRep) + 0.5/dt));   % Require length of 0.5 ms to prevent signal wobble down cross
        rheo.EndTime(rRep)  = sweepTime(rheo.EndIdx(rRep));
        rheo.WidthPts(rRep) = rheo.EndIdx(rRep) - rheo.StartIdx(rRep);
        rheo.Width(rRep)    = rheo.EndTime(rRep) - rheo.StartTime(rRep);

%% Stop rheobase calculations and remove rheobase if width greater than 20 ms, otherwise continue
        if rheo.Width(rRep) > 20
            rheo.Sweep(rRep)        = NaN;
            rheo.Step(rRep)         = NaN;
            rheo.StepI(rRep)        = NaN;
            rheo.nSpikes(rRep)      = NaN;
            rheo.StartIdx(rRep)     = NaN;
            rheo.StartTime(rRep)    = NaN;
            rheo.Latency(rRep)      = NaN;
            rheo.Thresh(rRep)       = NaN;
            rheo.EndIdx(rRep)       = NaN;
            rheo.EndTime(rRep)      = NaN;
            rheo.WidthPts(rRep)     = NaN;
            rheo.Width(rRep)        = NaN;
            rheo.Peak(rRep)         = NaN;
        else
            [rheo.Peak(rRep), tempIdx]  = max(sweepData(rheo.StartIdx(rRep):rheo.EndIdx(rRep)));
            rheo.PeakIdx(rRep)          = rheo.StartIdx(rRep) + tempIdx - 1;
            rheo.PeakTime(rRep)         = sweepTime(rheo.PeakIdx(rRep));
            rheo.Amp(rRep)              = rheo.Peak(rRep) - rheo.Thresh(rRep);
            rheo.HalfAmp(rRep)          = (rheo.Peak(rRep) - rheo.Thresh(rRep))/2;
            rheo.HalfAmpY(rRep)         = rheo.HalfAmp(rRep) + rheo.Thresh(rRep);

        %% Graphing code for looking at rheobase up and down crosses
%         firstDerivScale = rescale(firstDeriv, min(sweepData), max(sweepData));
%         secondDerivScale = rescale(secondDeriv, min(sweepData), max(sweepData));
% 
%         firtDerivSGol = sgolayfilt(firstDeriv, 3, 15);
%         firstDerivSGolScale = rescale(firtDerivSGol, min(sweepData), max(sweepData));
% 
%         figure
%         plot(sweepTime, sweepData, 'k')
%         hold on      
%         plot(sweepTime, firstDerivScale, 'b')
%         plot(sweepTime, firstDerivSGolScale, 'r')
% 
%         plot(rheo.StartTime(rRep), firstDeriv(rheo.StartIdx(rRep)), 'go')
%         plot(sweepTime(downCrossRheo), firstDeriv(downCrossRheo), 'ro')
%         
%         yyaxis left
%         plot(sweepTime, secondDeriv, 'k')
% 
%         xlim([sweepTime(upCrossIdx_1D(1) - secondDerBounds * 3), sweepTime(upCrossIdx_1D(1) + secondDerBounds * 3)])
% 
%         yyaxis right
%         plot(sweepTime, firstDeriv, 'b')

        %% Find the first value crossing above half amp y following rheobase start and first value crossing under half amp y following rheobase peak
            halfAmpAbove = zeros(1, sweepPts);
            halfAmpAbove(sweepData > rheo.HalfAmpY(rRep)) = 1;  
            
            upCrossHalfAmp = zeros(1,1);
            upCrossHalfAmp(diff([0 halfAmpAbove]) > 0) = 1;
            upCrossHalfAmp = find(upCrossHalfAmp);
            rheo.HalfAmpStartIdx(rRep) = min(upCrossHalfAmp(upCrossHalfAmp > rheo.StartIdx(rRep)));
            rheo.HalfAmpStartTime(rRep) = sweepTime(rheo.HalfAmpStartIdx(rRep));
    
            halfAmpBelow = zeros(1, sweepPts);
            halfAmpBelow(sweepData < rheo.HalfAmpY(rRep)) = 1; 
    
            downCrossHalfAmp            = zeros(1,1);
            downCrossHalfAmp(diff([0 halfAmpBelow]) > 0) = 1;
            downCrossHalfAmp            = find(downCrossHalfAmp);
            rheo.HalfAmpEndIdx(rRep)    = min(downCrossHalfAmp(downCrossHalfAmp > rheo.PeakIdx(rRep)));
            rheo.HalfAmpEndTime(rRep)   = sweepTime(rheo.HalfAmpEndIdx(rRep));
            rheo.FWHA(rRep)             =  rheo.HalfAmpEndTime(rRep) -  rheo.HalfAmpStartTime(rRep);
            
            graphIdx = rRep;
            rRep = 0;
            rheoGraph = 1;
        end
    end

    %% Prepare output for main script
    upCrossIdx{n}       = upCrossIdx_1D;
    upCrossTimes{n}     = upCrossTimes_1D;
    downCrossIdx{n}     = downCrossIdx_1D;
    downCrossTimes{n}   = downCrossTimes_1D;
    % sweepSGolAll{n}     = sweepDataSGol;
    % firstDerivAll{n}    = firstDeriv;
    secondDerivAll{n}   = secondDeriv;

    %% Plot data and detected spike times
    if displayFlag == 1
        if n == displayFrames(1)
            figure('units', 'inch', 'pos', [22 2 14 9.5]);
            % figure('units', 'inch', 'pos', [0.5 0.5 12 8.5]);
        end
        
        t = tiledlayout(3,1);
        title(t, currentFile + " Sweep #" + n + " of " + nSweeps, 'FontSize', 20, 'Interpreter', 'none')
        t.TileSpacing = 'compact';
        t.Padding = 'compact';

        t1 = nexttile;
        cla
        ax = gca;
        hold on
        ax.FontSize = 12; 
        plot(sweepTime, sweepData, 'b')
        yline(0, 'k')
        scatter(sweepTime(upCrossIdx_1D), zeros(length(upCrossIdx_1D), 1), 'ko');
        scatter(sweepTime(downCrossIdx_1D), zeros(length(downCrossIdx_1D), 1), 'k*');
        ylim([-80 80])
        ylabel('Resting Potential (mV)', 'fontsize', 16)
        legend('', 'Original threshold (0 mV)', 'FontSize', 10)
        % xlabel('Time (ms)', 'FontSize', 16)
        xlim([-10 1010])
        title('Original', 'FontSize', 18)
        ax.YAxis(1).Color = 'b';

        t2 = nexttile;
        cla
        ax = gca;
        ax.FontSize = 12; 
        yyaxis left
            plot(sweepTime, sweepData, 'b')
            ylim([-80 80])
            ylabel('Resting Potential (mV)', 'fontsize', 16)
        yyaxis right
            plot(sweepTime, firstDeriv, 'r')
            hold on
            yline(FirstDerivUpThresh, 'k')
            yline(FirstDerivDownThresh, 'k')
            scatter(sweepTime(upCrossIdx_1D), firstDeriv(upCrossIdx_1D), 'ko');
            scatter(sweepTime(downCrossIdx_1D), firstDeriv(downCrossIdx_1D), 'k*');
            ylim([-100 200])
            ylabel('1st Derivative', 'FontSize', 16)
        legend('', '', "1st derivative up threshold (" + FirstDerivUpThresh + " mV/ms)", "1st derivative down threshold (" + FirstDerivDownThresh + ...
            " mV/ms)", 'FontSize', 10)
        xlim([-10 1010])
        title('1st Derivative', 'FontSize', 18)
        ax.YAxis(1).Color = 'b';
        ax.YAxis(2).Color = 'r';

        t3 = nexttile;
        cla
        ax = gca;
        ax.FontSize = 12; 
        yyaxis left
            plot(sweepTime, sweepData, 'b')
            ylim([-80 80])
            ylabel('Resting Potential (mV)', 'fontsize', 16)
        yyaxis right
            plot(sweepTime, secondDeriv, 'r')
            if rheoGraph == 1
                hold on
                scatter(sweepTime(rheo.StartIdx(graphIdx)), secondDeriv(rheo.StartIdx(graphIdx)), 'ko');
            end
            ylim([-400 800])
            ylabel('2nd Derivative', 'FontSize', 16)
        xlabel('Time (ms)', 'FontSize', 16)
        xlim([-10 1010])
        title('2nd Derivative', 'FontSize', 18)
        ax.YAxis(1).Color = 'b';
        ax.YAxis(2).Color = 'r';

        zoom on; hold off
        drawnow
        linkaxes([t1 t2 t3], 'x')
        if rheoGraph == 1
            pause(3)
            rheoGraph = 0;
            rRep = 0;
        end
    end
end

%% Figure for all rheobase sweeps
figure('units', 'inch', 'pos', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, strcat(graphName, " ", graphGeno, " Rheobase"), 'FontSize', 24)

%% Displays five selected sweeps of spike response (mV) vs time (s)
t1 = nexttile;
    plot(DATA.time, DATA.data(:, displaySweeps), 'LineWidth', 1.5)
    title('Five Voltage Responses', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([0 1000])
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16); 
    ylabel('Voltage (mV)', 'FontSize', 16); 

%% Displays each instance of rheobase
for n = 1:nReps
    nexttile;
    if ~isnan(rheo.StepI(n))
        windowRange = 8/dt;
        rheoRange       = sweepTime(rheo.StartIdx(n) - windowRange : rheo.EndIdx(n) + windowRange);
        rheoIdx         = rheo.StartIdx(n)- windowRange : rheo.EndIdx(n) + windowRange;
        rheoVals        = DATA.data(rheo.StartIdx(n)- windowRange : rheo.EndIdx(n) + windowRange, rheo.Sweep(n));

        yyaxis right
            plot(rheoRange, rheoVals, 'b-', 'LineWidth', 1.5)
            hold on
            plot([rheoRange(1), rheo.StartTime(n)], [rheo.Thresh(n), rheo.Thresh(n)], 'k-', 'LineWidth', 1)
            plot([rheo.EndTime(n), rheoRange(end)], [rheo.Thresh(n), rheo.Thresh(n)], 'k-', 'LineWidth', 1)
            plot([rheo.StartTime(n), rheo.EndTime(n)], [rheo.Thresh(n), rheo.Thresh(n)], 'r-', 'LineWidth', 1.5)
            scatter(rheo.StartTime(n), rheo.Thresh(n), 'ro', 'filled')
            scatter(rheo.EndTime(n), rheo.Thresh(n), 'ro', 'filled')
    
            plot([rheo.PeakTime(n), rheo.PeakTime(n)], [rheo.Thresh(n), rheo.Peak(n)], 'r-', 'LineWidth', 1.5);
            scatter(rheo.PeakTime(n), rheo.Thresh(n), 'ro', 'filled')
            scatter(rheo.PeakTime(n), rheo.Peak(n), 'ro', 'filled')
    
            plot([rheo.HalfAmpStartTime(n), rheo.HalfAmpEndTime(n)], [rheo.HalfAmpY(n), rheo.HalfAmpY(n)], 'r-', 'LineWidth', 1.5);
            scatter(rheo.PeakTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            scatter(rheo.HalfAmpStartTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            scatter(rheo.HalfAmpEndTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            ylabel('Membrane Potential (mV)', 'FontSize', 14);

        yyaxis left
            plot(rheoRange, secondDerivAll{rheo.Sweep(n)}(rheoIdx), 'k', 'LineWidth', 1.5)
            yLimits = ylim;
            axis manual
            rectangle('Position', [rheo.WindowStartTime(n), yLimits(1), secondDerWindow, yLimits(2) - yLimits(1)], 'FaceColor', [1 1 0.07 0.25]);
            ax = gca;
            ax.Children = circshift(ax.Children, -1);
            ylabel('Second Derivative (mV/ms^2)', 'FontSize', 16);

        xlim([rheoRange(1) rheoRange(end)])
        ax.YAxis(1).Color = 'k';
        ax.YAxis(2).Color = 'b';
    end
    title("Rheobase Repetition #" + n, 'FontSize', 16, 'FontWeight', 'Normal')
    xlabel('Time (ms)', 'FontSize', 16);
    set(gca, 'FontSize', 14)
end
saveas(gcf, strcat(graphName," Rheo 2nd Der.png"))

%% Figure for all rheobase sweeps with afterhyperpolarization included
figure('units', 'inch', 'pos', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, strcat(graphName, " ", graphGeno, " Rheobase"), 'FontSize', 24)

%% Displays five selected sweeps of spike response (mV) vs time (s)
t1 = nexttile;
    plot(DATA.time, DATA.data(:, displaySweeps), 'LineWidth', 1.5)
    title('Five Voltage Responses', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([0 1000])
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16); 
    ylabel('Voltage (mV)', 'FontSize', 16); 

%% Displays each instance of rheobase with the afterhyperpolarization displayed
for n = 1:nReps
    nexttile;
    if ~isnan(rheo.StepI(n))
        rheoRange   = sweepTime(rheo.StartIdx(n) - 8/dt : rheo.EndIdx(n) + 30/dt);
        rheoIdx     = rheo.StartIdx(n)- 8/dt : rheo.EndIdx(n) + 30/dt;
        rheoVals    = DATA.data(rheo.StartIdx(n)- 8/dt : rheo.EndIdx(n) + 30/dt, rheo.Sweep(n));

        yyaxis right
            plot(rheoRange, rheoVals, 'b-', 'LineWidth', 1.5)
            hold on
            plot([rheoRange(1), rheo.StartTime(n)], [rheo.Thresh(n), rheo.Thresh(n)], 'k-', 'LineWidth', 1)
            plot([rheo.EndTime(n), rheoRange(end)], [rheo.Thresh(n), rheo.Thresh(n)], 'k-', 'LineWidth', 1)
            plot([rheo.StartTime(n), rheo.EndTime(n)], [rheo.Thresh(n), rheo.Thresh(n)], 'r-', 'LineWidth', 1.5)
            scatter(rheo.StartTime(n), rheo.Thresh(n), 'ro', 'filled')
            scatter(rheo.EndTime(n), rheo.Thresh(n), 'ro', 'filled')
    
            plot([rheo.PeakTime(n), rheo.PeakTime(n)], [rheo.Thresh(n), rheo.Peak(n)], 'r-', 'LineWidth', 1.5);
            scatter(rheo.PeakTime(n), rheo.Thresh(n), 'ro', 'filled')
            scatter(rheo.PeakTime(n), rheo.Peak(n), 'ro', 'filled')
    
            plot([rheo.HalfAmpStartTime(n), rheo.HalfAmpEndTime(n)], [rheo.HalfAmpY(n), rheo.HalfAmpY(n)], 'r-', 'LineWidth', 1.5);
            scatter(rheo.PeakTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            scatter(rheo.HalfAmpStartTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            scatter(rheo.HalfAmpEndTime(n), rheo.HalfAmpY(n), 'ro', 'filled')
            ylabel('Membrane Potential (mV)', 'FontSize', 14);

        yyaxis left
            plot(rheoRange, secondDerivAll{rheo.Sweep(n)}(rheoIdx), 'k', 'LineWidth', 1.5)
            yLimits = ylim;
            axis manual
            rectangle('Position', [rheo.WindowStartTime(n), yLimits(1), secondDerWindow, yLimits(2) - yLimits(1)], 'FaceColor', [1 1 0.07 0.25]);
            ax = gca;
            ax.Children = circshift(ax.Children, -1);
            ylabel('Second Derivative (mV/ms^2)', 'FontSize', 14);

        xlim([rheoRange(1) rheoRange(end)])
        ax.YAxis(1).Color = 'k';
        ax.YAxis(2).Color = 'b';
    end
    title("Rheobase Repetition #" + n, 'FontSize', 16, 'FontWeight', 'Normal')
    xlabel('Time (ms)', 'FontSize', 16);
    set(gca, 'FontSize', 14)
end
saveas(gcf, strcat(graphName," Rheo Long.png"))
