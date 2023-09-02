function CCIV_GraphParams(VC, VR, Si, yLimitType, graphType, sheetType)

%% Graphs passive parameters (resistance, capacitance, and resting potential) at all time points
% Danny Lasky, 8/23

%% Create group vectors for basic Amy comparisons
if graphType == "All" || graphType == "Amy"
    Box.PreVC =  [ones(VC.Amy_WT.Count, 1); 2*ones(VC.Amy_TR.Count, 1)];
    Box.PostVC = [ones(VC.Amy_WT.Count, 1); 2*ones(VC.Amy_TR.Count, 1)];
    Box.PostVR = [ones(VR.Amy_WT.Count, 1); 2*ones(VR.Amy_TR.Count, 1)];
    Box.Post60 = [ones(Si.Amy_WT.Count, 1); 2*ones(Si.Amy_TR.Count, 1)];
    
    Box.PreVC_VR =  [VC.Amy_WT.Pre_VR; VC.Amy_TR.Pre_VR];
    Box.PostVC_VR = [VC.Amy_WT.Post_VR; VC.Amy_TR.Post_VR];
    Box.PostVR_VR = [VR.Amy_WT.Post_VR; VR.Amy_TR.Post_VR];
    Box.Post60_VR = [Si.Amy_WT.Post_VR; Si.Amy_TR.Post_VR];
    
    Box.PreVC_CM =  [VC.Amy_WT.Pre_CM; VC.Amy_TR.Pre_CM];
    Box.PostVC_CM = [VC.Amy_WT.Post_CM; VC.Amy_TR.Post_CM];
    Box.PostVR_CM = [VR.Amy_WT.Post_CM; VR.Amy_TR.Post_CM];
    Box.Post60_CM = [Si.Amy_WT.Post_CM; Si.Amy_TR.Post_CM];
    
    Box.PreVC_RM =  [VC.Amy_WT.Pre_RM; VC.Amy_TR.Pre_RM];
    Box.PostVC_RM = [VC.Amy_WT.Post_RM; VC.Amy_TR.Post_RM];
    Box.PostVR_RM = [VR.Amy_WT.Post_RM; VR.Amy_TR.Post_RM];
    Box.Post60_RM = [Si.Amy_WT.Post_RM; Si.Amy_TR.Post_RM];
    
    Box.PreVC_RS =  [VC.Amy_WT.Pre_RS; VC.Amy_TR.Pre_RS];
    Box.PostVC_RS = [VC.Amy_WT.Post_RS; VC.Amy_TR.Post_RS];
    Box.PostVR_RS = [VR.Amy_WT.Post_RS; VR.Amy_TR.Post_RS];
    Box.Post60_RS = [Si.Amy_WT.Post_RS; Si.Amy_TR.Post_RS];

