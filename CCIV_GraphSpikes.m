function Box = CCIV_GraphSpikes(VR, Si, graphType, cellType)

%% Create box plots for rheobase parameters, spiking properties, and voltage sag curve fit variables
% Danny Lasky, 8/23

Box = [];
yLimitType = "Off";

%% Create group vectors for amyloid graphing
Box.VR = [ones(VR.Amy_WT.Count, 1); 2*ones(VR.Amy_TR.Count, 1)];
Box.Si = [ones(Si.Amy_WT.Count, 1); 2*ones(Si.Amy_TR.Count, 1)];

Box.VR_RheoI        = [VR.Amy_WT.Rheo.I; VR.Amy_TR.Rheo.I];
Box.VR_RheoN        = [VR.Amy_WT.Rheo.N; VR.Amy_TR.Rheo.N];
Box.VR_RheoLatency  = [VR.Amy_WT.Rheo.Latency; VR.Amy_TR.Rheo.Latency];
Box.VR_RheoThresh   = [VR.Amy_WT.Rheo.Thresh; VR.Amy_TR.Rheo.Thresh];
Box.VR_RheoAmp      = [VR.Amy_WT.Rheo.Amp; VR.Amy_TR.Rheo.Amp];
Box.VR_RheoPeak     = [VR.Amy_WT.Rheo.Peak; VR.Amy_TR.Rheo.Peak];
Box.VR_RheoWidth    = [VR.Amy_WT.Rheo.Width; VR.Amy_TR.Rheo.Width];
Box.VR_RheoFWHA     = [VR.Amy_WT.Rheo.FWHA; VR.Amy_TR.Rheo.FWHA];

Box.Si_RheoI        = [Si.Amy_WT.Rheo.I; Si.Amy_TR.Rheo.I];
Box.Si_RheoN        = [Si.Amy_WT.Rheo.N; Si.Amy_TR.Rheo.N];
Box.Si_RheoLatency  = [Si.Amy_WT.Rheo.Latency; Si.Amy_TR.Rheo.Latency];
Box.Si_RheoThresh   = [Si.Amy_WT.Rheo.Thresh; Si.Amy_TR.Rheo.Thresh];
Box.Si_RheoAmp      = [Si.Amy_WT.Rheo.Amp; Si.Amy_TR.Rheo.Amp];
Box.Si_RheoPeak     = [Si.Amy_WT.Rheo.Peak; Si.Amy_TR.Rheo.Peak];
Box.Si_RheoWidth    = [Si.Amy_WT.Rheo.Width; Si.Amy_TR.Rheo.Width];
Box.Si_RheoFWHA     = [Si.Amy_WT.Rheo.FWHA; Si.Amy_TR.Rheo.FWHA];

    %% Graph Amy comparisons
if graphType == "All" || graphType == "Amy Rheo"
    figCount = 2;
    tileCount = 8;
    figSize = [0.5 1.5 15 9];
    figTitles = ["Amy Rheobase at VR", "Amy Rheobase at -60 mV"];
    figTitles = figTitles + " " + cellType;
    tileTitles = ["Current Injected", "Spike Count", "Spike Latency", "Spike Threshold", "Spike Amplitude", "Spike Peak", "Spike Width", "Spike FWHA", ...
        "Current Injected", "Spike Count", "Spike Latency", "Spike Threshold", "Spike Amplitude", "Spike Peak", "Spike Width", "Spike FWHA"];
    graphX = {Box.VR, Box.VR, Box.VR, Box.VR, Box.Si, Box.Si, Box.Si, Box.Si};
    graphY = {Box.VR_RheoI, Box.Si_RheoI; Box.VR_RheoN, Box.Si_RheoN; Box.VR_RheoLatency, Box.Si_RheoLatency; Box.VR_RheoThresh, Box.Si_RheoThresh; ...
        Box.VR_RheoAmp, Box.Si_RheoAmp; Box.VR_RheoPeak, Box.Si_RheoPeak; Box.VR_RheoWidth, Box.Si_RheoWidth; Box.VR_RheoFWHA, Box.Si_RheoFWHA};
    xLimits = [0.5 2.5];
    xTicks = 1:2;
    yLimits = [];
    xLabels = {'Amy WT','Amy Tg'};
    yLabels = ["Current Injected (pA)", "Spike Count", "Spike Latency (ms)", "Spike Threshold (mV)", "Spike Amplitude (mV)", "Spike Peak (mV)", "Spike Width (ms)", "Spike FWHA (ms)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for AdipoRon graphing
Box.VR = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_WT_A.Count, 1); 3*ones(VR.Tau_TR.Count, 1); 4*ones(VR.Tau_TR_A.Count, 1)];
Box.Si = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_WT_A.Count, 1); 3*ones(Si.Tau_TR.Count, 1); 4*ones(Si.Tau_TR_A.Count, 1)];

