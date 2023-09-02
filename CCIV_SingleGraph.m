function CCIV_SingleGraph(graphName, graphGeno, displaySweeps, DATA, PRT, C, step, rheo, halfMax, fit1, fit2)

%% Function that works with CCIV_SingleAnalysis.m to produce graphs of the computational output
% Danny Lasky, 8/23

%% Waveforms and passive properties figure
figure('units', 'inch', 'pos', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, strcat(graphName, " ", graphGeno, " Parameters"), 'FontSize', 24)

%% Displays five selected sweeps of current injection (pA) vs time (s)
t1 = nexttile;
    plot(DATA.time, PRT.data(:, displaySweeps), 'LineWidth', 1.5)
    title('Five Current Injections', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([0 1000])
    ylim([-120 500])
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16);  
    ylabel('Injected Current (pA)', 'FontSize', 16);  

%% Displays five selected sweeps of spike response (mV) vs time (s)
t2 = nexttile;
    plot(DATA.time, DATA.data(:, displaySweeps), 'LineWidth', 1.5)
    title('Five Voltage Responses', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([0 1000])
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16); 
    ylabel('Voltage (mV)', 'FontSize', 16); 

%% Displays the single exponential fit to the smallest negative current step (first repetition)
t3 = nexttile;
    plot(fit1.xGraph{1}, fit1.yGraph{1}, 'ko'); hold on
    strFit1 = {['Amp = ' num2str(fit1.Amp(1), '%2.4f')] ; ['Tau = ' num2str(fit1.Tau(1), '%2.4f')] ; ['Constant = ' num2str(fit1.Con(1), '%2.4f')]};
    text(0.25, 0.75, strFit1, 'Color', '#E92B16', 'FontSize', 14, 'Units', 'Normalized')
    hold on
    plot(fit1.x{1}, fit1.Est{1}, '-', 'LineWidth', 2, 'Color', '#E92B16');
    plot(fit1.x{1}, fit1.GuessEst{1}, '--', 'LineWidth', 2, 'Color', '#21B3DE');
    title('Single Exp Fit to Smallest Neg Step', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([fit1.xGraph{1}(1) fit1.xGraph{1}(end)])
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16); 
    ylabel('Voltage (mV)', 'FontSize', 16);   

%% Displays the double exponential fit to the largest negative current step 
t4 = nexttile;
    plot(fit2.xGraph, fit2.yGraph, 'ko')
    strFit1 = {['Fast Amp = ' num2str(fit2.FastAmp, '%2.2f')] ; ['Fast Tau = ' num2str(fit2.FastTau, '%2.2f')] ; ['Slow Amp = ' num2str(fit2.SlowAmp, '%2.2f')] ; ...
        ['Slow Tau = ' num2str(fit2.SlowTau, '%2.2f')] ; ['Constant = ' num2str(fit2.Con, '%2.2f')]};
    text(0.25, 0.75, strFit1, 'Color', '#E92B16', 'FontSize', 14, 'Units', 'Normalized')
    hold on
    plot(fit2.x, fit2.Est, '-', 'LineWidth', 2, 'Color', '#E92B16');
    plot(fit2.x, fit2.GuessEst, '--', 'LineWidth', 2, 'Color', '#21B3DE');
    title('Double Exp Fit to Largest Neg Step', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([fit2.xGraph(1) fit2.xGraph(end)])
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16);  
    ylabel('Voltage (mV)', 'FontSize', 16);

%% Bar graph displaying additional parameters
t5 = nexttile;
    barData = [C.inputResistanceMn, C.restingPotentialMn, C.capacitanceMn];   % Converting Rm to MOhms, Vr to mV
    errorSd = [C.inputResistanceSd, C.restingPotentialSd, C.capacitanceSd];   % Converting Rm to MOhms, Vr to mV
    bar(1:3, barData, 'barwidth', 0.4)                
    hold on
    er = errorbar(1:3, barData, errorSd, 'LineWidth', 1.5);    
    er.Color = 'k';                            
    er.LineStyle = 'none';  
    title('Additional Parameters', 'FontSize', 16, 'FontWeight', 'Normal')
    %ylim([-100 max(barData + errorSd)*1.2])
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize =   14;
    barNames = {'Rm (MΩ)'; 'Vr (mV)' ; 'Cm (pF)' ; 'sWidth (1 * e-5 s)'};
    set(gca,'xticklabel',barNames)
    
    saveas(gcf, strcat(graphName," Parameters.png"))

%% Spike properties figure
figure('units', 'inch', 'pos', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, strcat(graphName, " ", graphGeno, " Spikes"), 'FontSize', 24)

