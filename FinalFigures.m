function [VC, VR, Si] = FinalFigures(VC, VR, Si, nSteps, ISteps, graphType)

%% Figure 5 and 6 involving the IV curves were pieced together later on in Illustrator
% See VC_IV GroupAnalysis for the production of those graphs
% Danny Lasky, 8/23

%% Figure 1 - Methods prep
if graphType == "1"
    ExcelRows = [199, 601, 379, 481];                        % WT: 199, WT+AR: 601, Tg: 379, Tg+AR: 481
    mainDir = 'P:\AndersonLabCultures';
    tableName = 'Namefile 04-27-23.xlsx';
    tablePath = fullfile(mainDir, tableName);
    protocol = '/Users/Shared/AndersonLabCultures/protocols & configs/CA3-CCIV.prt.axgx';

    [~, ~, ~, ~, dataFile, ~, ~, ~] = ReadExcel(ExcelRows, tablePath, protocol);
    DATA.data = cell(4,1);

    for fileNum = 1:length(ExcelRows)
        dataFile{fileNum} = strrep(dataFile{fileNum},'/Users/Shared/','P:\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/','\');
        
        currentFile = dataFile{fileNum};
        dataFileFull = read_axograph(currentFile);
        DATA.time = dataFileFull.columnData{1} * 1e3;                   % Convert from s to ms
        DATA.data{fileNum} = cat(2, dataFileFull.columnData{2:end}) * 1e3;       % Convert from V to mV
    end

    % Only display every 10th point to reduce number of points on graph for illustrator
    DATA.time = DATA.time(1:10:end);
    
    DATA.data{1} = DATA.data{1}(1:10:end, :);
    DATA.data{2} = DATA.data{2}(1:10:end, :);
    DATA.data{3} = DATA.data{3}(1:10:end, :);
    DATA.data{4} = DATA.data{4}(1:10:end, :);

    %% Figure 1 - Methods graphing
    displaySweeps = [1, 5, 14, 22, 30];
    figure('Units', 'inch', 'Pos', [1.5 1.5 5 3])
    tiledlayout(2, 3, 'TileSpacing', 'compact');
    set(gcf,'color','w');

    nexttile;
        plot(DATA.time, DATA.data{1}(:, displaySweeps(1)), 'Color', [0 0 0])
        hold on
        plot(DATA.time, DATA.data{1}(:, displaySweeps(2)), 'Color', [.2 .2 .2])
        plot(DATA.time, DATA.data{1}(:, displaySweeps(3)), 'Color', [.4 .4 .4])
        plot(DATA.time, DATA.data{1}(:, displaySweeps(4)), 'Color', [.6 .6 .6])
        plot(DATA.time, DATA.data{1}(:, displaySweeps(5)), 'Color', [.8 .8 .8])
        title('WT', 'FontSize', 10,  'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([0 700])
        ylim([-100 60])
        box off
        axis off
        scalebars(gca, [500, 0.5], [14.2857, 12.5], {'ms', 'mV'}, 'Arial', 8, 1, {'%2.0f', '%2.0f'})
    nexttile;
        plot(DATA.time, DATA.data{2}(:, displaySweeps(1)), 'Color', [.3 0 .3])
        hold on
        plot(DATA.time, DATA.data{2}(:, displaySweeps(2)), 'Color', [.475 0 .475])
        plot(DATA.time, DATA.data{2}(:, displaySweeps(3)), 'Color', [.65 0 .65])
        plot(DATA.time, DATA.data{2}(:, displaySweeps(4)), 'Color', [.825 0 .825])
        plot(DATA.time, DATA.data{2}(:, displaySweeps(5)), 'Color', [1 0 1])
        title('WT+AR', 'FontSize', 10,  'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([0 700])
        ylim([-100 60])
        box off
        axis off
    nexttile
        plot(DATA.time, DATA.data{1}(:, displaySweeps(3)), 'Color', [.4 .4 .4])
        title("Response at Rheobase", 'FontSize', 10,  'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([0 700])
        ylim([-100 60])
        box off
        axis off
    nexttile;
        plot(DATA.time, DATA.data{3}(:, displaySweeps(1)), 'Color', [0 .3 .3])
        hold on
        plot(DATA.time, DATA.data{3}(:, displaySweeps(2)), 'Color', [0 .475 .475])
        plot(DATA.time, DATA.data{3}(:, displaySweeps(3)), 'Color', [0 .65 .65])
        plot(DATA.time, DATA.data{3}(:, displaySweeps(4)), 'Color', [0 .825 .825])
        plot(DATA.time, DATA.data{3}(:, displaySweeps(5)), 'Color', [0 1 1])
        title('Tg', 'FontSize', 10,  'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([0 700])
        ylim([-100 60])
        box off
        axis off
    nexttile;
        plot(DATA.time, DATA.data{4}(:, displaySweeps(1)), 'Color', [.3 .3 0])
        hold on
        plot(DATA.time, DATA.data{4}(:, displaySweeps(2)), 'Color', [.475 .475 0])
        plot(DATA.time, DATA.data{4}(:, displaySweeps(3)), 'Color', [.65 .65 0])
        plot(DATA.time, DATA.data{4}(:, displaySweeps(4)), 'Color', [.825 .825 0])
        plot(DATA.time, DATA.data{4}(:, displaySweeps(5)), 'Color', [1 1 0])
        title('Tg+AR', 'FontSize', 10,  'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([0 700])
        ylim([-100 60])
        box off
        axis off
    nexttile
        yyaxis right
            plot(rheoRange, rheoVals, 'k', 'LineWidth', 1)
            hold on
            plot([rheo.StartTime(1), rheo.EndTime(1)], [rheo.Thresh(1), rheo.Thresh(1)], 'r-')
            plot([rheo.PeakTime(1), rheo.PeakTime(1)], [rheo.Thresh(1), rheo.Peak(1)], 'r-');
            plot([rheo.HalfAmpStartTime(1), rheo.HalfAmpEndTime(1)], [rheo.HalfAmpY(1), rheo.HalfAmpY(1)], 'r-');
            scatter(rheo.StartTime(1), rheo.Thresh(1), 15, 'ro', 'filled')
            scatter(rheo.EndTime(1), rheo.Thresh(1), 15, 'ro', 'filled')
            scatter(rheo.PeakTime(1), rheo.Peak(1), 15, 'ro', 'filled')
            scatter(rheo.HalfAmpStartTime(1), rheo.HalfAmpY(1), 15, 'ro', 'filled')
            scatter(rheo.HalfAmpEndTime(1), rheo.HalfAmpY(1), 15, 'ro', 'filled')
            scalebars(gca, [295.5, 30], [13.215, 16.66667], {'ms', 'mV'}, 'Arial', 8, 1, {'%2.0f', '%2.0f'});
        yyaxis left
            plot(rheoRange, secondDerivAll{rheo.Sweep(n)}(rheoIdx), 'Color', [.7 .7 .7])
            xlim([287 300])
        box off
        axis off
    exportgraphics(gcf, "EPhys Methods.pdf", 'Resolution', 300)
end

%% Figure 2 - Passive parameters prep
if graphType == "All" || graphType == "2"
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

    %% Figure 2 - Passive parameters graphing
    figCount = 1;
    tileCount = 3;
    figSize = [0.5 0.5 6.4 2];
    figTitles = "Tau Passive Properties";
    tileTitles = ["Resistance", "Capacitance", "Resting Potential"];
    graphX = {Box.Tau; Box.Tau; Box.Tau};
    graphY = {Box.Tau_RM; Box.Tau_CM; Box.Tau_VR};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    if yLimitOn == 0
        yLimits = 0;
    elseif yLimitOn == 1
        yLimits = ([0, 1300 ; 0, 40 ; -85, 0]);
    end
    xLabels = {'WT', 'WT+AR', 'Tg', 'Tg+AR'};
    yLabels = ["Resistance (MΩ)", "Capacitance (pF)", "Resting Potential (mV)"];
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitOn, xLabels, yLabels)
end

%% Figure 3 - Spike count prep
if graphType == "All" || graphType == "3"
    VR.Tau_WT.ByStep.N              = cell(nSteps,1);
    VR.Tau_WT.ByStep.NMn            = zeros(nSteps,1);
    VR.Tau_WT.ByStep.NSEM           = zeros(nSteps,1);
    VR.Tau_TR.ByStep.N              = cell(nSteps,1);
    VR.Tau_TR.ByStep.NMn            = zeros(nSteps,1);
    VR.Tau_TR.ByStep.NSEM           = zeros(nSteps,1);
    VR.Tau_WT_A.ByStep.N            = cell(nSteps,1);
    VR.Tau_WT_A.ByStep.NMn          = zeros(nSteps,1);
    VR.Tau_WT_A.ByStep.NSEM         = zeros(nSteps,1);
    VR.Tau_TR_A.ByStep.N            = cell(nSteps,1);
    VR.Tau_TR_A.ByStep.NMn          = zeros(nSteps,1);
    VR.Tau_TR_A.ByStep.NSEM         = zeros(nSteps,1);
    
    Si.Tau_WT.ByStep.N              = cell(nSteps,1);
    Si.Tau_WT.ByStep.NMn            = zeros(nSteps,1);
    Si.Tau_WT.ByStep.NSEM           = zeros(nSteps,1);
    Si.Tau_TR.ByStep.N              = cell(nSteps,1);
    Si.Tau_TR.ByStep.NMn            = zeros(nSteps,1);
    Si.Tau_TR.ByStep.NSEM           = zeros(nSteps,1);
    Si.Tau_WT_A.ByStep.N            = cell(nSteps,1);
    Si.Tau_WT_A.ByStep.NMn          = zeros(nSteps,1);
    Si.Tau_WT_A.ByStep.NSEM         = zeros(nSteps,1);
    Si.Tau_TR_A.ByStep.N            = cell(nSteps,1);
    Si.Tau_TR_A.ByStep.NMn          = zeros(nSteps,1);
    Si.Tau_TR_A.ByStep.NSEM         = zeros(nSteps,1);

    for n = 1:nSteps
        for m = 1:VR.Tau_WT.Count
            VR.Tau_WT.ByStep.N{n}(m)    = VR.Tau_WT.Steps.N{m}(n);
            Si.Tau_WT.ByStep.N{n}(m)    = Si.Tau_WT.Steps.N{m}(n);
        end
        for m = 1:VR.Tau_TR.Count
            VR.Tau_TR.ByStep.N{n}(m)    = VR.Tau_TR.Steps.N{m}(n);
            Si.Tau_TR.ByStep.N{n}(m)    = Si.Tau_TR.Steps.N{m}(n);
        end
        for m = 1:VR.Tau_WT_A.Count
            VR.Tau_WT_A.ByStep.N{n}(m)  = VR.Tau_WT_A.Steps.N{m}(n);
            Si.Tau_WT_A.ByStep.N{n}(m)  = Si.Tau_WT_A.Steps.N{m}(n);
        end
        for m = 1:VR.Tau_TR_A.Count  
            VR.Tau_TR_A.ByStep.N{n}(m)  = VR.Tau_TR_A.Steps.N{m}(n);
            Si.Tau_TR_A.ByStep.N{n}(m)  = Si.Tau_TR_A.Steps.N{m}(n);
        end
    end

    VR.Tau_WT.ByStep.NMn            = mean(cell2mat(VR.Tau_WT.ByStep.N), 2);
    VR.Tau_WT.ByStep.NSEM           = std(cell2mat(VR.Tau_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.N)), 2));
    VR.Tau_TR.ByStep.NMn            = mean(cell2mat(VR.Tau_TR.ByStep.N), 2);
    VR.Tau_TR.ByStep.NSEM           = std(cell2mat(VR.Tau_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.N)), 2));
    VR.Tau_WT_A.ByStep.NMn          = mean(cell2mat(VR.Tau_WT_A.ByStep.N), 2);
    VR.Tau_WT_A.ByStep.NSEM         = std(cell2mat(VR.Tau_WT_A.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.N)), 2));
    VR.Tau_TR_A.ByStep.NMn          = mean(cell2mat(VR.Tau_TR_A.ByStep.N), 2);
    VR.Tau_TR_A.ByStep.NSEM         = std(cell2mat(VR.Tau_TR_A.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.N)), 2));
    
    Si.Tau_WT.ByStep.NMn            = mean(cell2mat(Si.Tau_WT.ByStep.N), 2);
    Si.Tau_WT.ByStep.NSEM           = std(cell2mat(Si.Tau_WT.ByStep.N), [], 2) ./ sqrt(Si.Tau_WT.Count);
    Si.Tau_TR.ByStep.NMn            = mean(cell2mat(Si.Tau_TR.ByStep.N), 2);
    Si.Tau_TR.ByStep.NSEM           = std(cell2mat(Si.Tau_TR.ByStep.N), [], 2) ./ sqrt(Si.Tau_TR.Count);
    Si.Tau_WT_A.ByStep.NMn          = mean(cell2mat(Si.Tau_WT_A.ByStep.N), 2);
    Si.Tau_WT_A.ByStep.NSEM         = std(cell2mat(Si.Tau_WT_A.ByStep.N), [], 2) ./ sqrt(Si.Tau_WT_A.Count);
    Si.Tau_TR_A.ByStep.NMn          = mean(cell2mat(Si.Tau_TR_A.ByStep.N), 2);
    Si.Tau_TR_A.ByStep.NSEM         = std(cell2mat(Si.Tau_TR_A.ByStep.N), [], 2) ./ sqrt(Si.Tau_TR_A.Count);

    % Figure 3 - One spike prep
    VR.Tau_WT.OneSpike      = nan(nSteps,1);
    VR.Tau_TR.OneSpike      = nan(nSteps,1);
    VR.Tau_WT_A.OneSpike    = nan(nSteps,1);
    VR.Tau_TR_A.OneSpike    = nan(nSteps,1);
    Si.Tau_WT.OneSpike      = nan(nSteps,1);
    Si.Tau_TR.OneSpike      = nan(nSteps,1);
    Si.Tau_WT_A.OneSpike    = nan(nSteps,1);
    Si.Tau_TR_A.OneSpike    = nan(nSteps,1);
    
    [VR.Tau_WT.OneSpikePer, VR.Tau_WT.OneSpikeN, VR.Tau_WT.OneSpikeArr]         = OneSpike(VR.Tau_WT.Steps.N, VR.Tau_WT.Count);
    [VR.Tau_TR.OneSpikePer, VR.Tau_TR.OneSpikeN, VR.Tau_TR.OneSpikeArr]         = OneSpike(VR.Tau_TR.Steps.N, VR.Tau_TR.Count);
    [VR.Tau_WT_A.OneSpikePer, VR.Tau_WT_A.OneSpikeN, VR.Tau_WT_A.OneSpikeArr]   = OneSpike(VR.Tau_WT_A.Steps.N, VR.Tau_WT_A.Count);
    [VR.Tau_TR_A.OneSpikePer, VR.Tau_TR_A.OneSpikeN, VR.Tau_TR_A.OneSpikeArr]   = OneSpike(VR.Tau_TR_A.Steps.N, VR.Tau_TR_A.Count);
    [Si.Tau_WT.OneSpikePer, Si.Tau_WT.OneSpikeN, Si.Tau_WT.OneSpikeArr]         = OneSpike(Si.Tau_WT.Steps.N, Si.Tau_WT.Count);
    [Si.Tau_TR.OneSpikePer, Si.Tau_TR.OneSpikeN, Si.Tau_TR.OneSpikeArr]         = OneSpike(Si.Tau_TR.Steps.N, Si.Tau_TR.Count);
    [Si.Tau_WT_A.OneSpikePer, Si.Tau_WT_A.OneSpikeN, Si.Tau_WT_A.OneSpikeArr]   = OneSpike(Si.Tau_WT_A.Steps.N, Si.Tau_WT_A.Count);
    [Si.Tau_TR_A.OneSpikePer, Si.Tau_TR_A.OneSpikeN, Si.Tau_TR_A.OneSpikeArr]   = OneSpike(Si.Tau_TR_A.Steps.N, Si.Tau_TR_A.Count);

    % Figure 3 - One plus spike prep
    VR.Tau_WT.OnePlusSpike = nan(nSteps,1);
    VR.Tau_TR.OnePlusSpike = nan(nSteps,1);
    VR.Tau_WT_A.OnePlusSpike = nan(nSteps,1);
    VR.Tau_TR_A.OnePlusSpike = nan(nSteps,1);
    Si.Tau_WT.OnePlusSpike = nan(nSteps,1);
    Si.Tau_TR.OnePlusSpike = nan(nSteps,1);
    Si.Tau_WT_A.OnePlusSpike = nan(nSteps,1);
    Si.Tau_TR_A.OnePlusSpike = nan(nSteps,1);
    
    [VR.Tau_WT.OnePlusSpikePer, VR.Tau_WT.OnePlusSpikeN, VR.Tau_WT.OnePlusSpikeArr]         = OnePlusSpike(VR.Tau_WT.Steps.N, VR.Tau_WT.Count);
    [VR.Tau_TR.OnePlusSpikePer, VR.Tau_TR.OnePlusSpikeN, VR.Tau_TR.OnePlusSpikeArr]         = OnePlusSpike(VR.Tau_TR.Steps.N, VR.Tau_TR.Count);
    [VR.Tau_WT_A.OnePlusSpikePer, VR.Tau_WT_A.OnePlusSpikeN, VR.Tau_WT_A.OnePlusSpikeArr]   = OnePlusSpike(VR.Tau_WT_A.Steps.N, VR.Tau_WT_A.Count);
    [VR.Tau_TR_A.OnePlusSpikePer, VR.Tau_TR_A.OnePlusSpikeN, VR.Tau_TR_A.OnePlusSpikeArr]   = OnePlusSpike(VR.Tau_TR_A.Steps.N, VR.Tau_TR_A.Count);
    [Si.Tau_WT.OnePlusSpikePer, Si.Tau_WT.OnePlusSpikeN, Si.Tau_WT.OnePlusSpikeArr]         = OnePlusSpike(Si.Tau_WT.Steps.N, Si.Tau_WT.Count);
    [Si.Tau_TR.OnePlusSpikePer, Si.Tau_TR.OnePlusSpikeN, Si.Tau_TR.OnePlusSpikeArr]         = OnePlusSpike(Si.Tau_TR.Steps.N, Si.Tau_TR.Count);
    [Si.Tau_WT_A.OnePlusSpikePer, Si.Tau_WT_A.OnePlusSpikeN, Si.Tau_WT_A.OnePlusSpikeArr]   = OnePlusSpike(Si.Tau_WT_A.Steps.N, Si.Tau_WT_A.Count);
    [Si.Tau_TR_A.OnePlusSpikePer, Si.Tau_TR_A.OnePlusSpikeN, Si.Tau_TR_A.OnePlusSpikeArr]   = OnePlusSpike(Si.Tau_TR_A.Steps.N, Si.Tau_TR_A.Count);

    %% Figure 3 - Spike graphing
    figure('Units', 'inch', 'Position', [0.5 0.5 3.8 5.5])
    tiledlayout(3,2, 'TileSpacing', 'compact');

    t1 = nexttile;
        shadedErrorBar(ISteps, VR.Tau_WT.ByStep.NMn, VR.Tau_WT.ByStep.NSEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.NMn, VR.Tau_WT_A.ByStep.NSEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
        shadedErrorBar(ISteps, VR.Tau_TR.ByStep.NMn, VR.Tau_TR.ByStep.NSEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.NMn, VR.Tau_TR_A.ByStep.NSEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        ylabel('Spike Count', 'FontSize', 8, 'FontName', 'Arial')
        ylim([0 22])
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        title('At Resting Potential', 'FontSize', 10, 'FontWeight', 'Normal')
        leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [10 10];
    t2 = nexttile;
        shadedErrorBar(ISteps, Si.Tau_WT.ByStep.NMn, Si.Tau_WT.ByStep.NSEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.NMn, Si.Tau_WT_A.ByStep.NSEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
        shadedErrorBar(ISteps, Si.Tau_TR.ByStep.NMn, Si.Tau_TR.ByStep.NSEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.NMn, Si.Tau_TR_A.ByStep.NSEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        ylim([0 22])
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        title('Holding at −60 mV', 'FontSize', 10, 'FontWeight', 'Normal', 'FontName', 'Arial')
    t3 = nexttile;
        plot(ISteps, VR.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_WT_A.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        ylabel('One or More Spikes (%)')
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t4 = nexttile;
        plot(ISteps, Si.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_WT_A.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t5 = nexttile;
        plot(ISteps, VR.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_WT_A.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_TR.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        ylabel('Exactly One Spike (%)')
        xlabel('Injected Current (pA)')
        t5.XAxis.FontSize = 8;
        t5.YAxis.FontSize = 8;
        t5.XAxis.FontName = 'Arial';
        t5.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t6 = nexttile;
        plot(ISteps, Si.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_WT_A.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_TR.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        xlabel('Injected Current (pA)')
        t6.XAxis.FontSize = 8;
        t6.YAxis.FontSize = 8;
        t6.XAxis.FontName = 'Arial';
        t6.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    exportgraphics(gcf, "Figure 3.pdf", 'Resolution', 300)
end

%% Figure 4 - Rheobase prep
if graphType == "All" || graphType == "4"
    Box.VR = [ones(VR.Tau_WT.Count, 1); 2*ones(VR.Tau_WT_A.Count, 1); 3*ones(VR.Tau_TR.Count, 1); 4*ones(VR.Tau_TR_A.Count, 1)];
    Box.Si = [ones(Si.Tau_WT.Count, 1); 2*ones(Si.Tau_WT_A.Count, 1); 3*ones(Si.Tau_TR.Count, 1); 4*ones(Si.Tau_TR_A.Count, 1)];
    
    Box.VR_RheoLatency  = [VR.Tau_WT.Rheo.Latency; VR.Tau_WT_A.Rheo.Latency; VR.Tau_TR.Rheo.Latency; VR.Tau_TR_A.Rheo.Latency];
    Box.VR_RheoAmp      = [VR.Tau_WT.Rheo.Amp; VR.Tau_WT_A.Rheo.Amp; VR.Tau_TR.Rheo.Amp; VR.Tau_TR_A.Rheo.Amp];
    Box.VR_RheoFWHA     = [VR.Tau_WT.Rheo.FWHA; VR.Tau_WT_A.Rheo.FWHA; VR.Tau_TR.Rheo.FWHA; VR.Tau_TR_A.Rheo.FWHA];
    Box.Si_RheoLatency  = [Si.Tau_WT.Rheo.Latency; Si.Tau_WT_A.Rheo.Latency; Si.Tau_TR.Rheo.Latency; Si.Tau_TR_A.Rheo.Latency];
    Box.Si_RheoAmp      = [Si.Tau_WT.Rheo.Amp; Si.Tau_WT_A.Rheo.Amp; Si.Tau_TR.Rheo.Amp; Si.Tau_TR_A.Rheo.Amp];
    Box.Si_RheoFWHA     = [Si.Tau_WT.Rheo.FWHA; Si.Tau_WT_A.Rheo.FWHA; Si.Tau_TR.Rheo.FWHA; Si.Tau_TR_A.Rheo.FWHA];

%% Figure 4 - Rheobase graphing
    yLimitOn = 1;
    figCount = 1;
    tileCount = 6;
    figSize = [0.5 0.5 3.8 5.5];
    figTitles = "Tau Rheobase Parameters";
    tileTitles = ["At Resting Potential", "Holding at −60 mV"];
    % tileTitles = "Off";
    graphX = {Box.VR, Box.Si, Box.VR, Box.Si, Box.VR, Box.Si};
    graphY = {Box.VR_RheoLatency; Box.Si_RheoLatency; Box.VR_RheoAmp; Box.Si_RheoAmp; Box.VR_RheoFWHA; Box.Si_RheoFWHA};
    xLimits = [0.5 4.5];
    xTicks = 1:4;
    yLimits = [[0 500]; [0 500]; [0 120]; [0 120]; [0 4.5]; [0 4.5]];
    xLabels = {'WT', 'WT+AR', 'Tg', 'Tg+AR'};
    yLabels = ["Spike Latency (ms)", "", "Spike Amplitude (mV)", "", "Spike Width (ms)", ""];
    
    MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitOn, xLabels, yLabels)
end

%% Figure 5 - IV curves prep
if graphType == "All" || graphType == "5"
    ExcelRows = [179, 581, 305, 647];                        % WT: 199, WT+AR: 601, Tg: 379, Tg+AR: 481
    tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
    protocol = '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx';
    VCSteps = -100:10:0;
    displaySweeps = [7, 9, 11];     % -70, -20, 0 mV holding potentials (+20, +40, +60 mV applications)
    zeroedData = cell(4,1);

    [~, ~, ~, protocolFile, dataFile, ~, ~, ~] = ReadExcel(ExcelRows, tablePath, protocol);

    for fileNum = 1:length(ExcelRows)
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/Users/Shared/','P:\');
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/','\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/Users/Shared/','P:\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/','\');
        
        protocolFull  = read_axograph(protocolFile{fileNum});
        PRT.time      = protocolFull.columnData{1} * 1e3;                   % Convert from s to ms
        PRT.data      = cat(2, protocolFull.columnData{2:end}) * 1e3;       % Convert from V to mV
        PRT.IStepVals = PRT.data(round(0.5.*size(PRT.data, 1)),:);          % In mV
    
        currentFile = dataFile{fileNum};
        dataFileFull = read_axograph(currentFile);
        DATA.time = dataFileFull.columnData{1}* 1e3;                        % Convert from s to ms
        DATA.sweepInterval = mean(diff(DATA.time));                         % In ms
        DATA.data = cat(2, dataFileFull.columnData{2:end}) * 1e12;          % Convert from A to pA

        [leakStep, leakStepIdx] = max(PRT.IStepVals(PRT.IStepVals < 0));    % Leak step is the smallest negative step
        leakData = DATA.data(:, leakStepIdx);
        leakMultiplier = PRT.IStepVals/PRT.IStepVals(leakStepIdx);
        leakSubtractionData = leakData .* leakMultiplier;
        leakSubtractedData = DATA.data - leakSubtractionData;
    
        zeroingData         = leakSubtractedData(1:450, :);
        zeroVals            = mean(zeroingData);
        zeroedData{fileNum} = leakSubtractedData - zeroVals;
    end

    fullExcel = readtable(tablePath);
    fullExcel(~ismember(fullExcel.ProtocolPath, '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx'), :) = [];
    genotype = fullExcel.Genotype;
    adiporon = fullExcel.AdipoRon;
    
    F.Tau_WT = contains(genotype,"Tau WT");
    F.Tau_TR = contains(genotype,"Tau TR");
    F.NoAdipoRon = contains(adiporon,"No");
    F.AdipoRon = contains(adiporon,"10 microM");
    
    Tau_WT.Rows = find(F.Tau_WT + F.NoAdipoRon == 2);
    Tau_TR.Rows = find(F.Tau_TR + F.NoAdipoRon == 2);
    Tau_WT_A.Rows = find(F.Tau_WT + F.AdipoRon == 2);
    Tau_TR_A.Rows = find(F.Tau_TR + F.AdipoRon == 2);
       
    Tau_WT.Count     = length(Tau_WT.Rows);
    Tau_TR.Count     = length(Tau_TR.Rows);
    Tau_WT_A.Count   = length(Tau_WT_A.Rows);
    Tau_TR_A.Count   = length(Tau_TR_A.Rows);

    Tau_WT.IV = fullExcel{Tau_WT.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_TR.IV = fullExcel{Tau_TR.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_WT_A.IV = fullExcel{Tau_WT_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_TR_A.IV = fullExcel{Tau_TR_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};

    Tau_WT.IV_Mn    = mean(Tau_WT.IV);
    Tau_TR.IV_Mn    = mean(Tau_TR.IV);
    Tau_WT_A.IV_Mn  = mean(Tau_WT_A.IV);
    Tau_TR_A.IV_Mn  = mean(Tau_TR_A.IV);
    Tau_WT.IV_SEM = std(Tau_WT.IV) ./ sqrt(Tau_WT.Count);
    Tau_TR.IV_SEM = std(Tau_TR.IV) ./ sqrt(Tau_TR.Count);
    Tau_WT_A.IV_SEM = std(Tau_WT_A.IV) ./ sqrt(Tau_WT_A.Count);
    Tau_TR_A.IV_SEM = std(Tau_TR_A.IV) ./ sqrt(Tau_TR_A.Count);

    % Figure 5 - IV curves graphing
    figure('Units', 'inch', 'Pos', [1.5 1.5 6 2.4])
    tiledlayout(2, 7, 'TileSpacing', 'compact');
    set(gcf,'color','w');
    t1 = nexttile(1, [1,2]);
        plot(DATA.time, zeroedData{1}(:, displaySweeps(1)), 'Color', [0 0 0])
        hold on
        plot(DATA.time, zeroedData{1}(:, displaySweeps(2)), 'Color', [.35 .35 .35])
        plot(DATA.time, zeroedData{1}(:, displaySweeps(3)), 'Color', [.7 .7 .7])
        title('WT', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
        scalebars(gca, [5, 5], [13.3333333, 6.4516], {'ms', 'pA'}, 'Arial', 8, 1, {'%2.0f', '%2.0f'})
    t2 = nexttile(3, [1,2]);
        plot(DATA.time, zeroedData{2}(:, displaySweeps(1)), 'Color', [.3 0 .3])
        hold on
        plot(DATA.time, zeroedData{2}(:, displaySweeps(2)), 'Color', [.55 0 .55])
        plot(DATA.time, zeroedData{2}(:, displaySweeps(3)), 'Color', [.8 0 .8])
        title('WT+AR', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t3 = nexttile(8, [1,2]);
        plot(DATA.time, zeroedData{3}(:, displaySweeps(1)), 'Color', [0 .3 .3])
        hold on
        plot(DATA.time, zeroedData{3}(:, displaySweeps(2)), 'Color', [0 .55 .55])
        plot(DATA.time, zeroedData{3}(:, displaySweeps(3)), 'Color', [0 .8 .8])
        title('Tg', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t4 = nexttile(10, [1,2]);
        plot(DATA.time, zeroedData{4}(:, displaySweeps(1)), 'Color', [.3 .3 0])
        hold on
        plot(DATA.time, zeroedData{4}(:, displaySweeps(2)), 'Color', [.55 .55 0])
        plot(DATA.time, zeroedData{4}(:, displaySweeps(3)), 'Color', [.8 .8 0])
        title('Tg+AR', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t5 = nexttile([2, 3]);
        shadedErrorBar(VCSteps, Tau_WT.IV_Mn, Tau_WT.IV_SEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(VCSteps, Tau_WT_A.IV_Mn, Tau_WT_A.IV_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
        shadedErrorBar(VCSteps, Tau_TR.IV_Mn, Tau_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        shadedErrorBar(VCSteps, Tau_TR_A.IV_Mn, Tau_TR_A.IV_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
        t5.XAxis.FontSize = 8;
        t5.YAxis.FontSize = 8;
        t5.XAxis.FontName = 'Arial';
        t5.YAxis.FontName = 'Arial';
        xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
        ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
        xlim([-100 0])
        ylim([-400 1200])
        xticks(-100:20:0);
        xtickangle(0)
        leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau IV Curves.pdf", 'Resolution', 300)
end

%% Figure 5 v2 - IV curves prep
if graphType == "All" || graphType == "5 v2"
    ExcelRows = [179, 581, 305, 647];                        % WT: 199, WT+AR: 601, Tg: 379, Tg+AR: 481
    tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
    protocol = '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx';
    VCSteps = -100:10:0;
    displaySweeps = [7, 9, 11];     % -40, -20, 0 mV holding potentials (+20, +40, +60 mV applications)
    zeroedData = cell(4,1);

    [~, ~, ~, protocolFile, dataFile, ~, ~, ~] = ReadExcel(ExcelRows, tablePath, protocol);

    for fileNum = 1:length(ExcelRows)
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/Users/Shared/','P:\');
        protocolFile{fileNum} = strrep(protocolFile{fileNum},'/','\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/Users/Shared/','P:\');
        dataFile{fileNum} = strrep(dataFile{fileNum},'/','\');
        
        protocolFull  = read_axograph(protocolFile{fileNum});
        PRT.time      = protocolFull.columnData{1} * 1e3;                   % Convert from s to ms
        PRT.data      = cat(2, protocolFull.columnData{2:end}) * 1e3;       % Convert from V to mV
        PRT.IStepVals = PRT.data(round(0.5.*size(PRT.data, 1)),:);          % In mV
    
        currentFile = dataFile{fileNum};
        dataFileFull = read_axograph(currentFile);
        DATA.time = dataFileFull.columnData{1}* 1e3;                        % Convert from s to ms
        DATA.sweepInterval = mean(diff(DATA.time));                         % In ms
        DATA.data = cat(2, dataFileFull.columnData{2:end}) * 1e12;          % Convert from A to pA

        [leakStep, leakStepIdx] = max(PRT.IStepVals(PRT.IStepVals < 0));    % Leak step is the smallest negative step
        leakData = DATA.data(:, leakStepIdx);
        leakMultiplier = PRT.IStepVals/PRT.IStepVals(leakStepIdx);
        leakSubtractionData = leakData .* leakMultiplier;
        leakSubtractedData = DATA.data - leakSubtractionData;
    
        zeroingData         = leakSubtractedData(1:450, :);
        zeroVals            = mean(zeroingData);
        zeroedData{fileNum} = leakSubtractedData - zeroVals;
    end

    fullExcel = readtable(tablePath);
    fullExcel(~ismember(fullExcel.ProtocolPath, '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx'), :) = [];
    genotype = fullExcel.Genotype;
    adiporon = fullExcel.AdipoRon;
    
    F.Tau_WT = contains(genotype,"Tau WT");
    F.Tau_TR = contains(genotype,"Tau TR");
    F.NoAdipoRon = contains(adiporon,"No");
    F.AdipoRon = contains(adiporon,"10 microM");
    
    Tau_WT.Rows = find(F.Tau_WT + F.NoAdipoRon == 2);
    Tau_TR.Rows = find(F.Tau_TR + F.NoAdipoRon == 2);
    Tau_WT_A.Rows = find(F.Tau_WT + F.AdipoRon == 2);
    Tau_TR_A.Rows = find(F.Tau_TR + F.AdipoRon == 2);
       
    Tau_WT.Count     = length(Tau_WT.Rows);
    Tau_TR.Count     = length(Tau_TR.Rows);
    Tau_WT_A.Count   = length(Tau_WT_A.Rows);
    Tau_TR_A.Count   = length(Tau_TR_A.Rows);

    Tau_WT.IV = fullExcel{Tau_WT.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_TR.IV = fullExcel{Tau_TR.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_WT_A.IV = fullExcel{Tau_WT_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Tau_TR_A.IV = fullExcel{Tau_TR_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};

    Tau_WT.IV_Mn    = mean(Tau_WT.IV);
    Tau_TR.IV_Mn    = mean(Tau_TR.IV);
    Tau_WT_A.IV_Mn  = mean(Tau_WT_A.IV);
    Tau_TR_A.IV_Mn  = mean(Tau_TR_A.IV);
    Tau_WT.IV_SEM = std(Tau_WT.IV) ./ sqrt(Tau_WT.Count);
    Tau_TR.IV_SEM = std(Tau_TR.IV) ./ sqrt(Tau_TR.Count);
    Tau_WT_A.IV_SEM = std(Tau_WT_A.IV) ./ sqrt(Tau_WT_A.Count);
    Tau_TR_A.IV_SEM = std(Tau_TR_A.IV) ./ sqrt(Tau_TR_A.Count);

    % Figure 5 - IV curves graphing
    figure('Units', 'inch', 'Pos', [1.5 1.5 6 2.4])
    tiledlayout(2, 7, 'TileSpacing', 'compact');
    set(gcf,'color','w');
    t1 = nexttile(1, [1,2]);
        plot(DATA.time, zeroedData{1}(:, displaySweeps(1)), 'Color', [0 0 0])
        hold on
        plot(DATA.time, zeroedData{1}(:, displaySweeps(2)), 'Color', [.35 .35 .35])
        plot(DATA.time, zeroedData{1}(:, displaySweeps(3)), 'Color', [.7 .7 .7])
        title('WT', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
        scalebars(gca, [5, 5], [13.3333333, 6.4516], {'ms', 'pA'}, 'Arial', 8, 1, {'%2.0f', '%2.0f'})
    t2 = nexttile(3, [1,2]);
        plot(DATA.time, zeroedData{2}(:, displaySweeps(1)), 'Color', [.3 0 .3])
        hold on
        plot(DATA.time, zeroedData{2}(:, displaySweeps(2)), 'Color', [.55 0 .55])
        plot(DATA.time, zeroedData{2}(:, displaySweeps(3)), 'Color', [.8 0 .8])
        title('WT+AR', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t3 = nexttile(8, [1,2]);
        plot(DATA.time, zeroedData{3}(:, displaySweeps(1)), 'Color', [0 .3 .3])
        hold on
        plot(DATA.time, zeroedData{3}(:, displaySweeps(2)), 'Color', [0 .55 .55])
        plot(DATA.time, zeroedData{3}(:, displaySweeps(3)), 'Color', [0 .8 .8])
        title('Tg', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t4 = nexttile(10, [1,2]);
        plot(DATA.time, zeroedData{4}(:, displaySweeps(1)), 'Color', [.3 .3 0])
        hold on
        plot(DATA.time, zeroedData{4}(:, displaySweeps(2)), 'Color', [.55 .55 0])
        plot(DATA.time, zeroedData{4}(:, displaySweeps(3)), 'Color', [.8 .8 0])
        title('Tg+AR', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        xlim([23 38])
        ylim([-9100 2400])
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlabel('Time (ms)', 'FontSize', 8); 
        ylabel('Current (pA)', 'FontSize', 8);
        box off
        axis off
    t5 = nexttile([2, 3]);
        shadedErrorBar(VCSteps, Tau_WT.IV_Mn, Tau_WT.IV_SEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(VCSteps, Tau_WT_A.IV_Mn, Tau_WT_A.IV_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
        shadedErrorBar(VCSteps, Tau_TR.IV_Mn, Tau_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        shadedErrorBar(VCSteps, Tau_TR_A.IV_Mn, Tau_TR_A.IV_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
        t5.XAxis.FontSize = 8;
        t5.YAxis.FontSize = 8;
        t5.XAxis.FontName = 'Arial';
        t5.YAxis.FontName = 'Arial';
        xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
        ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
        xlim([-100 0])
        ylim([-400 1200])
        xticks(-100:20:0);
        xtickangle(0)
        leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau IV Curves.pdf", 'Resolution', 300)
end

%% Figure 6 - Amyloid data prep
% Passive parameters prep
if graphType == "All" || graphType == "6"
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

    % IV curve prep
    tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
    sheetName = "Acceptable Cells (No RS > 20)";
    VCSteps = -100:10:0;
    
    fullExcel = readtable(tablePath, 'Sheet', sheetName);
    fullExcel(~ismember(fullExcel.ProtocolPath, '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx'), :) = [];
    
    genotype = fullExcel.Genotype;
    F.Amy_WT = contains(genotype,"Amy WT");
    F.Amy_TR = contains(genotype,"Amy TR");

    Amy_WT.Rows = find(F.Amy_WT == 1);
    Amy_TR.Rows = find(F.Amy_TR == 1);   
    Amy_WT.Count     = length(Amy_WT.Rows);
    Amy_TR.Count     = length(Amy_TR.Rows);

    Amy_WT.IV = fullExcel{Amy_WT.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};
    Amy_TR.IV = fullExcel{Amy_TR.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
        "IVCurve10", "IVCurve11"]};

    Amy_WT.IV_Mn = mean(Amy_WT.IV);
    Amy_TR.IV_Mn = mean(Amy_TR.IV);
    Amy_WT.IV_SEM = std(Amy_WT.IV) ./ sqrt(Amy_WT.Count);
    Amy_TR.IV_SEM = std(Amy_TR.IV) ./ sqrt(Amy_TR.Count);

    % Rheobase prep
    Box.VR = [ones(VR.Amy_WT.Count, 1); 2*ones(VR.Amy_TR.Count, 1)];
    Box.Si = [ones(Si.Amy_WT.Count, 1); 2*ones(Si.Amy_TR.Count, 1)];
    
    Box.VR_RheoLatency  = [VR.Amy_WT.Rheo.Latency; VR.Amy_TR.Rheo.Latency];
    Box.VR_RheoAmp      = [VR.Amy_WT.Rheo.Amp; VR.Amy_TR.Rheo.Amp];
    Box.VR_RheoFWHA     = [VR.Amy_WT.Rheo.FWHA; VR.Amy_TR.Rheo.FWHA];
    Box.Si_RheoLatency  = [Si.Amy_WT.Rheo.Latency; Si.Amy_TR.Rheo.Latency];
    Box.Si_RheoAmp      = [Si.Amy_WT.Rheo.Amp; Si.Amy_TR.Rheo.Amp];
    Box.Si_RheoFWHA     = [Si.Amy_WT.Rheo.FWHA; Si.Amy_TR.Rheo.FWHA];

    % Spike prep
    for n = 1:nSteps
        for m = 1:VR.Amy_WT.Count
            VR.Amy_WT.ByStep.N{n}(m)    = VR.Amy_WT.Steps.N{m}(n);
            Si.Amy_WT.ByStep.N{n}(m)    = Si.Amy_WT.Steps.N{m}(n);
        end
        for m = 1:VR.Amy_TR.Count
            VR.Amy_TR.ByStep.N{n}(m)    = VR.Amy_TR.Steps.N{m}(n);
            Si.Amy_TR.ByStep.N{n}(m)    = Si.Amy_TR.Steps.N{m}(n);
        end
    end

    VR.Amy_WT.ByStep.NMn            = mean(cell2mat(VR.Amy_WT.ByStep.N), 2);
    VR.Amy_WT.ByStep.NSEM           = std(cell2mat(VR.Amy_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.N)), 2));
    VR.Amy_TR.ByStep.NMn            = mean(cell2mat(VR.Amy_TR.ByStep.N), 2);
    VR.Amy_TR.ByStep.NSEM           = std(cell2mat(VR.Amy_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.N)), 2));

    Si.Amy_WT.ByStep.NMn            = mean(cell2mat(Si.Amy_WT.ByStep.N), 2);
    Si.Amy_WT.ByStep.NSEM           = std(cell2mat(Si.Amy_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.N)), 2));
    Si.Amy_TR.ByStep.NMn            = mean(cell2mat(Si.Amy_TR.ByStep.N), 2);
    Si.Amy_TR.ByStep.NSEM           = std(cell2mat(Si.Amy_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.N)), 2));

    [VR.Amy_WT.OneSpikePer, VR.Amy_WT.OneSpikeN, VR.Amy_WT.OneSpikeArr]         = OneSpike(VR.Amy_WT.Steps.N, VR.Amy_WT.Count);
    [VR.Amy_TR.OneSpikePer, VR.Amy_TR.OneSpikeN, VR.Amy_TR.OneSpikeArr]         = OneSpike(VR.Amy_TR.Steps.N, VR.Amy_TR.Count);
    [Si.Amy_WT.OneSpikePer, Si.Amy_WT.OneSpikeN, Si.Amy_WT.OneSpikeArr]         = OneSpike(Si.Amy_WT.Steps.N, Si.Amy_WT.Count);
    [Si.Amy_TR.OneSpikePer, Si.Amy_TR.OneSpikeN, Si.Amy_TR.OneSpikeArr]         = OneSpike(Si.Amy_TR.Steps.N, Si.Amy_TR.Count);
    
    [VR.Amy_WT.OnePlusSpikePer, VR.Amy_WT.OnePlusSpikeN, VR.Amy_WT.OnePlusSpikeArr]         = OnePlusSpike(VR.Amy_WT.Steps.N, VR.Amy_WT.Count);
    [VR.Amy_TR.OnePlusSpikePer, VR.Amy_TR.OnePlusSpikeN, VR.Amy_TR.OnePlusSpikeArr]         = OnePlusSpike(VR.Amy_TR.Steps.N, VR.Amy_TR.Count);
    [Si.Amy_WT.OnePlusSpikePer, Si.Amy_WT.OnePlusSpikeN, Si.Amy_WT.OnePlusSpikeArr]         = OnePlusSpike(Si.Amy_WT.Steps.N, Si.Amy_WT.Count);
    [Si.Amy_TR.OnePlusSpikePer, Si.Amy_TR.OnePlusSpikeN, Si.Amy_TR.OnePlusSpikeArr]         = OnePlusSpike(Si.Amy_TR.Steps.N, Si.Amy_TR.Count);

    % Figure 6 - Amyloid data graphing
    figure('Units', 'inch', 'Position', [0.5 0.5 6.5 7.5])
    tiledlayout(4, 10, 'TileSpacing', 'compact');
    graphX = {Box.Amy; Box.Amy; Box.Amy};
    graphY = {Box.Amy_RM; Box.Amy_CM; Box.Amy_VR};
    yLimits = ([0, 1500 ; 0, 40 ; -85, 0]);
    xLabels = {'WT', 'Tg'};
    yLabels = ["Resistance (MΩ)", "Capacitance (pF)", "Resting Potential (mV)"];

    for m = 1:3
        tile = nexttile([1 2]);
        filt1 = graphX{m} == 1;
        filt2 = graphX{m} == 2;
        boxchart(graphX{m}, graphY{m, 1}, 'MarkerStyle', 'None', 'BoxFaceColor', 'k', 'BoxFaceAlpha', 0)
        hold on
        swarmchart(graphX{m}(filt1), graphY{m, 1}(filt1), 8, 'k', 'MarkerFaceColor', 'k', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        swarmchart(graphX{m}(filt2), graphY{m, 1}(filt2), 8, [0 .7 .7], 'MarkerFaceColor', [0 .7 .7], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        xlim([0.5 2.5]);
        ylim([yLimits(m, 1), yLimits(m, 2)])
        tile.XAxis.FontSize = 8;
        tile.YAxis.FontSize = 8;
        tile.XAxis.FontName = 'Arial';
        tile.YAxis.FontName = 'Arial';
        xticks(1:2)
        xticklabels(xLabels)
        xtickangle(0)
        ylabel(yLabels(m), 'FontSize', 8, 'FontName', 'Arial')
    end

    % IV Curve graphing
    nexttile([1 3])
        shadedErrorBar(VCSteps, Amy_WT.IV_Mn, Amy_WT.IV_SEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(VCSteps, Amy_TR.IV_Mn, Amy_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
        ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
        xlim([-100 0])
        ylim([-50 1000])
        xticks(-100:50:0);
        xtickangle(0)
        leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [20, 20];

    % Rheobase graphing
    graphX = {Box.VR, Box.Si, Box.VR, Box.Si, Box.VR, Box.Si};
    graphY = {Box.VR_RheoLatency; Box.Si_RheoLatency; Box.VR_RheoAmp; Box.Si_RheoAmp; Box.VR_RheoFWHA; Box.Si_RheoFWHA};
    yLimits = [[0 350]; [0 350]; [0 110]; [0 110]; [0 3.5]; [0 3.5]];
    tileTitles = ["Resting Potential", "Holding −60 mV"];
    xLabels = {'WT', 'Tg'};
    yLabels = ["Spike Latency (ms)", "", "Spike Amplitude (mV)", "", "Spike Width (ms)", ""];
    tileIdx = [11, 13, 21, 23, 31, 33];
    for m = 1:6
        tile = nexttile(tileIdx(m), [1 2]);
        filt1 = graphX{m} == 1;
        filt2 = graphX{m} == 2;
        boxchart(graphX{m}, graphY{m, 1}, 'MarkerStyle', 'None', 'BoxFaceColor', 'k', 'BoxFaceAlpha', 0)
        hold on
        swarmchart(graphX{m}(filt1), graphY{m, 1}(filt1), 8, 'k', 'MarkerFaceColor', 'k', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        swarmchart(graphX{m}(filt2), graphY{m, 1}(filt2), 8, [0 .7 .7], 'MarkerFaceColor', [0 .7 .7], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        xlim([0.5 2.5]);
        ylim([yLimits(m, 1), yLimits(m, 2)])
        tile.XAxis.FontSize = 8;
        tile.YAxis.FontSize = 8;
        tile.XAxis.FontName = 'Arial';
        tile.YAxis.FontName = 'Arial';
        if m < 3
            title(tileTitles(m), 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        end
        xticks(1:2)
        xticklabels(xLabels)
        xtickangle(0)
        ylabel(yLabels(m), 'FontSize', 8, 'FontName', 'Arial')
    end

    % Spike graphing
    t1 = nexttile([1 3]);
        shadedErrorBar(ISteps, VR.Amy_WT.ByStep.NMn, VR.Amy_WT.ByStep.NSEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(ISteps, VR.Amy_TR.ByStep.NMn, VR.Amy_TR.ByStep.NSEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        ylabel('Spike Count', 'FontSize', 8, 'FontName', 'Arial')
        ylim([0 8])
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        title('Resting Potential', 'FontSize', 10, 'FontWeight', 'Normal')
    t2 = nexttile([1 3]);
        shadedErrorBar(ISteps, Si.Amy_WT.ByStep.NMn, Si.Amy_WT.ByStep.NSEM, 'LineProps', 'k')
        hold on
        shadedErrorBar(ISteps, Si.Amy_TR.ByStep.NMn, Si.Amy_TR.ByStep.NSEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        ylim([0 8])
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        title('Holding −60 mV', 'FontSize', 10, 'FontWeight', 'Normal', 'FontName', 'Arial')
    t3 = nexttile([1 3]);
        plot(ISteps, VR.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        ylabel('One or More Spikes (%)')
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t4 = nexttile([1 3]);
        plot(ISteps, Si.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t5 = nexttile([1 3]);
        plot(ISteps, VR.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        ylabel('Exactly One Spike (%)')
        xlabel('Injected Current (pA)')
        t5.XAxis.FontSize = 8;
        t5.YAxis.FontSize = 8;
        t5.XAxis.FontName = 'Arial';
        t5.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    t6 = nexttile([1 3]);
        plot(ISteps, Si.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        xlabel('Injected Current (pA)')
        t6.XAxis.FontSize = 8;
        t6.YAxis.FontSize = 8;
        t6.XAxis.FontName = 'Arial';
        t6.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        xticks([0 240 480])
        ylim([0 100])
    exportgraphics(gcf, "Amyloid Figure.pdf", 'Resolution', 300)
end

end

function [oneSpike, sumMatrix, tempMatrix] = OneSpike(inputMatrix, cellCount)
    tempMatrix = cell2mat(inputMatrix');
    tempMatrix(tempMatrix == 1) = 1;
    tempMatrix(tempMatrix ~= 1) = 0;
    sumMatrix = sum(tempMatrix, 2);
    oneSpike = sumMatrix/cellCount * 100;
end

function [onePlusSpike, sumMatrix, tempMatrix] = OnePlusSpike(inputMatrix, cellCount)
    tempMatrix = cell2mat(inputMatrix');
    tempMatrix(tempMatrix >= 1) = 1;
    tempMatrix(tempMatrix < 1) = 0;
    sumMatrix = sum(tempMatrix, 2);
    onePlusSpike = sumMatrix/cellCount * 100;
end