Box.VR_RheoI        = [VR.Tau_WT.Rheo.I; VR.Tau_WT_A.Rheo.I; VR.Tau_TR.Rheo.I; VR.Tau_TR_A.Rheo.I];
Box.VR_RheoN        = [VR.Tau_WT.Rheo.N; VR.Tau_WT_A.Rheo.N; VR.Tau_TR.Rheo.N; VR.Tau_TR_A.Rheo.N];
Box.VR_RheoLatency  = [VR.Tau_WT.Rheo.Latency; VR.Tau_WT_A.Rheo.Latency; VR.Tau_TR.Rheo.Latency; VR.Tau_TR_A.Rheo.Latency];
Box.VR_RheoThresh   = [VR.Tau_WT.Rheo.Thresh; VR.Tau_WT_A.Rheo.Thresh; VR.Tau_TR.Rheo.Thresh; VR.Tau_TR_A.Rheo.Thresh];
Box.VR_RheoAmp      = [VR.Tau_WT.Rheo.Amp; VR.Tau_WT_A.Rheo.Amp; VR.Tau_TR.Rheo.Amp; VR.Tau_TR_A.Rheo.Amp];
Box.VR_RheoPeak     = [VR.Tau_WT.Rheo.Peak; VR.Tau_WT_A.Rheo.Peak; VR.Tau_TR.Rheo.Peak; VR.Tau_TR_A.Rheo.Peak];
Box.VR_RheoWidth    = [VR.Tau_WT.Rheo.Width; VR.Tau_WT_A.Rheo.Width; VR.Tau_TR.Rheo.Width; VR.Tau_TR_A.Rheo.Width];
Box.VR_RheoFWHA     = [VR.Tau_WT.Rheo.FWHA; VR.Tau_WT_A.Rheo.FWHA; VR.Tau_TR.Rheo.FWHA; VR.Tau_TR_A.Rheo.FWHA];

Box.Si_RheoI        = [Si.Tau_WT.Rheo.I; Si.Tau_WT_A.Rheo.I; Si.Tau_TR.Rheo.I; Si.Tau_TR_A.Rheo.I];
Box.Si_RheoN        = [Si.Tau_WT.Rheo.N; Si.Tau_WT_A.Rheo.N; Si.Tau_TR.Rheo.N; Si.Tau_TR_A.Rheo.N];
Box.Si_RheoLatency  = [Si.Tau_WT.Rheo.Latency; Si.Tau_WT_A.Rheo.Latency; Si.Tau_TR.Rheo.Latency; Si.Tau_TR_A.Rheo.Latency];
Box.Si_RheoThresh   = [Si.Tau_WT.Rheo.Thresh; Si.Tau_WT_A.Rheo.Thresh; Si.Tau_TR.Rheo.Thresh; Si.Tau_TR_A.Rheo.Thresh];
Box.Si_RheoAmp      = [Si.Tau_WT.Rheo.Amp; Si.Tau_WT_A.Rheo.Amp; Si.Tau_TR.Rheo.Amp; Si.Tau_TR_A.Rheo.Amp];
Box.Si_RheoPeak     = [Si.Tau_WT.Rheo.Peak; Si.Tau_WT_A.Rheo.Peak; Si.Tau_TR.Rheo.Peak; Si.Tau_TR_A.Rheo.Peak];
Box.Si_RheoWidth    = [Si.Tau_WT.Rheo.Width; Si.Tau_WT_A.Rheo.Width; Si.Tau_TR.Rheo.Width; Si.Tau_TR_A.Rheo.Width];
Box.Si_RheoFWHA     = [Si.Tau_WT.Rheo.FWHA; Si.Tau_WT_A.Rheo.FWHA; Si.Tau_TR.Rheo.FWHA; Si.Tau_TR_A.Rheo.FWHA];