%% Displays five selected sweeps of spike response (mV) vs time (s)
t1 = nexttile;
    plot(DATA.time, DATA.data(:, displaySweeps), 'LineWidth', 1.5)
    title('Five Voltage Responses', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([0 1000])
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    xlabel('Time (ms)', 'FontSize', 16); 
    ylabel('Voltage (mV)', 'FontSize', 16); 

%% Displays spike count vs injected current (pA)
t2 = nexttile;
    errorbar(PRT.IStepVals, step.nSpikesMn, step.nSpikesSd, 'ko-', 'LineWidth', 1.5); hold on
    [~,closestValRheo] = (min(abs(1e12*PRT.IStepVals - rheo.StepIMn)));
    
    yLimit = ylim;
    graphCon = (yLimit(2) - yLimit(1)) * 0.05;
    yGraphRheo = step.nSpikesMn(closestValRheo) - graphCon;

    plot([rheo.StepIMn - rheo.StepISd, rheo.StepIMn + rheo.StepISd], [yGraphRheo, yGraphRheo], 'Color', '#E92B16', 'LineWidth', 1.5)
    plot([rheo.StepIMn - rheo.StepISd, rheo.StepIMn - rheo.StepISd], [yGraphRheo - graphCon, yGraphRheo + graphCon], 'Color', '#E92B16', 'LineWidth', 1.5)
    plot([rheo.StepIMn + rheo.StepISd, rheo.StepIMn + rheo.StepISd], [yGraphRheo - graphCon, yGraphRheo + graphCon], 'Color', '#E92B16', 'LineWidth', 1.5)
    strRheo = ['Rheobase = ' num2str(rheo.StepIMn, '%1.1f') ' ± '  num2str(rheo.StepISd, '%1.1f') ' pA'];
    text(0.02, 0.94, strRheo, 'Color', '#E92B16', 'FontSize', 14,  'Units', 'Normalized')
    
    yGraphHalf = halfMax.nSpikesMn - graphCon;

    plot([halfMax.StepIMn - halfMax.StepISd, halfMax.StepIMn + halfMax.StepISd], [yGraphHalf, yGraphHalf], 'Color', '#21B3DE', 'LineWidth', 1.5)
    plot([halfMax.StepIMn - halfMax.StepISd, halfMax.StepIMn - halfMax.StepISd], [yGraphHalf - graphCon, yGraphHalf + graphCon], ...
        'Color', '#21B3DE', 'LineWidth', 1.5)
    plot([halfMax.StepIMn + halfMax.StepISd, halfMax.StepIMn + halfMax.StepISd], [yGraphHalf - graphCon, yGraphHalf + graphCon], ...
        'Color', '#21B3DE', 'LineWidth', 1.5)
    strHalf = ['Current at half max = ', num2str(halfMax.StepIMn, '%1.1f'), ' ± ', num2str(halfMax.StepISd, '%1.1f') ' pA'];
    text(0.02, 0.86, strHalf, 'Color', '#21B3DE', 'FontSize', 14,  'Units', 'Normalized')

    title('Spike Count vs Injected Current', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([min(PRT.IStepVals) max(PRT.IStepVals)])
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    xlabel('Injected Current (pA)', 'FontSize', 16);  
    ylabel('Spike Count', 'FontSize', 16);

%% Displays spike interval vs injected current (pA)
t3 = nexttile;
    errorbar(PRT.IStepVals, step.SpikeIntRatioMn, step.SpikeIntRatioSd, 'ko-', 'LineWidth', 1.5);
    title('Interval Ratio vs Injected Current', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([min(PRT.IStepVals) max(PRT.IStepVals)])
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    xlabel('Injected Current (pA)', 'FontSize', 16);
    ylabel('Spike Interval Ratio', 'FontSize', 16);

%% Displays first and second spike latency vs injected current (pA)
t4 = nexttile;
    errorbar(PRT.IStepVals, step.SpikeLatencyMn, step.SpikeLatencySd, 'ko-', 'LineWidth', 1.5);
    hold on
    yline(0, 'r')
    title('Spike Latency vs Injected Current', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([min(PRT.IStepVals) max(PRT.IStepVals)])
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    xlabel('Injected Current (pA)', 'FontSize', 16);
    ylabel('First Spike Latency (ms)', 'FontSize', 16);

%% Displays first height vs injected current (pA)
t5 = nexttile;
    errorbar(PRT.IStepVals, step.SpikePeakMn, step.SpikePeakSd, 'ko-', 'LineWidth', 1.5)
    title('Spike Peak vs Injected Current', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([min(PRT.IStepVals) max(PRT.IStepVals)])
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    xlabel('Injected Current (pA)', 'FontSize', 16);
    ylabel('First Spike Peak (mV)', 'FontSize', 16);

%% Displays first spike width vs injected current (pA)
t6 = nexttile;
    errorbar(PRT.IStepVals, step.SpikeWidthMn, step.SpikeWidthSd, 'ko-', 'LineWidth', 1.5)
    title('Spike Width vs Injected Current', 'FontSize', 16, 'FontWeight', 'Normal')
    xlim([min(PRT.IStepVals) max(PRT.IStepVals)])
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    xlabel('Injected Current (pA)', 'FontSize', 16);
    ylabel('First Spike Width (ms)', 'FontSize', 16);

saveas(gcf, strcat(graphName," Spikes.png"))
