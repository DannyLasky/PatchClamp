function Box = CCIV_CombineTimes(VC, VR, Si, yLimitType, graphType, sheetType)

%% Graphs passive parameters (resistance, capacitance, and resting potential) averaged across time points
% Danny Lasky, 2023

Box = [];

%% Create group vectors for basic Amy comparisons
if graphType == "All" || graphType == "Amy"
    mean_AmyWT_RM = (VC.Amy_WT.Pre_RM + VC.Amy_WT.Post_RM + VR.Amy_WT.Post_RM + Si.Amy_WT.Post_RM)/4;
    mean_AmyTR_RM = (VC.Amy_TR.Pre_RM + VC.Amy_TR.Post_RM + VR.Amy_TR.Post_RM + Si.Amy_TR.Post_RM)/4;

    mean_AmyWT_CM = (VC.Amy_WT.Pre_CM + VC.Amy_WT.Post_CM + VR.Amy_WT.Post_CM + Si.Amy_WT.Post_CM)/4;
    mean_AmyTR_CM = (VC.Amy_TR.Pre_CM + VC.Amy_TR.Post_CM + VR.Amy_TR.Post_CM + Si.Amy_TR.Post_CM)/4;

    mean_AmyWT_VR = (VC.Amy_WT.Pre_VR + VC.Amy_WT.Post_VR + VR.Amy_WT.Post_VR + Si.Amy_WT.Post_VR)/4;
    mean_AmyTR_VR = (VC.Amy_TR.Pre_VR + VC.Amy_TR.Post_VR + VR.Amy_TR.Post_VR + Si.Amy_TR.Post_VR)/4;

    Box.Amy = [ones(VC.Amy_WT.Count, 1); 2*ones(VC.Amy_TR.Count, 1)];

    Box.Amy_RM = [mean_AmyWT_RM; mean_AmyTR_RM];
    Box.Amy_CM = [mean_AmyWT_CM; mean_AmyTR_CM];
    Box.Amy_VR = [mean_AmyWT_VR; mean_AmyTR_VR];

    Box.Amy_RM_Out = padcat(mean_AmyWT_RM, mean_AmyTR_RM);
    Box.Amy_CM_Out = padcat(mean_AmyWT_CM, mean_AmyTR_CM);
    Box.Amy_VR_Out = padcat(mean_AmyWT_VR, mean_AmyTR_VR);

%% Graph basic Amy comparisons
    figCount = 1;
    tileCount = 3;
    figSize = [0.5 0.5 1.455 6.5];
    figTitles = "Amyloid Passive Properties";
    tileTitles = ["Resistance", "Capacitance", "Resting Potential"];
    graphX = {Box.Amy; Box.Amy; Box.Amy};
    graphY = {Box.Amy_RM; Box.Amy_CM; Box.Amy_VR};
    xLimits = [0.5 2.5];
    xTicks = 1:2;
    if yLimitType == "Off"
        yLimits = 0;
    elseif yLimitType == "Tile"
        yLimits = ([0, 1500 ; 0, 40 ; -85, 0]);
    end
    xLabels = {'WT', 'Tg'};
    yLabels = ["Resistance (MΩ)", "Capacitance (pF)", "Resting Potential (mV)"];

    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for Tau AdipoRon comparisons