%% Graph basic Amy comparisons
    figCount = 4;
    tileCount = 4;
    figSize = [0.5 0.5 8 9];
    figTitles = ["Resting Potential Amy", "Membrane Capacitance Amy", "Membrane Resistance Amy", "Series Resistance Amy"];
    figTitles = figTitles + " " + sheetType;
    tileTitles = ["Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", ...
        "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)"];
    graphX = {Box.PreVC, Box.PostVC, Box.PostVR, Box.Post60};
    graphY = {Box.PreVC_VR, Box.PreVC_CM, Box.PreVC_RM, Box.PreVC_RS ; Box.PostVC_VR, Box.PostVC_CM, Box.PostVC_RM, Box.PostVC_RS ; ...
        Box.PostVR_VR, Box.PostVR_CM, Box.PostVR_RM, Box.PostVR_RS ; Box.Post60_VR, Box.Post60_CM, Box.Post60_RM, Box.Post60_RS};
    xLimits = [0.5 2.5];
    xTicks = 1:2;
    yLimits = ([-100, 10 ; 0, 45 ; 0, 1400 ; 0, 20]);
    xLabels = {'Amy WT', 'Amy Tg'};
    yLabels = ["Resting Potential (mV)", "Membrane Capacitance (pF)" "Membrane Resistance (MΩ)" "Series Resistance (MΩ)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for basic Tau comparisons
if graphType == "All" || graphType == "Tau"
    Box.PreVC =  [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_TR.Count, 1)];
    Box.PostVC = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_TR.Count, 1)];
    Box.PostVR = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_TR.Count, 1)];
    Box.Post60 = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_TR.Count, 1)];
    
    Box.PreVC_VR =  [VC.Tau_WT.Pre_VR; VC.Tau_TR.Pre_VR];
    Box.PostVC_VR = [VC.Tau_WT.Post_VR; VC.Tau_TR.Post_VR];
    Box.PostVR_VR = [VR.Tau_WT.Post_VR; VR.Tau_TR.Post_VR];
    Box.Post60_VR = [Si.Tau_WT.Post_VR; Si.Tau_TR.Post_VR];
    
    Box.PreVC_CM =  [VC.Tau_WT.Pre_CM; VC.Tau_TR.Pre_CM];
    Box.PostVC_CM = [VC.Tau_WT.Post_CM; VC.Tau_TR.Post_CM];
    Box.PostVR_CM = [VR.Tau_WT.Post_CM; VR.Tau_TR.Post_CM];
    Box.Post60_CM = [Si.Tau_WT.Post_CM; Si.Tau_TR.Post_CM];
    
    Box.PreVC_RM =  [VC.Tau_WT.Pre_RM; VC.Tau_TR.Pre_RM];
    Box.PostVC_RM = [VC.Tau_WT.Post_RM; VC.Tau_TR.Post_RM];
    Box.PostVR_RM = [VR.Tau_WT.Post_RM; VR.Tau_TR.Post_RM];
    Box.Post60_RM = [Si.Tau_WT.Post_RM; Si.Tau_TR.Post_RM];
    
    Box.PreVC_RS =  [VC.Tau_WT.Pre_RS; VC.Tau_TR.Pre_RS];
    Box.PostVC_RS = [VC.Tau_WT.Post_RS; VC.Tau_TR.Post_RS];
    Box.PostVR_RS = [VR.Tau_WT.Post_RS; VR.Tau_TR.Post_RS];
    Box.Post60_RS = [Si.Tau_WT.Post_RS; Si.Tau_TR.Post_RS];

