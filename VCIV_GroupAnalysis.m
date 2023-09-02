tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
inputDir = "P:\AndersonLabCultures\output 05-11-23";
outputDir = "P:\AndersonLabCultures\figures 06-13-23";
sheetName = "Acceptable Cells (No RS > 20)";
cellType = "All";
stepLength = 11;
ISteps = -100:10:0;
graphType = "All";       % Options: "All", "Individual", "Tau", "Amy"

if cellType == "All"
    fullExcel = readtable(tablePath, 'Sheet', sheetName);
elseif cellType == "Healthy"
    fullExcel = readtable(tablePath, 'Sheet', sheetName);
    fullExcel(ismember(fullExcel.HealthyCell, 'no'), :) = [];
end

cd(inputDir)

%% Filter data
fullExcel(~ismember(fullExcel.ProtocolPath, '/Users/Shared/AndersonLabCultures/protocols & configs/VC-IV.prt.axgx'), :) = [];

protocol = fullExcel.Protocol;
genotype = fullExcel.Genotype;
adiporon = fullExcel.AdipoRon;

F.Amy_WT = contains(genotype,"Amy WT");
F.Amy_TR = contains(genotype,"Amy TR");
F.Tau_WT = contains(genotype,"Tau WT");
F.Tau_TR = contains(genotype,"Tau TR");

F.NoAdipoRon = contains(adiporon,"No");
F.AdipoRon = contains(adiporon,"10 microM");

Amy_WT.Rows = find(F.Amy_WT == 1);
Amy_TR.Rows = find(F.Amy_TR == 1);
Tau_WT.Rows = find(F.Tau_WT + F.NoAdipoRon == 2);
Tau_TR.Rows = find(F.Tau_TR + F.NoAdipoRon == 2);

Tau_WT_A.Rows = find(F.Tau_WT + F.AdipoRon == 2);
Tau_TR_A.Rows = find(F.Tau_TR + F.AdipoRon == 2);

%% Get row counts
Amy_WT.Count     = length(Amy_WT.Rows);
Amy_TR.Count     = length(Amy_TR.Rows);
Tau_WT.Count     = length(Tau_WT.Rows);
Tau_TR.Count     = length(Tau_TR.Rows);
Tau_WT_A.Count   = length(Tau_WT_A.Rows);
Tau_TR_A.Count   = length(Tau_TR_A.Rows);

%% Read in data
Amy_WT.IV = fullExcel{Amy_WT.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};
Amy_TR.IV = fullExcel{Amy_TR.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};
Tau_WT.IV = fullExcel{Tau_WT.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};
Tau_TR.IV = fullExcel{Tau_TR.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};
Tau_WT_A.IV = fullExcel{Tau_WT_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};
Tau_TR_A.IV = fullExcel{Tau_TR_A.Rows, ["IVCurve1", "IVCurve2", "IVCurve3", "IVCurve4", "IVCurve5", "IVCurve6", "IVCurve7", "IVCurve8", "IVCurve9", ...
    "IVCurve10", "IVCurve11"]};

Amy_WT.MaxInCurrent = fullExcel{Amy_WT.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};
Amy_TR.MaxInCurrent = fullExcel{Amy_TR.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};
Tau_WT.MaxInCurrent = fullExcel{Tau_WT.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};
Tau_TR.MaxInCurrent = fullExcel{Tau_TR.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};
Tau_WT_A.MaxInCurrent = fullExcel{Tau_WT_A.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};
Tau_TR_A.MaxInCurrent = fullExcel{Tau_TR_A.Rows, ["maxInCurrent1", "maxInCurrent2", "maxInCurrent3", "maxInCurrent4", "maxInCurrent5", ...
    "maxInCurrent6", "maxInCurrent7", "maxInCurrent8", "maxInCurrent9", "maxInCurrent10", "maxInCurrent11"]};

