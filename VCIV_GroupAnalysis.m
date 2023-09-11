tablePath = "P:\AndersonLabCultures\Namefile 04-27-23.xlsx";
inputDir = "P:\AndersonLabCultures\output 05-11-23";
outputDir = "P:\AndersonLabCultures\figures 06-13-23";
sheetName = "Acceptable Cells (No RS > 20)";
cellType = "All";
stepLength = 11;
ISteps = -100:10:0;
graphType = "Amy";       % Options: "All", "Individual", "Tau", "Amy", "Traces"

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
    figure('Units', 'inch', 'Position', [1.5 1.5 2.3 2])
    p1 = shadedErrorBar(ISteps, Tau_WT.IV_Mn, Tau_WT.IV_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.IV_Mn, Tau_WT_A.IV_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.IV_Mn, Tau_TR.IV_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.IV_Mn, Tau_TR_A.IV_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    title('IV Curves', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal');
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    ylim([-500 1200])
    xticks(-100:20:0);
    xtickangle(0);
    leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];
    exportgraphics(gcf, "Tau IV Curves.pdf", 'Resolution', 300)

%% Plot mean and SEM for Tau max inward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.3 2])
    p1 = shadedErrorBar(ISteps, Tau_WT.MaxInCurrent_Mn, Tau_WT.MaxInCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.MaxInCurrent_Mn, Tau_WT_A.MaxInCurrent_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.MaxInCurrent_Mn, Tau_TR.MaxInCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.MaxInCurrent_Mn, Tau_TR_A.MaxInCurrent_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    title('Maximum Inward Current', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal');
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    ylim([-10000 0])
    xticks(-100:20:0);
    xtickangle(0);
    exportgraphics(gcf, "Tau Max Inward Current.pdf", 'Resolution', 300)

    %% Plot mean and SEM for Tau max outward current
    figure('Units', 'inch', 'Position', [1.5 1.5 2.3 2])
    p1 = shadedErrorBar(ISteps, Tau_WT.MaxOutCurrent_Mn, Tau_WT.MaxOutCurrent_SEM, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Tau_WT_A.MaxOutCurrent_Mn, Tau_WT_A.MaxOutCurrent_SEM, 'LineProps', {'Color', [.7 0 .7], 'MarkerFaceColor', [.7 0 .7]})
    shadedErrorBar(ISteps, Tau_TR.MaxOutCurrent_Mn, Tau_TR.MaxOutCurrent_SEM, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    shadedErrorBar(ISteps, Tau_TR_A.MaxOutCurrent_Mn, Tau_TR_A.MaxOutCurrent_SEM, 'LineProps', {'Color', [.7 .7 0], 'markerfacecolor', [.7 .7 0]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    title('Maximum Outward Current', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal');
    ylabel('Current (pA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:20:0);
    xtickangle(0);
    exportgraphics(gcf, "Tau Max Outward Current.pdf", 'Resolution', 300)
end

%% Plot mean and SEM for Amy max inward current
if graphType == "Amy" || graphType == "All"
    figure('Units', 'inch', 'Position', [1.5 1.5 5 1.85])
    tiledlayout(1,3);
    nexttile
    p1 = shadedErrorBar(ISteps, Amy_WT.MaxInCurrent_Mn/1000, Amy_WT.MaxInCurrent_SEM/1000, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.MaxInCurrent_Mn/1000, Amy_TR.MaxInCurrent_SEM/1000, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    title('Max Inward Current', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal')
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    ylabel('Current (nA)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:50:0);
    leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
    legend('boxoff')
    leg.ItemTokenSize = [20, 20];

    %% Plot mean and SEM for Amy max outward current
    nexttile
    p1 = shadedErrorBar(ISteps, Amy_WT.MaxOutCurrent_Mn/1000, Amy_WT.MaxOutCurrent_SEM/1000, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.MaxOutCurrent_Mn/1000, Amy_TR.MaxOutCurrent_SEM/1000, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    title('Max Outward Current', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal')
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    %ylim([-400 1200])
    xticks(-100:50:0);

    %% Plot mean and SEM for Amy IV Curves
    nexttile
    p1 = shadedErrorBar(ISteps, Amy_WT.IV_Mn/1000, Amy_WT.IV_SEM/1000, 'LineProps', 'k');
    hold on
    shadedErrorBar(ISteps, Amy_TR.IV_Mn/1000, Amy_TR.IV_SEM/1000, 'LineProps', {'Color', [0 .7 .7], 'MarkerFaceColor', [0 .7 .7]})
    p1.XAxis.FontSize = 8;
    p1.YAxis.FontSize = 8;
    p1.XAxis.FontName = 'Arial';
    p1.YAxis.FontName = 'Arial';
    title('IV Curves', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'normal')
    xlabel('Voltage (mV)', 'FontSize', 8, 'FontName', 'Arial')
    xlim([-105 0])
    xticks(-100:50:0);
    exportgraphics(gcf, "All Amy VC.pdf", 'Resolution', 300)
end

%% Plot traces for each tau treatment in a method pulled from VC_IV_Fig_MJ1
if graphType == "Traces" || graphType == "All"
    prtfile = 'P:\AndersonLabCultures\protocols & configs\VC-IV.prt.axgx';

    dataGroup{1}    = 'WT'; 
    dataFile{1}     = 'P:\AndersonLabCultures\lasky\02-22-23\02-22-23 034.axgd';
    dataGroup{2}    = 'WT+AR'; 
    dataFile{2}     = 'P:\AndersonLabCultures\lasky\02-22-23\02-22-23 025.axgd';
    dataGroup{3}    = 'Tg'; 
    dataFile{3}     = 'P:\AndersonLabCultures\lasky\01-05-23\01-05-23 034.axgd';
    dataGroup{4}    = 'Tg+AR'; 
    dataFile{4}     = 'P:\AndersonLabCultures\lasky\03-09-23\03-09-23 001.axgd';

    %% Load data
    for fileNum = 1:length(dataFile)
        PRT  = read_axograph(prtfile);
        PRT.time = PRT.columnData{1};
        PRT.data = cat(2, PRT.columnData{2:end});
        dummy = min(PRT.data);
        [testVstep, testVstepIndx] = max(dummy(find(dummy)));  % smallest negative Vstep (Volts)
        Vsteps = PRT.data(round(0.5.*size(PRT.data,1)),:);
    
        CURR(fileNum) = read_axograph(dataFile{fileNum});
    end

    for fileNum = 1:length(dataFile)
        CURR(fileNum).time = CURR(fileNum).columnData{1};
        CURR(fileNum).data = cat(2, CURR(fileNum).columnData{2:end});
        testVstepTrace = CURR(fileNum).data(:, testVstepIndx);    
        CURR(fileNum).dataLeakSub = CURR(fileNum).data - (testVstepTrace.*Vsteps./testVstep);
        CURR(fileNum).dataLeakSubBaselined = CURR(fileNum).dataLeakSub - repmat(mean(CURR(fileNum).dataLeakSub(1:450,:)), size(CURR(fileNum).dataLeakSub, 1), 1);
    end

    %% Only display every 3rd point to reduce number of anchopr points for illustrator (which caps a PDF at 32k)
    for fileNum = 1:length(dataFile)
        CURR(fileNum).time = CURR(fileNum).time(1:3:end);
        CURR(fileNum).dataLeakSubBaselined = CURR(fileNum).dataLeakSubBaselined(1:3:end, :);
    end

    %% Draw 
    displaySteps = 7:11;
    figure('units', 'inch', 'pos', 0.5.*[0 0 7.5 10], 'color', 'w')
    
    ax1LockPos = [0.1 0.55 0.4 0.4];

    colord{1} = [.2 .2 .2; .4 .4 .4; .6 .6 .6; .8 .8 .8; 1 1 1];        % Gray
    colord{2} = [.3 0 .3; .475 0 .475; .65 0 .65; .825 0 .825; 1 0 1];  % Magenta
    colord{3} = [0 .3 .3; 0 .475 .475; 0 .65 .65; 0 .825 .825; 0 1 1];  % Cyan
    colord{4} = [.3 .3 0; .475 .475 0; .65 .65 0; .825 .825 0; 1 1 0];  % Yellow
    colorscalefactor = 0.75;

    for fileNum = 1:length(dataFile)
        [x, y] = ind2sub([2 2], fileNum);
    
        % Whole trace
        axWhole(fileNum) = axes('units', 'norm', 'pos', ax1LockPos + [0.45.*(x-1) -0.5.*(y-1) 0 0]);    
        plt{fileNum} = plot(1e3.*CURR(fileNum).time, 1e9.*CURR(fileNum).dataLeakSubBaselined(:,displaySteps));
        set(gca, 'xlim', [20 200], 'ylim', [-3 1.2], 'colororder', colorscalefactor.*colord{fileNum})
        axis off
        axLockPos{fileNum} = get(gca, 'pos');
        if fileNum == 1
            [sx, sy] = scalebars(gca, [40 0.7], [5.*280/100, 10], {'ms', 'nA'}, 'arial', 8, 1, {'%2.2f', '%1.3f'});
            text(100, 0.9, 'All', 'FontName', 'Arial', 'FontSize', 8)
        end
        title(dataGroup{fileNum}, 'FontName', 'Arial', 'FontSize', 10, 'FontWeight', 'normal')
        
        % Early trace
        axEarly(fileNum) = axes('units', 'norm', 'pos', axLockPos{fileNum}.*[1 1 0.4 0.6]+[0.05 0.03 0 0]);
        plt{fileNum} = plot(1e3.*CURR(fileNum).time, 1e9.*CURR(fileNum).dataLeakSubBaselined(:,displaySteps));
        set(gca, 'xlim', [25 35], 'ylim', [-10 3], 'colororder', colorscalefactor.*colord{fileNum})
        axis off     
        if fileNum == 1
            [sx, sy] = scalebars(gca, [30 -4], [40, 20], {'ms', 'nA'}, 'arial', 8, 1, {'%2.2f', '%1.3f'})       ; 
            text(26, 1.5, 'Early', 'FontName', 'Arial', 'FontSize', 8)            
        end

        % Late trace
        axLate(fileNum) = axes('units', 'norm', 'pos', axLockPos{fileNum}.*[1 1 0.4 0.6]+[0.25 0.03 0 0]);
        plt{fileNum} = plot(1e3.*CURR(fileNum).time, 1e9.*CURR(fileNum).dataLeakSubBaselined(:,displaySteps));
        set(gca, 'xlim', [150 200], 'ylim', [-10 3], 'colororder', colorscalefactor.*colord{fileNum})
        axis off     
        if fileNum == 1
            [sx, sy] = scalebars(gca, [160 -4], [40, 20], {'ms', 'nA'}, 'arial', 8, 1, {'%2.2f', '%1.3f'})    ;    
            text(150, 1.5, 'Late', 'FontName', 'Arial', 'FontSize', 8)                        
        end       
    end
    exportgraphics(gcf, "Tau Traces.pdf", 'Resolution', 300)
end