Box.VR_Out_RheoI        = padcat(VR.Tau_WT.Rheo.I, VR.Tau_WT_A.Rheo.I, VR.Tau_TR.Rheo.I, VR.Tau_TR_A.Rheo.I);
Box.VR_Out_RheoN        = padcat(VR.Tau_WT.Rheo.N, VR.Tau_WT_A.Rheo.N, VR.Tau_TR.Rheo.N, VR.Tau_TR_A.Rheo.N);
Box.VR_Out_RheoLatency  = padcat(VR.Tau_WT.Rheo.Latency, VR.Tau_WT_A.Rheo.Latency, VR.Tau_TR.Rheo.Latency, VR.Tau_TR_A.Rheo.Latency);
Box.VR_Out_RheoThresh   = padcat(VR.Tau_WT.Rheo.Thresh, VR.Tau_WT_A.Rheo.Thresh, VR.Tau_TR.Rheo.Thresh, VR.Tau_TR_A.Rheo.Thresh);
Box.VR_Out_RheoAmp      = padcat(VR.Tau_WT.Rheo.Amp, VR.Tau_WT_A.Rheo.Amp, VR.Tau_TR.Rheo.Amp, VR.Tau_TR_A.Rheo.Amp);
Box.VR_Out_RheoPeak     = padcat(VR.Tau_WT.Rheo.Peak, VR.Tau_WT_A.Rheo.Peak, VR.Tau_TR.Rheo.Peak, VR.Tau_TR_A.Rheo.Peak);
Box.VR_Out_RheoWidth    = padcat(VR.Tau_WT.Rheo.Width, VR.Tau_WT_A.Rheo.Width, VR.Tau_TR.Rheo.Width, VR.Tau_TR_A.Rheo.Width);
Box.VR_Out_RheoFWHA     = padcat(VR.Tau_WT.Rheo.FWHA, VR.Tau_WT_A.Rheo.FWHA, VR.Tau_TR.Rheo.FWHA, VR.Tau_TR_A.Rheo.FWHA);

Box.Si_Out_RheoI        = padcat(Si.Tau_WT.Rheo.I, Si.Tau_WT_A.Rheo.I, Si.Tau_TR.Rheo.I, Si.Tau_TR_A.Rheo.I);
Box.Si_Out_RheoN        = padcat(Si.Tau_WT.Rheo.N, Si.Tau_WT_A.Rheo.N, Si.Tau_TR.Rheo.N, Si.Tau_TR_A.Rheo.N);
Box.Si_Out_RheoLatency  = padcat(Si.Tau_WT.Rheo.Latency, Si.Tau_WT_A.Rheo.Latency, Si.Tau_TR.Rheo.Latency, Si.Tau_TR_A.Rheo.Latency);
Box.Si_Out_RheoThresh   = padcat(Si.Tau_WT.Rheo.Thresh, Si.Tau_WT_A.Rheo.Thresh, Si.Tau_TR.Rheo.Thresh, Si.Tau_TR_A.Rheo.Thresh);
Box.Si_Out_RheoAmp      = padcat(Si.Tau_WT.Rheo.Amp, Si.Tau_WT_A.Rheo.Amp, Si.Tau_TR.Rheo.Amp, Si.Tau_TR_A.Rheo.Amp);
Box.Si_Out_RheoPeak     = padcat(Si.Tau_WT.Rheo.Peak, Si.Tau_WT_A.Rheo.Peak, Si.Tau_TR.Rheo.Peak, Si.Tau_TR_A.Rheo.Peak);
Box.Si_Out_RheoWidth    = padcat(Si.Tau_WT.Rheo.Width, Si.Tau_WT_A.Rheo.Width, Si.Tau_TR.Rheo.Width, Si.Tau_TR_A.Rheo.Width);
Box.Si_Out_RheoFWHA     = padcat(Si.Tau_WT.Rheo.FWHA, Si.Tau_WT_A.Rheo.FWHA, Si.Tau_TR.Rheo.FWHA, Si.Tau_TR_A.Rheo.FWHA);

    %% Graph Amy comparisons