Amy_WT.MaxOutCurrent = fullExcel{Amy_WT.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};
Amy_TR.MaxOutCurrent = fullExcel{Amy_TR.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};
Tau_WT.MaxOutCurrent = fullExcel{Tau_WT.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};
Tau_TR.MaxOutCurrent = fullExcel{Tau_TR.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};
Tau_WT_A.MaxOutCurrent = fullExcel{Tau_WT_A.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};
Tau_TR_A.MaxOutCurrent = fullExcel{Tau_TR_A.Rows, ["maxOutCurrent1", "maxOutCurrent2", "maxOutCurrent3", "maxOutCurrent4", "maxOutCurrent5", ...
    "maxOutCurrent6", "maxOutCurrent7", "maxOutCurrent8", "maxOutCurrent9", "maxOutCurrent10", "maxOutCurrent11"]};

%% Compute means and SEMs for shaded error bars 
Amy_WT.IV_Mn    = mean(Amy_WT.IV);
Amy_TR.IV_Mn    = mean(Amy_TR.IV);
Tau_WT.IV_Mn    = mean(Tau_WT.IV);
Tau_TR.IV_Mn    = mean(Tau_TR.IV);
Tau_WT_A.IV_Mn  = mean(Tau_WT_A.IV);
Tau_TR_A.IV_Mn  = mean(Tau_TR_A.IV);

Amy_WT.MaxInCurrent_Mn      = mean(Amy_WT.MaxInCurrent);
Amy_TR.MaxInCurrent_Mn      = mean(Amy_TR.MaxInCurrent);
Tau_WT.MaxInCurrent_Mn      = mean(Tau_WT.MaxInCurrent);
Tau_TR.MaxInCurrent_Mn      = mean(Tau_TR.MaxInCurrent);
Tau_WT_A.MaxInCurrent_Mn    = mean(Tau_WT_A.MaxInCurrent);
Tau_TR_A.MaxInCurrent_Mn    = mean(Tau_TR_A.MaxInCurrent);

Amy_WT.MaxOutCurrent_Mn     = mean(Amy_WT.MaxOutCurrent);
Amy_TR.MaxOutCurrent_Mn     = mean(Amy_TR.MaxOutCurrent);
Tau_WT.MaxOutCurrent_Mn     = mean(Tau_WT.MaxOutCurrent);
Tau_TR.MaxOutCurrent_Mn     = mean(Tau_TR.MaxOutCurrent);
Tau_WT_A.MaxOutCurrent_Mn   = mean(Tau_WT_A.MaxOutCurrent);
Tau_TR_A.MaxOutCurrent_Mn   = mean(Tau_TR_A.MaxOutCurrent);

Amy_WT.IV_SEM = std(Amy_WT.IV) ./ sqrt(Amy_WT.Count);
Amy_TR.IV_SEM = std(Amy_TR.IV) ./ sqrt(Amy_TR.Count);
Tau_WT.IV_SEM = std(Tau_WT.IV) ./ sqrt(Tau_WT.Count);
Tau_TR.IV_SEM = std(Tau_TR.IV) ./ sqrt(Tau_TR.Count);
Tau_WT_A.IV_SEM = std(Tau_WT_A.IV) ./ sqrt(Tau_WT_A.Count);
Tau_TR_A.IV_SEM = std(Tau_TR_A.IV) ./ sqrt(Tau_TR_A.Count);

Amy_WT.MaxInCurrent_SEM     = std(Amy_WT.MaxInCurrent) ./ sqrt(Amy_WT.Count);
Amy_TR.MaxInCurrent_SEM     = std(Amy_TR.MaxInCurrent) ./ sqrt(Amy_TR.Count);
Tau_WT.MaxInCurrent_SEM     = std(Tau_WT.MaxInCurrent) ./ sqrt(Tau_WT.Count);
Tau_TR.MaxInCurrent_SEM     = std(Tau_TR.MaxInCurrent) ./ sqrt(Tau_TR.Count);
Tau_WT_A.MaxInCurrent_SEM   = std(Tau_WT_A.MaxInCurrent) ./ sqrt(Tau_WT_A.Count);
Tau_TR_A.MaxInCurrent_SEM   = std(Tau_TR_A.MaxInCurrent) ./ sqrt(Tau_TR_A.Count);