%% Graph basic Tau comparisons
    figCount = 4;
    tileCount = 4;
    figSize = [0.5 0.5 8 9];
    figTitles = ["Resting Potential Tau Groups", "Membrane Capacitance Tau Groups", "Membrane Resistance Tau Groups", "Series Resistance Tau Groups"];
    figTitles = figTitles + " " + sheetType;
    tileTitles = ["Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", ...
        "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)"];
    graphX = {Box.PreVC, Box.PostVC, Box.PostVR, Box.Post60};
    graphY = {Box.PreVC_VR, Box.PreVC_CM, Box.PreVC_RM, Box.PreVC_RS ; Box.PostVC_VR, Box.PostVC_CM, Box.PostVC_RM, Box.PostVC_RS ; ...
        Box.PostVR_VR, Box.PostVR_CM, Box.PostVR_RM, Box.PostVR_RS ; Box.Post60_VR, Box.Post60_CM, Box.Post60_RM, Box.Post60_RS};
    xLimits = [0.5 2.5];
    xTicks = 1:2;
    yLimits = ([-100, 10 ; 0, 45 ; 0, 1400 ; 0, 20]);
    xLabels = {'Tau WT', 'Tau Tg'};
    yLabels = ["Resting Potential (mV)", "Membrane Capacitance (pF)" "Membrane Resistance (MΩ)" "Series Resistance (MΩ)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for PBS/PFF comparisons
if graphType == "All" || graphType == "PFF"
    Box.PreVC =  [ones(VC.Tau_WT_PBS.Count, 1); 2*ones(VC.Tau_WT_PFF.Count, 1); 3*ones(VC.Tau_TR_PBS.Count, 1); 4*ones(VC.Tau_TR_PFF.Count, 1)];
    Box.PostVC = [ones(VC.Tau_WT_PBS.Count, 1); 2*ones(VC.Tau_WT_PFF.Count, 1); 3*ones(VC.Tau_TR_PBS.Count, 1); 4*ones(VC.Tau_TR_PFF.Count, 1)];
    Box.PostVR = [ones(VR.Tau_WT_PBS.Count, 1); 2*ones(VR.Tau_WT_PFF.Count, 1); 3*ones(VR.Tau_TR_PBS.Count, 1); 4*ones(VR.Tau_TR_PFF.Count, 1)];
    Box.Post60 = [ones(Si.Tau_WT_PBS.Count, 1); 2*ones(Si.Tau_WT_PFF.Count, 1); 3*ones(Si.Tau_TR_PBS.Count, 1); 4*ones(Si.Tau_TR_PFF.Count, 1)];
    
    Box.PreVC_VR =  [VC.Tau_WT_PBS.Pre_VR; VC.Tau_WT_PFF.Pre_VR; VC.Tau_TR_PBS.Pre_VR; VC.Tau_TR_PFF.Pre_VR];
    Box.PostVC_VR = [VC.Tau_WT_PBS.Post_VR; VC.Tau_WT_PFF.Post_VR; VC.Tau_TR_PBS.Post_VR; VC.Tau_TR_PFF.Post_VR];
    Box.PostVR_VR = [VR.Tau_WT_PBS.Post_VR; VR.Tau_WT_PFF.Post_VR; VR.Tau_TR_PBS.Post_VR; VR.Tau_TR_PFF.Post_VR];
    Box.Post60_VR = [Si.Tau_WT_PBS.Post_VR; Si.Tau_WT_PFF.Post_VR; Si.Tau_TR_PBS.Post_VR; Si.Tau_TR_PFF.Post_VR];
    
    Box.PreVC_CM =  [VC.Tau_WT_PBS.Pre_CM; VC.Tau_WT_PFF.Pre_CM; VC.Tau_TR_PBS.Pre_CM; VC.Tau_TR_PFF.Pre_CM];
    Box.PostVC_CM = [VC.Tau_WT_PBS.Post_CM; VC.Tau_WT_PFF.Post_CM; VC.Tau_TR_PBS.Post_CM; VC.Tau_TR_PFF.Post_CM];
    Box.PostVR_CM = [VR.Tau_WT_PBS.Post_CM; VR.Tau_WT_PFF.Post_CM; VR.Tau_TR_PBS.Post_CM; VR.Tau_TR_PFF.Post_CM];
    Box.Post60_CM = [Si.Tau_WT_PBS.Post_CM; Si.Tau_WT_PFF.Post_CM; Si.Tau_TR_PBS.Post_CM; Si.Tau_TR_PFF.Post_CM];
    
    Box.PreVC_RM =  [VC.Tau_WT_PBS.Pre_RM; VC.Tau_WT_PFF.Pre_RM; VC.Tau_TR_PBS.Pre_RM; VC.Tau_TR_PFF.Pre_RM];
    Box.PostVC_RM = [VC.Tau_WT_PBS.Post_RM; VC.Tau_WT_PFF.Post_RM; VC.Tau_TR_PBS.Post_RM; VC.Tau_TR_PFF.Post_RM];
    Box.PostVR_RM = [VR.Tau_WT_PBS.Post_RM; VR.Tau_WT_PFF.Post_RM; VR.Tau_TR_PBS.Post_RM; VR.Tau_TR_PFF.Post_RM];
    Box.Post60_RM = [Si.Tau_WT_PBS.Post_RM; Si.Tau_WT_PFF.Post_RM; Si.Tau_TR_PBS.Post_RM; Si.Tau_TR_PFF.Post_RM];

    Box.PreVC_RS =  [VC.Tau_WT_PBS.Pre_RS; VC.Tau_WT_PFF.Pre_RS; VC.Tau_TR_PBS.Pre_RS; VC.Tau_TR_PFF.Pre_RS];
    Box.PostVC_RS = [VC.Tau_WT_PBS.Post_RS; VC.Tau_WT_PFF.Post_RS; VC.Tau_TR_PBS.Post_RS; VC.Tau_TR_PFF.Post_RS];
    Box.PostVR_RS = [VR.Tau_WT_PBS.Post_RS; VR.Tau_WT_PFF.Post_RS; VR.Tau_TR_PBS.Post_RS; VR.Tau_TR_PFF.Post_RS];
    Box.Post60_RS = [Si.Tau_WT_PBS.Post_RS; Si.Tau_WT_PFF.Post_RS; Si.Tau_TR_PBS.Post_RS; Si.Tau_TR_PFF.Post_RS];

%% Graph PFF/PBS Tau comparisons
    figCount = 4;
    tileCount = 4;
    figSize = [0.5 0.5 10 9];
    figTitles = ["Resting Potential Tau PBS and PFF", "Membrane Capacitance Tau PBS and PFF", "Membrane Resistance Tau PBS and PFF", ...
        "Series Resistance Tau PBS and PFF"];
    figTitles = figTitles + " " + sheetType;
    tileTitles = ["Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", ...
        "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)"];
    graphX = {Box.PreVC, Box.PostVC, Box.PostVR, Box.Post60};
    graphY = {Box.PreVC_VR, Box.PreVC_CM, Box.PreVC_RM, Box.PreVC_RS ; Box.PostVC_VR, Box.PostVC_CM, Box.PostVC_RM, Box.PostVC_RS ; ...
        Box.PostVR_VR, Box.PostVR_CM, Box.PostVR_RM, Box.PostVR_RS ; Box.Post60_VR, Box.Post60_CM, Box.Post60_RM, Box.Post60_RS};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    yLimits = ([-100, 10 ; 0, 45 ; 0, 1400 ; 0, 20]);
    xLabels = {'Tau WT PBS', 'Tau WT PFF', 'Tau Tg PBS', 'Tau Tg PFF'};
    yLabels = ["Resting Potential (mV)", "Membrane Capacitance (pF)" "Membrane Resistance (MΩ)" "Series Resistance (MΩ)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for AdipoRon comparisons
if graphType == "All" || graphType == "AdipoRon"
    Box.PreVC =  [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_A.Count, 1); 3*ones(VC.Tau_TR.Count, 1); 4*ones(VC.Tau_TR_A.Count, 1)];
    Box.PostVC = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_A.Count, 1); 3*ones(VC.Tau_TR.Count, 1); 4*ones(VC.Tau_TR_A.Count, 1)];
    Box.PostVR = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_WT_A.Count, 1); 3*ones(VR.Tau_TR.Count, 1); 4*ones(VR.Tau_TR_A.Count, 1)];
    Box.Post60 = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_WT_A.Count, 1); 3*ones(Si.Tau_TR.Count, 1); 4*ones(Si.Tau_TR_A.Count, 1)];
    
    Box.PreVC_VR =  [VC.Tau_WT.Pre_VR; VC.Tau_WT_A.Pre_VR; VC.Tau_TR.Pre_VR; VC.Tau_TR_A.Pre_VR];
    Box.PostVC_VR = [VC.Tau_WT.Post_VR; VC.Tau_WT_A.Post_VR; VC.Tau_TR.Post_VR; VC.Tau_TR_A.Post_VR];
    Box.PostVR_VR = [VR.Tau_WT.Post_VR; VC.Tau_WT_A.Post_VR; VR.Tau_TR.Post_VR; VR.Tau_TR_A.Post_VR];
    Box.Post60_VR = [Si.Tau_WT.Post_VR; VC.Tau_WT_A.Post_VR; Si.Tau_TR.Post_VR; Si.Tau_TR_A.Post_VR];
    
    Box.PreVC_CM =  [VC.Tau_WT.Pre_CM; VC.Tau_WT_A.Pre_CM; VC.Tau_TR.Pre_CM; VC.Tau_TR_A.Pre_CM];
    Box.PostVC_CM = [VC.Tau_WT.Post_CM; VC.Tau_WT_A.Post_CM; VC.Tau_TR.Post_CM; VC.Tau_TR_A.Post_CM];
    Box.PostVR_CM = [VR.Tau_WT.Post_CM; VR.Tau_WT_A.Post_CM; VR.Tau_TR.Post_CM; VR.Tau_TR_A.Post_CM];
    Box.Post60_CM = [Si.Tau_WT.Post_CM; Si.Tau_WT_A.Post_CM; Si.Tau_TR.Post_CM; Si.Tau_TR_A.Post_CM];
    
    Box.PreVC_RM =  [VC.Tau_WT.Pre_RM; VC.Tau_WT_A.Pre_RM; VC.Tau_TR.Pre_RM; VC.Tau_TR_A.Pre_RM];
    Box.PostVC_RM = [VC.Tau_WT.Post_RM; VC.Tau_WT_A.Post_RM; VC.Tau_TR.Post_RM; VC.Tau_TR_A.Post_RM];
    Box.PostVR_RM = [VR.Tau_WT.Post_RM; VR.Tau_WT_A.Post_RM; VR.Tau_TR.Post_RM; VR.Tau_TR_A.Post_RM];
    Box.Post60_RM = [Si.Tau_WT.Post_RM; Si.Tau_WT_A.Post_RM; Si.Tau_TR.Post_RM; Si.Tau_TR_A.Post_RM];
    
    Box.PreVC_RS =  [VC.Tau_WT.Pre_RS; VC.Tau_WT_A.Pre_RS; VC.Tau_TR.Pre_RS; VC.Tau_TR_A.Pre_RS];
    Box.PostVC_RS = [VC.Tau_WT.Post_RS; VC.Tau_WT_A.Post_RS; VC.Tau_TR.Post_RS; VC.Tau_TR_A.Post_RS];
    Box.PostVR_RS = [VR.Tau_WT.Post_RS; VR.Tau_WT_A.Post_RS; VR.Tau_TR.Post_RS; VR.Tau_TR_A.Post_RS];
    Box.Post60_RS = [Si.Tau_WT.Post_RS; Si.Tau_WT_A.Post_RS; Si.Tau_TR.Post_RS; Si.Tau_TR_A.Post_RS];