if graphType == "All" || graphType == "AdipoRon Rheo"
    figCount = 2;
    tileCount = 8;
    figSize = [0.5 1.5 18 9];
    figTitles = ["AdipoRon Rheobase at VR", "AdipoRon Rheobase at -60 mV"];
    figTitles = figTitles + " " + cellType;
    tileTitles = ["Current Injected", "Spike Count", "Spike Latency", "Spike Threshold", "Spike Amplitude", "Spike Peak", "Spike Width", "Spike FWHA", ...
        "Current Injected", "Spike Count", "Spike Latency", "Spike Threshold", "Spike Amplitude", "Spike Peak", "Spike Width", "Spike FWHA"];
    graphX = {Box.VR, Box.VR, Box.VR, Box.VR, Box.Si, Box.Si, Box.Si, Box.Si};
    graphY = {Box.VR_RheoI, Box.Si_RheoI; Box.VR_RheoN, Box.Si_RheoN; Box.VR_RheoLatency, Box.Si_RheoLatency; Box.VR_RheoThresh, Box.Si_RheoThresh; ...
        Box.VR_RheoAmp, Box.Si_RheoAmp; Box.VR_RheoPeak, Box.Si_RheoPeak; Box.VR_RheoWidth, Box.Si_RheoWidth; Box.VR_RheoFWHA, Box.Si_RheoFWHA};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    yLimits = [];
    xLabels = {'Tau WT', 'Tau WT AR', 'Tau Tg', 'Tau Tg AR'};
    yLabels = ["Current Injected (pA)", "Spike Count", "Spike Latency (ms)", "Spike Threshold (mV)", "Spike Amplitude (mV)", "Spike Peak (mV)", "Spike Width (ms)", "Spike FWHA (ms)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for voltage sag curve fit
Box.VR_Amy = [ones(VR.Amy_WT.Count, 1); 2*ones(VR.Amy_TR.Count, 1)];
Box.Si_Amy = [ones(Si.Amy_WT.Count, 1); 2*ones(Si.Amy_TR.Count, 1)];

Box.VR_Tau = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_WT_A.Count, 1); 3*ones(VR.Tau_TR.Count, 1); 4*ones(VR.Tau_TR_A.Count, 1)];
Box.Si_Tau = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_WT_A.Count, 1); 3*ones(Si.Tau_TR.Count, 1); 4*ones(Si.Tau_TR_A.Count, 1)];

Box.VR_Amy_FastAmp        = [VR.Amy_WT.SagFastAmp; VR.Amy_TR.SagFastAmp];
Box.Si_Amy_FastAmp        = [Si.Amy_WT.SagFastAmp; Si.Amy_TR.SagFastAmp];
Box.VR_Tau_FastAmp        = [VR.Tau_WT.SagFastAmp; VR.Tau_WT_A.SagFastAmp; VR.Tau_TR.SagFastAmp; VR.Tau_TR_A.SagFastAmp];
Box.Si_Tau_FastAmp        = [Si.Tau_WT.SagFastAmp; Si.Tau_WT_A.SagFastAmp; Si.Tau_TR.SagFastAmp; Si.Tau_TR_A.SagFastAmp];
    
    %% Graph Amy comparisons