if graphType == "All" || graphType == "AdipoRon"
    mean_TauWT_RM = (VC.Tau_WT.Pre_RM + VC.Tau_WT.Post_RM + VR.Tau_WT.Post_RM + Si.Tau_WT.Post_RM)/4;
    mean_TauWT_A_RM = (VC.Tau_WT_A.Pre_RM + VC.Tau_WT_A.Post_RM + VR.Tau_WT_A.Post_RM + Si.Tau_WT_A.Post_RM)/4;
    mean_TauTR_RM = (VC.Tau_TR.Pre_RM + VC.Tau_TR.Post_RM + VR.Tau_TR.Post_RM + Si.Tau_TR.Post_RM)/4;
    mean_TauTR_A_RM = (VC.Tau_TR_A.Pre_RM + VC.Tau_TR_A.Post_RM + VR.Tau_TR_A.Post_RM + Si.Tau_TR_A.Post_RM)/4;
    
    mean_TauWT_CM = (VC.Tau_WT.Pre_CM + VC.Tau_WT.Post_CM + VR.Tau_WT.Post_CM + Si.Tau_WT.Post_CM)/4;
    mean_TauWT_A_CM = (VC.Tau_WT_A.Pre_CM + VC.Tau_WT_A.Post_CM + VR.Tau_WT_A.Post_CM + Si.Tau_WT_A.Post_CM)/4;
    mean_TauTR_CM = (VC.Tau_TR.Pre_CM + VC.Tau_TR.Post_CM + VR.Tau_TR.Post_CM + Si.Tau_TR.Post_CM)/4;
    mean_TauTR_A_CM = (VC.Tau_TR_A.Pre_CM + VC.Tau_TR_A.Post_CM + VR.Tau_TR_A.Post_CM + Si.Tau_TR_A.Post_CM)/4;
    
    mean_TauWT_VR = (VC.Tau_WT.Pre_VR + VC.Tau_WT.Post_VR + VR.Tau_WT.Post_VR + Si.Tau_WT.Post_VR)/4;
    mean_TauWT_A_VR = (VC.Tau_WT_A.Pre_VR + VC.Tau_WT_A.Post_VR + VR.Tau_WT_A.Post_VR + Si.Tau_WT_A.Post_VR)/4;
    mean_TauTR_VR = (VC.Tau_TR.Pre_VR + VC.Tau_TR.Post_VR + VR.Tau_TR.Post_VR + Si.Tau_TR.Post_VR)/4;
    mean_TauTR_A_VR = (VC.Tau_TR_A.Pre_VR + VC.Tau_TR_A.Post_VR + VR.Tau_TR_A.Post_VR + Si.Tau_TR_A.Post_VR)/4;

    Box.Tau = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_A.Count, 1); 3*ones(VC.Tau_TR.Count, 1); 4*ones(VC.Tau_TR_A.Count, 1)];

    Box.Tau_RM = [mean_TauWT_RM; mean_TauWT_A_RM; mean_TauTR_RM; mean_TauTR_A_RM];
    Box.Tau_CM = [mean_TauWT_CM; mean_TauWT_A_CM; mean_TauTR_CM; mean_TauTR_A_CM];
    Box.Tau_VR = [mean_TauWT_VR; mean_TauWT_A_VR; mean_TauTR_VR; mean_TauTR_A_VR];

    Box.Tau_RM_Out = padcat(mean_TauWT_RM, mean_TauWT_A_RM, mean_TauTR_RM, mean_TauTR_A_RM);
    Box.Tau_CM_Out = padcat(mean_TauWT_CM, mean_TauWT_A_CM, mean_TauTR_CM, mean_TauTR_A_CM);
    Box.Tau_VR_Out = padcat(mean_TauWT_VR, mean_TauWT_A_VR, mean_TauTR_VR, mean_TauTR_A_VR);

%% Graph Tau AdipoRon comparisons (with capacitance)
    figCount = 1;
    tileCount = 3;
    figSize = [0.5 0.5 2.35 6.5];        % Previous dimensions [0.5 0.5 4 5];
    figTitles = "Tau Passive Properties";
    tileTitles = ["Resistance", "Capacitance", "Resting Potential"];
    graphX = {Box.Tau; Box.Tau; Box.Tau};
    graphY = {Box.Tau_RM; Box.Tau_CM; Box.Tau_VR};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    if yLimitType == "Off"
        yLimits = 0;
    elseif yLimitType == "Tile"
        yLimits = ([0, 1500 ; 0, 40 ; -85, 0]);
    end
    xLabels = {'WT', 'WT+AR', 'Tg', 'Tg+AR'};
    yLabels = ["Resistance (MΩ)", "Capacitance (pF)", "Resting Potential (mV)"];
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end