Amy_WT.MaxOutCurrent_SEM    = std(Amy_WT.MaxOutCurrent) ./ sqrt(Amy_WT.Count);
Amy_TR.MaxOutCurrent_SEM    = std(Amy_TR.MaxOutCurrent) ./ sqrt(Amy_TR.Count);
Tau_WT.MaxOutCurrent_SEM    = std(Tau_WT.MaxOutCurrent) ./ sqrt(Tau_WT.Count);
Tau_TR.MaxOutCurrent_SEM    = std(Tau_TR.MaxOutCurrent) ./ sqrt(Tau_TR.Count);
Tau_WT_A.MaxOutCurrent_SEM  = std(Tau_WT_A.MaxOutCurrent) ./ sqrt(Tau_WT_A.Count);
Tau_TR_A.MaxOutCurrent_SEM  = std(Tau_TR_A.MaxOutCurrent) ./ sqrt(Tau_TR_A.Count);

cd(outputDir)

%% Plot all IV curves for individual cells in each treatment
if graphType == "Individual" || graphType == "All"
    figure('Units', 'inch', 'Position', [1 1 16 10])
    t = tiledlayout(2,3);
    title(t, "IV-Curves for Individual Cells (" + cellType + ")", 'FontSize', 24)
    
    t1 = nexttile;
        hold on
        for n = 1:Tau_WT.Count
            plot(ISteps, Tau_WT.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Tau WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t2 = nexttile;
        hold on
        for n = 1:Tau_WT_A.Count
            plot(ISteps, Tau_WT_A.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Tau WT AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t3 = nexttile;
        hold on
        for n = 1:Amy_WT.Count
            plot(ISteps, Amy_WT.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Amy WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t4 = nexttile;
        hold on
        for n = 1:Tau_TR.Count
            plot(ISteps, Tau_TR.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Tau Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    t5 = nexttile;
        hold on
        for n = 1:Tau_TR_A.Count
            plot(ISteps, Tau_TR_A.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t5.XAxis.FontSize = 14;
        t5.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Tau Tg AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t6 = nexttile;
        hold on
        for n = 1:Amy_TR.Count
            plot(ISteps, Amy_TR.IV(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t6.XAxis.FontSize = 14;
        t6.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-300 2500])
        title('Amy Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    saveas(gcf, "IV-Curves for Individual Cells (" + cellType + ")" + ".png")

    %% Plot all maximum inward current for individual cells in each treatment
    figure('Units', 'inch', 'Position', [1 1 16 10])
    t = tiledlayout(2,3);
    title(t, "Max Inward Current for Individual Cells (" + cellType + ")", 'FontSize', 24)
    
    t1 = nexttile;
        hold on
        for n = 1:Tau_WT.Count
            plot(ISteps, Tau_WT.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Tau WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t2 = nexttile;
        hold on
        for n = 1:Tau_WT_A.Count
            plot(ISteps, Tau_WT_A.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Tau WT AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t3 = nexttile;
        hold on
        for n = 1:Amy_WT.Count
            plot(ISteps, Amy_WT.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Amy WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t4 = nexttile;
        hold on
        for n = 1:Tau_TR.Count
            plot(ISteps, Tau_TR.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Tau Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    t5 = nexttile;
        hold on
        for n = 1:Tau_TR_A.Count
            plot(ISteps, Tau_TR_A.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t5.XAxis.FontSize = 14;
        t5.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Tau Tg AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t6 = nexttile;
        hold on
        for n = 1:Amy_TR.Count
            plot(ISteps, Amy_TR.MaxInCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t6.XAxis.FontSize = 14;
        t6.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([-12000 0])
        title('Amy Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    saveas(gcf, "Max Inward Current for Individual Cells (" + cellType + ")" + ".png")

    %% Plot all maximum outward current for individual cells in each treatment
    figure('Units', 'inch', 'Position', [1 1 16 10])
    t = tiledlayout(2,3);
    title(t, "Max Outward Current for Individual Cells (" + cellType + ")", 'FontSize', 24)
    
    t1 = nexttile;
        hold on
        for n = 1:Tau_WT.Count
            plot(ISteps, Tau_WT.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Tau WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t2 = nexttile;
        hold on
        for n = 1:Tau_WT_A.Count
            plot(ISteps, Tau_WT_A.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Tau WT AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t3 = nexttile;
        hold on
        for n = 1:Amy_WT.Count
            plot(ISteps, Amy_WT.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Amy WT', 'FontSize', 16, 'FontWeight', 'Normal')
    t4 = nexttile;
        hold on
        for n = 1:Tau_TR.Count
            plot(ISteps, Tau_TR.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Tau Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    t5 = nexttile;
        hold on
        for n = 1:Tau_TR_A.Count
            plot(ISteps, Tau_TR_A.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t5.XAxis.FontSize = 14;
        t5.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Tau Tg AR', 'FontSize', 16, 'FontWeight', 'Normal')
    t6 = nexttile;
        hold on
        for n = 1:Amy_TR.Count
            plot(ISteps, Amy_TR.MaxOutCurrent(n,:), 'k')
        end
        xlabel('Holding Potential (mV)')
        ylabel('Current (nA)')
        t6.XAxis.FontSize = 14;
        t6.YAxis.FontSize = 14;
        xlim([-100 0])
        ylim([0 4000])
        title('Amy Tg', 'FontSize', 16, 'FontWeight', 'Normal')
    saveas(gcf, "Max Outward Current for Individual Cells (" + cellType + ")" + ".png")
end

%% Plot mean and SEM for Tau IV Curves
if graphType == "Tau" || graphType == "All"
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Tau_WT.IV_Mn, Tau_WT.IV_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.IV_Mn, Tau_WT_A.IV_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.IV_Mn, Tau_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.IV_Mn, Tau_TR_A.IV_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau IV Curves.pdf", 'Resolution', 300)

%% Plot mean and SEM for Tau max inward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Tau_WT.MaxInCurrent_Mn, Tau_WT.MaxInCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.MaxInCurrent_Mn, Tau_WT_A.MaxInCurrent_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.MaxInCurrent_Mn, Tau_TR.MaxInCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.MaxInCurrent_Mn, Tau_TR_A.MaxInCurrent_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Max Inward Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau Max Inward Current.pdf", 'Resolution', 300)

    %% Plot mean and SEM for Tau max outward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Tau_WT.MaxOutCurrent_Mn, Tau_WT.MaxOutCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.MaxOutCurrent_Mn, Tau_WT_A.MaxOutCurrent_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.MaxOutCurrent_Mn, Tau_TR.MaxOutCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.MaxOutCurrent_Mn, Tau_TR_A.MaxOutCurrent_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Max Outward Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau Max Outward Current.pdf", 'Resolution', 300)
end

%% Plot mean and SEM for Amy IV Curves
if graphType == "Amy" || graphType == "All"
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Amy_WT.IV_Mn, Amy_WT.IV_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.IV_Mn, Amy_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Amy IV Curves.pdf", 'Resolution', 300)

    %% Plot mean and SEM for Amy max inward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Amy_WT.MaxInCurrent_Mn, Amy_WT.MaxInCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.MaxInCurrent_Mn, Amy_TR.MaxInCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Max Inward Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Amy Max Inward Current.pdf", 'Resolution', 300)

    %% Plot mean and SEM for Amy max outward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.85 2.5])
    p1 = shadedErrorBar(ISteps, Amy_WT.MaxOutCurrent_Mn, Amy_WT.MaxOutCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.MaxOutCurrent_Mn, Amy_TR.MaxOutCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Holding Potential (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Max Outward Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:20:0);
    leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Amy Max Outward Current.pdf", 'Resolution', 300)
end