if graphType == "All" || graphType == "Curve Fit"
    figCount = 1;
    tileCount = 4;
    figSize = [0.5 1.5 15 9];
    figTitles = "Voltage Sag Fast Amplitude";
    figTitles = figTitles + " " + cellType;
    tileTitles = ["Amy at VR", "Tau at VR", "Amy at -60 mV", "Tau at -60 mV"];
    graphX = {Box.VR_Amy, Box.VR_Tau, Box.Si_Amy, Box.Si_Tau};
    graphY = {Box.VR_Amy_FastAmp; Box.VR_Tau_FastAmp; Box.Si_Amy_FastAmp; Box.Si_Tau_FastAmp};
    tileSize = {[1 1], [1 2], [1 1], [1 2]};
    xLimits = {[0.5 2.5], [0.5 4.5], [0.5 2.5], [0.5 4.5]};
    xTicks = {1:2, 1:4, 1:2, 1:4};
    xLabels = {'Amy WT','Amy Tg'};
    yLabels = "Fast Amplitude (mV)";
    
    %%
    for n = 1:figCount
        figure('Units', 'inch', 'Position', figSize)
        layout = tiledlayout(2,3);
        title(layout, figTitles, 'FontSize', 24)
        for m = 1:tileCount
            tile = nexttile(tileSize{m});
            boxchart(graphX{m}, graphY{m, n}, 'MarkerStyle', 'None', 'BoxFaceColor', '#21B3DE', 'LineWidth', 2)
            hold on
            swarmchart(graphX{m}, graphY{m, n}, [], [0.9137 0.1686 0.0863], 'LineWidth', 1.02)
            xlim(xLimits{m});
            if yLimitType == 1 && m > 6
                ylim([yLimits(1), yLimits(2)])        %  ylim([yLimits(n, 1), yLimits(n, 2)])
            end
            tile.XAxis.FontSize = 14;
            tile.YAxis.FontSize = 14;
            title(tileTitles((n-1)*tileCount + m), 'FontSize', 16, 'FontWeight', 'Normal')
            xticks(xTicks{m})
            xticklabels(xLabels)
            ylabel(yLabels, 'FontSize', 14)
        end
        saveas(gcf, figTitles(n) + ".png")
    end
end