%% Create group vectors for Tau AdipoRon + DMSO comparisons
if graphType == "All" || graphType == "DMSO"
    mean_TauWT_RM   = (VC.Tau_WT.Pre_RM + VC.Tau_WT.Post_RM + VR.Tau_WT.Post_RM + Si.Tau_WT.Post_RM)/4;
    mean_TauWT_D_RM = (VC.Tau_WT_D.Pre_RM + VC.Tau_WT_D.Post_RM + VR.Tau_WT_D.Post_RM + Si.Tau_WT_D.Post_RM)/4;
    mean_TauWT_A_RM = (VC.Tau_WT_A.Pre_RM + VC.Tau_WT_A.Post_RM + VR.Tau_WT_A.Post_RM + Si.Tau_WT_A.Post_RM)/4;
    mean_TauTR_RM   = (VC.Tau_TR.Pre_RM + VC.Tau_TR.Post_RM + VR.Tau_TR.Post_RM + Si.Tau_TR.Post_RM)/4;
    mean_TauTR_D_RM = (VC.Tau_TR_D.Pre_RM + VC.Tau_TR_D.Post_RM + VR.Tau_TR_D.Post_RM + Si.Tau_TR_D.Post_RM)/4;
    mean_TauTR_A_RM = (VC.Tau_TR_A.Pre_RM + VC.Tau_TR_A.Post_RM + VR.Tau_TR_A.Post_RM + Si.Tau_TR_A.Post_RM)/4;
    
    mean_TauWT_CM = (VC.Tau_WT.Pre_CM + VC.Tau_WT.Post_CM + VR.Tau_WT.Post_CM + Si.Tau_WT.Post_CM)/4;
    mean_TauWT_D_CM = (VC.Tau_WT_D.Pre_CM + VC.Tau_WT_D.Post_CM + VR.Tau_WT_D.Post_CM + Si.Tau_WT_D.Post_CM)/4;
    mean_TauWT_A_CM = (VC.Tau_WT_A.Pre_CM + VC.Tau_WT_A.Post_CM + VR.Tau_WT_A.Post_CM + Si.Tau_WT_A.Post_CM)/4;
    mean_TauTR_CM = (VC.Tau_TR.Pre_CM + VC.Tau_TR.Post_CM + VR.Tau_TR.Post_CM + Si.Tau_TR.Post_CM)/4;
    mean_TauTR_D_CM = (VC.Tau_TR_D.Pre_CM + VC.Tau_TR_D.Post_CM + VR.Tau_TR_D.Post_CM + Si.Tau_TR_D.Post_CM)/4;
    mean_TauTR_A_CM = (VC.Tau_TR_A.Pre_CM + VC.Tau_TR_A.Post_CM + VR.Tau_TR_A.Post_CM + Si.Tau_TR_A.Post_CM)/4;
    
    mean_TauWT_VR = (VC.Tau_WT.Pre_VR + VC.Tau_WT.Post_VR + VR.Tau_WT.Post_VR + Si.Tau_WT.Post_VR)/4;
    mean_TauWT_D_VR = (VC.Tau_WT_D.Pre_VR + VC.Tau_WT_D.Post_VR + VR.Tau_WT_D.Post_VR + Si.Tau_WT_D.Post_VR)/4;
    mean_TauWT_A_VR = (VC.Tau_WT_A.Pre_VR + VC.Tau_WT_A.Post_VR + VR.Tau_WT_A.Post_VR + Si.Tau_WT_A.Post_VR)/4;
    mean_TauTR_VR = (VC.Tau_TR.Pre_VR + VC.Tau_TR.Post_VR + VR.Tau_TR.Post_VR + Si.Tau_TR.Post_VR)/4;
    mean_TauTR_D_VR = (VC.Tau_TR_D.Pre_VR + VC.Tau_TR_D.Post_VR + VR.Tau_TR_D.Post_VR + Si.Tau_TR_D.Post_VR)/4;
    mean_TauTR_A_VR = (VC.Tau_TR_A.Pre_VR + VC.Tau_TR_A.Post_VR + VR.Tau_TR_A.Post_VR + Si.Tau_TR_A.Post_VR)/4;

    Box.Tau = [ones(VC.Tau_WT.Count, 1); 2*ones(VC.Tau_WT_D.Count, 1) ; 3*ones(VC.Tau_WT_A.Count, 1); 4*ones(VC.Tau_TR.Count, 1); 5*ones(VC.Tau_TR_D.Count, 1); 6*ones(VC.Tau_TR_A.Count, 1)];

    Box.Tau_RM = [mean_TauWT_RM; mean_TauWT_D_RM; mean_TauWT_A_RM; mean_TauTR_RM; mean_TauTR_D_RM; mean_TauTR_A_RM];
    Box.Tau_CM = [mean_TauWT_CM; mean_TauWT_D_CM; mean_TauWT_A_CM; mean_TauTR_CM; mean_TauTR_D_CM; mean_TauTR_A_CM];
    Box.Tau_VR = [mean_TauWT_VR; mean_TauWT_D_VR; mean_TauWT_A_VR; mean_TauTR_VR; mean_TauTR_D_VR; mean_TauTR_A_VR];

    Box.Tau_RM_Out = padcat(mean_TauWT_RM, mean_TauWT_D_RM, mean_TauWT_A_RM, mean_TauTR_RM, mean_TauTR_D_RM, mean_TauTR_A_RM);
    Box.Tau_CM_Out = padcat(mean_TauWT_CM, mean_TauWT_D_CM, mean_TauWT_A_CM, mean_TauTR_CM, mean_TauTR_D_CM, mean_TauTR_A_CM);
    Box.Tau_VR_Out = padcat(mean_TauWT_VR, mean_TauWT_D_VR, mean_TauWT_A_VR, mean_TauTR_VR, mean_TauTR_D_VR, mean_TauTR_A_VR);

%% Graph Tau AdipoRon + DMSO comparisons
    figCount = 1;
    tileCount = 3;
    figSize = [0.5 0.5 11 10];
    figTitles = "DMSO Properties";
    tileTitles = ["Resistance", "Capacitance", "Resting Potential"];
    graphX = {Box.Tau; Box.Tau; Box.Tau};
    graphY = {Box.Tau_RM; Box.Tau_CM; Box.Tau_VR};
    xLimits = [0.2 6.8];
    xTicks = 1:6;
    if yLimitType == "Off"
        yLimits = 0;
    elseif yLimitType == "Tile"
        yLimits = ([0, 1500 ; 0, 40 ; -85, 0]);
    end
    xLabels = {'Tau WT', 'Tau WT DM', 'Tau WT AR', 'Tau Tg', 'Tau Tg DM', 'Tau Tg AR'};
    yLabels = ["Resistance (MΩ)", "Capacitance (pF)", "Resting Potential (mV)"];

    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)
end