%% Graph AdipoRon Tau comparisons
    figCount = 4;
    tileCount = 4;
    figSize = [0.5 0.5 8 7];
    figTitles = ["Resting Potential AdipoRon Groups", "Membrane Capacitance AdipoRon Groups", "Membrane Resistance AdipoRon Groups", ...
        "Series Resistance AdipoRon Groups"];
    figTitles = figTitles + " " + sheetType;
    tileTitles = ["Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", ...
        "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)"];
    graphX = {Box.PreVC, Box.PostVC, Box.PostVR, Box.Post60};
    graphY = {Box.PreVC_VR, Box.PreVC_CM, Box.PreVC_RM, Box.PreVC_RS ; Box.PostVC_VR, Box.PostVC_CM, Box.PostVC_RM, Box.PostVC_RS ; ...
        Box.PostVR_VR, Box.PostVR_CM, Box.PostVR_RM, Box.PostVR_RS ; Box.Post60_VR, Box.Post60_CM, Box.Post60_RM, Box.Post60_RS};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    yLimits = ([-100, 10 ; 0, 45 ; 0, 1400 ; 0, 20]);
    xLabels = {'Tau WT', 'Tau WT AR', 'Tau Tg', 'Tau Tg AR'};
    yLabels = ["Resting Potential (mV)", "Membrane Capacitance (pF)" "Membrane Resistance (MΩ)" "Series Resistance (MΩ)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for AdipoRon and DMSO comparisons
if graphType == "All" || graphType == "DMSO"
    Box.PreVC =  [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_D.Count, 1); 3*ones(VC.Tau_WT_A.Count, 1); 4*ones(VC.Tau_TR.Count, 1); 5*ones(VC.Tau_TR_D.Count, 1); 6*ones(VC.Tau_TR_A.Count, 1)]; 
    Box.PostVC = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_D.Count, 1); 3*ones(VC.Tau_WT_A.Count, 1); 4*ones(VC.Tau_TR.Count, 1); 5*ones(VC.Tau_TR_D.Count, 1); 6*ones(VC.Tau_TR_A.Count, 1)]; 
    Box.PostVR = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_D.Count, 1); 3*ones(VC.Tau_WT_A.Count, 1); 4*ones(VC.Tau_TR.Count, 1); 5*ones(VC.Tau_TR_D.Count, 1); 6*ones(VC.Tau_TR_A.Count, 1)]; 
    Box.Post60 = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_D.Count, 1); 3*ones(VC.Tau_WT_A.Count, 1); 4*ones(VC.Tau_TR.Count, 1); 5*ones(VC.Tau_TR_D.Count, 1); 6*ones(VC.Tau_TR_A.Count, 1)]; 
    
    Box.PreVC_VR =  [VC.Tau_WT.Pre_VR; VC.Tau_WT_D.Pre_VR; VC.Tau_WT_A.Pre_VR; VC.Tau_TR.Pre_VR; VC.Tau_TR_D.Pre_VR; VC.Tau_TR_A.Pre_VR];
    Box.PostVC_VR = [VC.Tau_WT.Post_VR; VC.Tau_WT_D.Post_VR; VC.Tau_WT_A.Post_VR; VC.Tau_TR.Post_VR; VC.Tau_TR_D.Post_VR; VC.Tau_TR_A.Post_VR];
    Box.PostVR_VR = [VR.Tau_WT.Post_VR; VR.Tau_WT_D.Post_VR; VR.Tau_WT_A.Post_VR; VR.Tau_TR.Post_VR; VR.Tau_TR_D.Post_VR; VR.Tau_TR_A.Post_VR];
    Box.Post60_VR = [Si.Tau_WT.Post_VR; Si.Tau_WT_D.Post_VR; Si.Tau_WT_A.Post_VR; Si.Tau_TR.Post_VR; Si.Tau_TR_D.Post_VR; Si.Tau_TR_A.Post_VR];
    
    Box.PreVC_CM =  [VC.Tau_WT.Pre_CM; VC.Tau_WT_D.Pre_CM; VC.Tau_WT_A.Pre_CM; VC.Tau_TR.Pre_CM; VC.Tau_TR_D.Pre_CM; VC.Tau_TR_A.Pre_CM];
    Box.PostVC_CM = [VC.Tau_WT.Post_CM; VC.Tau_WT_D.Post_CM; VC.Tau_WT_A.Post_CM; VC.Tau_TR.Post_CM; VC.Tau_TR_D.Post_CM; VC.Tau_TR_A.Post_CM];
    Box.PostVR_CM = [VR.Tau_WT.Post_CM; VR.Tau_WT_D.Post_CM; VR.Tau_WT_A.Post_CM; VR.Tau_TR.Post_CM; VR.Tau_TR_D.Post_CM; VR.Tau_TR_A.Post_CM];
    Box.Post60_CM = [Si.Tau_WT.Post_CM; Si.Tau_WT_D.Post_CM; Si.Tau_WT_A.Post_CM; Si.Tau_TR.Post_CM; Si.Tau_TR_D.Post_CM; Si.Tau_TR_A.Post_CM];
    
    Box.PreVC_RM =  [VC.Tau_WT.Pre_RM; VC.Tau_WT_D.Pre_RM; VC.Tau_WT_A.Pre_RM; VC.Tau_TR.Pre_RM; VC.Tau_TR_D.Pre_RM; VC.Tau_TR_A.Pre_RM];
    Box.PostVC_RM = [VC.Tau_WT.Post_RM; VC.Tau_WT_D.Post_RM; VC.Tau_WT_A.Post_RM; VC.Tau_TR.Post_RM; VC.Tau_TR_D.Post_RM; VC.Tau_TR_A.Post_RM];
    Box.PostVR_RM = [VR.Tau_WT.Post_RM; VR.Tau_WT_D.Post_RM; VR.Tau_WT_A.Post_RM; VR.Tau_TR.Post_RM; VR.Tau_TR_D.Post_RM; VR.Tau_TR_A.Post_RM];
    Box.Post60_RM = [Si.Tau_WT.Post_RM; Si.Tau_WT_D.Post_RM; Si.Tau_WT_A.Post_RM; Si.Tau_TR.Post_RM; Si.Tau_TR_D.Post_RM; Si.Tau_TR_A.Post_RM];
    
    Box.PreVC_RS =  [VC.Tau_WT.Pre_RS; VC.Tau_WT_D.Pre_RS; VC.Tau_WT_A.Pre_RS; VC.Tau_TR.Pre_RS; VC.Tau_TR_D.Pre_RS; VC.Tau_TR_A.Pre_RS];
    Box.PostVC_RS = [VC.Tau_WT.Post_RS; VC.Tau_WT_D.Post_RS; VC.Tau_WT_A.Post_RS; VC.Tau_TR.Post_RS; VC.Tau_TR_D.Post_RS; VC.Tau_TR_A.Post_RS];
    Box.PostVR_RS = [VR.Tau_WT.Post_RS; VR.Tau_WT_D.Post_RS; VR.Tau_WT_A.Post_RS; VR.Tau_TR.Post_RS; VR.Tau_TR_D.Post_RS; VR.Tau_TR_A.Post_RS];
    Box.Post60_RS = [Si.Tau_WT.Post_RS; Si.Tau_WT_D.Post_RS; Si.Tau_WT_A.Post_RS; Si.Tau_TR.Post_RS; Si.Tau_TR_D.Post_RS; Si.Tau_TR_A.Post_RS];