%% Create group vectors for Amy special parameters
if graphType == "All" || graphType == "Amy Special"
    Box.VR = [ones(VR.Amy_WT.Count, 1); 2*ones(VR.Amy_TR.Count, 1)];
    Box.Si = [ones(Si.Amy_WT.Count, 1); 2*ones(Si.Amy_TR.Count, 1)];

    Box.VR_MaxN         = [VR.Amy_WT.MaxN; VR.Amy_TR.MaxN];
    Box.Si_MaxN         = [Si.Amy_WT.MaxN; Si.Amy_TR.MaxN];

    Box.VR_IHalfMax     = [VR.Amy_WT.IHalfMax; VR.Amy_TR.IHalfMax];
    Box.Si_IHalfMax     = [Si.Amy_WT.IHalfMax; Si.Amy_TR.IHalfMax];

    Box.VR_CountRatio   = [VR.Amy_WT.CountRatio; VR.Amy_TR.CountRatio];
    Box.Si_CountRatio   = [Si.Amy_WT.CountRatio; Si.Amy_TR.CountRatio];

    Box.VR_SagFastAmp   = [VR.Amy_WT.SagFastAmp; VR.Amy_TR.SagFastAmp];
    Box.Si_SagFastAmp   = [Si.Amy_WT.SagFastAmp; Si.Amy_TR.SagFastAmp];

    Box.VR_SagFastTau   = [VR.Amy_WT.SagFastTau; VR.Amy_TR.SagFastTau];
    Box.Si_SagFastTau   = [Si.Amy_WT.SagFastTau; Si.Amy_TR.SagFastTau];

    %% Graph Amy special comparisons
    figCount = 5;
    tileCount = 2;
    figSize = [0.5 1.5 10 7];
    figTitles = ["Max Spike Count", "Current at Half Max Spike Count", "Spike Count Ratio", "Voltage Sag Fit Amplitude", "Voltage Sag Fit Tau"];
    tileTitles = ["Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV", ...
        "Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV"];
    graphX = {Box.VR, Box.Si};
    graphY = {Box.VR_MaxN, Box.VR_IHalfMax, Box.VR_CountRatio, Box.VR_SagFastAmp, Box.VR_SagFastTau; ...
        Box.Si_MaxN, Box.Si_IHalfMax, Box.Si_CountRatio, Box.Si_SagFastAmp, Box.Si_SagFastTau};
    xLimits = [0.5 2.5];
    xTicks = 1:2;
    yLimits = [];
    xLabels = {'Amy WT','Amy Tg'};
    yLabels = ["Max Spike Count", "Current at Half Max Spike Count (pA)" "Spike Count Ratio" "Voltage Sag Fit Amplitude (mV)" "Voltage Sag Fit Tau (1/ms)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for Tau special parameters
if graphType == "All" || graphType == "AdipoRon Special"
    Box.VR = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_WT_A.Count, 1); 3*ones(VR.Tau_TR.Count, 1); 4*ones(VR.Tau_TR_A.Count, 1)];
    Box.Si = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_WT_A.Count, 1); 3*ones(Si.Tau_TR.Count, 1); 4*ones(Si.Tau_TR_A.Count, 1)];

    Box.VR_MaxN         = [VR.Tau_WT.MaxN; VR.Tau_WT_A.MaxN; VR.Tau_TR.MaxN; VR.Tau_TR_A.MaxN];
    Box.Si_MaxN         = [Si.Tau_WT.MaxN; Si.Tau_WT_A.MaxN; Si.Tau_TR.MaxN; Si.Tau_TR_A.MaxN];

    Box.VR_IHalfMax     = [VR.Tau_WT.IHalfMax; VR.Tau_WT_A.IHalfMax; VR.Tau_TR.IHalfMax; VR.Tau_TR_A.IHalfMax];
    Box.Si_IHalfMax     = [Si.Tau_WT.IHalfMax; Si.Tau_WT_A.IHalfMax; Si.Tau_TR.IHalfMax; Si.Tau_TR_A.IHalfMax];

    Box.VR_CountRatio   = [VR.Tau_WT.CountRatio; VR.Tau_WT_A.CountRatio; VR.Tau_TR.CountRatio; VR.Tau_TR_A.CountRatio];
    Box.Si_CountRatio   = [Si.Tau_WT.CountRatio; Si.Tau_WT_A.CountRatio; Si.Tau_TR.CountRatio; Si.Tau_TR_A.CountRatio];

    Box.VR_SagFastAmp   = [VR.Tau_WT.SagFastAmp; VR.Tau_WT_A.SagFastAmp; VR.Tau_TR.SagFastAmp; VR.Tau_TR_A.SagFastAmp];
    Box.Si_SagFastAmp   = [Si.Tau_WT.SagFastAmp; Si.Tau_WT_A.SagFastAmp; Si.Tau_TR.SagFastAmp; Si.Tau_TR_A.SagFastAmp];

    Box.VR_SagFastTau   = [VR.Tau_WT.SagFastTau; VR.Tau_WT_A.SagFastTau; VR.Tau_TR.SagFastTau; VR.Tau_TR_A.SagFastTau];
    Box.Si_SagFastTau   = [Si.Tau_WT.SagFastTau; Si.Tau_WT_A.SagFastTau; Si.Tau_TR.SagFastTau; Si.Tau_TR_A.SagFastTau];

    %% Graph Tau special comparisons
    figCount = 5;
    tileCount = 2;
    figSize = [0.5 1.5 13 7];
    figTitles = ["Max Spike Count", "Current at Half Max Spike Count", "Spike Count Ratio", "Voltage Sag Fit Amplitude", "Voltage Sag Fit Tau"];
    tileTitles = ["Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV", ...
        "Holding at VR", "Holding at -60 mV", "Holding at VR", "Holding at -60 mV"];
    graphX = {Box.VR, Box.Si};
    graphY = {Box.VR_MaxN, Box.VR_IHalfMax, Box.VR_CountRatio, Box.VR_SagFastAmp, Box.VR_SagFastTau; ...
        Box.Si_MaxN, Box.Si_IHalfMax, Box.Si_CountRatio, Box.Si_SagFastAmp, Box.Si_SagFastTau};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    yLimits = [];
    xLabels = {'Tau WT','Tau WT AR','Tau Tg','Tau Tg AR'};
    yLabels = ["Max Spike Count", "Current at Half Max Spike Count (pA)" "Spike Count Ratio" "Voltage Sag Fit Amplitude (mV)" "Voltage Sag Fit Tau (1/ms)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end