%% Graph AdipoRon Tau comparisons
    figCount = 4;
    tileCount = 4;
    figSize = [0.5 0.5 12 9];
    figTitles = ["Resting Potential AdipoRon and DMSO", "Membrane Capacitance AdipoRon and DMSO", "Membrane Resistance AdipoRon and DMSO", ...
        "Series Resistance AdipoRon and DMSO"];
    figTitles = figTitles + " " + sheetType;
    tileTitles = ["Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", ...
        "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)", "Initial", "Post-VC", "Post-CC (at VR)", "Post-CC (-60 mV)"];
    graphX = {Box.PreVC, Box.PostVC, Box.PostVR, Box.Post60};
    graphY = {Box.PreVC_VR, Box.PreVC_CM, Box.PreVC_RM, Box.PreVC_RS ; Box.PostVC_VR, Box.PostVC_CM, Box.PostVC_RM, Box.PostVC_RS ; ...
        Box.PostVR_VR, Box.PostVR_CM, Box.PostVR_RM, Box.PostVR_RS ; Box.Post60_VR, Box.Post60_CM, Box.Post60_RM, Box.Post60_RS};
    xLimits = [0.5 6.5];
    xTicks = 1:6;
    yLimits = ([-100, 10 ; 0, 45 ; 0, 1400 ; 0, 20]);
    xLabels = {'Tau WT', 'Tau WT DMSO', 'Tau WT AR', 'Tau Tg', 'Tau Tg DMSO', 'Tau Tg AR'};
    yLabels = ["Resting Potential (mV)", "Membrane Capacitance (pF)" "Membrane Resistance (MΩ)" "Series Resistance (MΩ)"];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end