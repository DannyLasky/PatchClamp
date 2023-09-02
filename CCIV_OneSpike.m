function [VR, Si] = CCIV_OneSpike(VR, Si, nSteps, ISteps, cellType, graphType)

%% Calculates the percentage of cells that fire no spikes, exactly one spike, or one or more spikes at each current step
% Danny Lasky, 8/23

%% Calculate percentage of cells that fire exactly one spike at each step (averaged across steps)
VR.Amy_WT.OneSpike = nan(nSteps,1);
VR.Amy_TR.OneSpike = nan(nSteps,1);
VR.Tau_WT.OneSpike = nan(nSteps,1);
VR.Tau_TR.OneSpike = nan(nSteps,1);
VR.Tau_WT_A.OneSpike = nan(nSteps,1);
VR.Tau_TR_A.OneSpike = nan(nSteps,1);

Si.Amy_WT.OneSpike = nan(nSteps,1);
Si.Amy_TR.OneSpike = nan(nSteps,1);
Si.Tau_WT.OneSpike = nan(nSteps,1);
Si.Tau_TR.OneSpike = nan(nSteps,1);
Si.Tau_WT_A.OneSpike = nan(nSteps,1);
Si.Tau_TR_A.OneSpike = nan(nSteps,1);

[VR.Amy_WT.OneSpikePer, VR.Amy_WT.OneSpikeN, VR.Amy_WT.OneSpikeArr]         = OneSpike(VR.Amy_WT.Steps.N, VR.Amy_WT.Count);
[VR.Amy_TR.OneSpikePer, VR.Amy_TR.OneSpikeN, VR.Amy_TR.OneSpikeArr]         = OneSpike(VR.Amy_TR.Steps.N, VR.Amy_TR.Count);
[VR.Tau_WT.OneSpikePer, VR.Tau_WT.OneSpikeN, VR.Tau_WT.OneSpikeArr]         = OneSpike(VR.Tau_WT.Steps.N, VR.Tau_WT.Count);
[VR.Tau_TR.OneSpikePer, VR.Tau_TR.OneSpikeN, VR.Tau_TR.OneSpikeArr]         = OneSpike(VR.Tau_TR.Steps.N, VR.Tau_TR.Count);
[VR.Tau_WT_A.OneSpikePer, VR.Tau_WT_A.OneSpikeN, VR.Tau_WT_A.OneSpikeArr]   = OneSpike(VR.Tau_WT_A.Steps.N, VR.Tau_WT_A.Count);
[VR.Tau_TR_A.OneSpikePer, VR.Tau_TR_A.OneSpikeN, VR.Tau_TR_A.OneSpikeArr]   = OneSpike(VR.Tau_TR_A.Steps.N, VR.Tau_TR_A.Count);

[Si.Amy_WT.OneSpikePer, Si.Amy_WT.OneSpikeN, Si.Amy_WT.OneSpikeArr]         = OneSpike(Si.Amy_WT.Steps.N, Si.Amy_WT.Count);
[Si.Amy_TR.OneSpikePer, Si.Amy_TR.OneSpikeN, Si.Amy_TR.OneSpikeArr]         = OneSpike(Si.Amy_TR.Steps.N, Si.Amy_TR.Count);
[Si.Tau_WT.OneSpikePer, Si.Tau_WT.OneSpikeN, Si.Tau_WT.OneSpikeArr]         = OneSpike(Si.Tau_WT.Steps.N, Si.Tau_WT.Count);
[Si.Tau_TR.OneSpikePer, Si.Tau_TR.OneSpikeN, Si.Tau_TR.OneSpikeArr]         = OneSpike(Si.Tau_TR.Steps.N, Si.Tau_TR.Count);
[Si.Tau_WT_A.OneSpikePer, Si.Tau_WT_A.OneSpikeN, Si.Tau_WT_A.OneSpikeArr]   = OneSpike(Si.Tau_WT_A.Steps.N, Si.Tau_WT_A.Count);
[Si.Tau_TR_A.OneSpikePer, Si.Tau_TR_A.OneSpikeN, Si.Tau_TR_A.OneSpikeArr]   = OneSpike(Si.Tau_TR_A.Steps.N, Si.Tau_TR_A.Count);

VR.Amy_WT.OneSpikeCol = reshape(VR.Amy_WT.OneSpikeArr, 1, [])';
VR.Amy_TR.OneSpikeCol = reshape(VR.Amy_TR.OneSpikeArr, 1, [])';
VR.Tau_WT.OneSpikeCol = reshape(VR.Tau_WT.OneSpikeArr, 1, [])';
VR.Tau_TR.OneSpikeCol = reshape(VR.Tau_TR.OneSpikeArr, 1, [])';
VR.Tau_WT_A.OneSpikeCol = reshape(VR.Tau_WT_A.OneSpikeArr, 1, [])';
VR.Tau_TR_A.OneSpikeCol = reshape(VR.Tau_TR_A.OneSpikeArr, 1, [])';

Si.Amy_WT.OneSpikeCol = reshape(Si.Amy_WT.OneSpikeArr, 1, [])';
Si.Amy_TR.OneSpikeCol = reshape(Si.Amy_TR.OneSpikeArr, 1, [])';
Si.Tau_WT.OneSpikeCol = reshape(Si.Tau_WT.OneSpikeArr, 1, [])';
Si.Tau_TR.OneSpikeCol = reshape(Si.Tau_TR.OneSpikeArr, 1, [])';
Si.Tau_WT_A.OneSpikeCol = reshape(Si.Tau_WT_A.OneSpikeArr, 1, [])';
Si.Tau_TR_A.OneSpikeCol = reshape(Si.Tau_TR_A.OneSpikeArr, 1, [])';

%% Graph exactly one spike
if graphType == "All"
    figure('Units', 'inch', 'Position', [0.5 1.5 10.5 9])
    t = tiledlayout(2,2);
    title(t, 'Exactly One Spike By Current Injection', 'FontSize', 24)
    
    t1 = nexttile;
        plot(ISteps, VR.Tau_WT.OneSpikePer, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Tau_TR.OneSpikePer, 'r', 'LineWidth', 2)
        plot(ISteps, VR.Tau_WT_A.OneSpikePer, 'g', 'LineWidth', 2)
        plot(ISteps, VR.Tau_TR_A.OneSpikePer, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('Exactly One Spike (%)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'northwest', 'FontSize', 12)
    t2 = nexttile;
        plot(ISteps, VR.Amy_WT.OneSpikePer, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Amy_TR.OneSpikePer, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('Exactly One Spike (%)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 12)
    t3 = nexttile;
        plot(ISteps, Si.Tau_WT.OneSpikePer, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Tau_TR.OneSpikePer, 'r', 'LineWidth', 2)
        plot(ISteps, Si.Tau_WT_A.OneSpikePer, 'g', 'LineWidth', 2)
        plot(ISteps, Si.Tau_TR_A.OneSpikePer, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('Exactly One Spike (%)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'northwest', 'FontSize', 12)
    t4 = nexttile;
        plot(ISteps, Si.Amy_WT.OneSpikePer, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Amy_TR.OneSpikePer, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('Exactly One Spike (%)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 12)
    saveas(gcf, "Exactly One Spike By Step" + " " + cellType + ".png")
end

%% Calculate percentage of cells that fire one plus spikes at each step (averaged across steps)
VR.Amy_WT.OnePlusSpike = nan(nSteps,1);
VR.Amy_TR.OnePlusSpike = nan(nSteps,1);
VR.Tau_WT.OnePlusSpike = nan(nSteps,1);
VR.Tau_TR.OnePlusSpike = nan(nSteps,1);
VR.Tau_WT_A.OnePlusSpike = nan(nSteps,1);
VR.Tau_TR_A.OnePlusSpike = nan(nSteps,1);

Si.Amy_WT.OnePlusSpike = nan(nSteps,1);
Si.Amy_TR.OnePlusSpike = nan(nSteps,1);
Si.Tau_WT.OnePlusSpike = nan(nSteps,1);
Si.Tau_TR.OnePlusSpike = nan(nSteps,1);
Si.Tau_WT_A.OnePlusSpike = nan(nSteps,1);
Si.Tau_TR_A.OnePlusSpike = nan(nSteps,1);

[VR.Amy_WT.OnePlusSpikePer, VR.Amy_WT.OnePlusSpikeN, VR.Amy_WT.OnePlusSpikeArr]         = OnePlusSpike(VR.Amy_WT.Steps.N, VR.Amy_WT.Count);
[VR.Amy_TR.OnePlusSpikePer, VR.Amy_TR.OnePlusSpikeN, VR.Amy_TR.OnePlusSpikeArr]         = OnePlusSpike(VR.Amy_TR.Steps.N, VR.Amy_TR.Count);
[VR.Tau_WT.OnePlusSpikePer, VR.Tau_WT.OnePlusSpikeN, VR.Tau_WT.OnePlusSpikeArr]         = OnePlusSpike(VR.Tau_WT.Steps.N, VR.Tau_WT.Count);
[VR.Tau_TR.OnePlusSpikePer, VR.Tau_TR.OnePlusSpikeN, VR.Tau_TR.OnePlusSpikeArr]         = OnePlusSpike(VR.Tau_TR.Steps.N, VR.Tau_TR.Count);
[VR.Tau_WT_A.OnePlusSpikePer, VR.Tau_WT_A.OnePlusSpikeN, VR.Tau_WT_A.OnePlusSpikeArr]   = OnePlusSpike(VR.Tau_WT_A.Steps.N, VR.Tau_WT_A.Count);
[VR.Tau_TR_A.OnePlusSpikePer, VR.Tau_TR_A.OnePlusSpikeN, VR.Tau_TR_A.OnePlusSpikeArr]   = OnePlusSpike(VR.Tau_TR_A.Steps.N, VR.Tau_TR_A.Count);

[Si.Amy_WT.OnePlusSpikePer, Si.Amy_WT.OnePlusSpikeN, Si.Amy_WT.OnePlusSpikeArr]         = OnePlusSpike(Si.Amy_WT.Steps.N, Si.Amy_WT.Count);
[Si.Amy_TR.OnePlusSpikePer, Si.Amy_TR.OnePlusSpikeN, Si.Amy_TR.OnePlusSpikeArr]         = OnePlusSpike(Si.Amy_TR.Steps.N, Si.Amy_TR.Count);
[Si.Tau_WT.OnePlusSpikePer, Si.Tau_WT.OnePlusSpikeN, Si.Tau_WT.OnePlusSpikeArr]         = OnePlusSpike(Si.Tau_WT.Steps.N, Si.Tau_WT.Count);
[Si.Tau_TR.OnePlusSpikePer, Si.Tau_TR.OnePlusSpikeN, Si.Tau_TR.OnePlusSpikeArr]         = OnePlusSpike(Si.Tau_TR.Steps.N, Si.Tau_TR.Count);
[Si.Tau_WT_A.OnePlusSpikePer, Si.Tau_WT_A.OnePlusSpikeN, Si.Tau_WT_A.OnePlusSpikeArr]   = OnePlusSpike(Si.Tau_WT_A.Steps.N, Si.Tau_WT_A.Count);
[Si.Tau_TR_A.OnePlusSpikePer, Si.Tau_TR_A.OnePlusSpikeN, Si.Tau_TR_A.OnePlusSpikeArr]   = OnePlusSpike(Si.Tau_TR_A.Steps.N, Si.Tau_TR_A.Count);

VR.Amy_WT.OnePlusSpikeCol = reshape(VR.Amy_WT.OnePlusSpikeArr, 1, [])';
VR.Amy_TR.OnePlusSpikeCol = reshape(VR.Amy_TR.OnePlusSpikeArr, 1, [])';
VR.Tau_WT.OnePlusSpikeCol = reshape(VR.Tau_WT.OnePlusSpikeArr, 1, [])';
VR.Tau_TR.OnePlusSpikeCol = reshape(VR.Tau_TR.OnePlusSpikeArr, 1, [])';
VR.Tau_WT_A.OnePlusSpikeCol = reshape(VR.Tau_WT_A.OnePlusSpikeArr, 1, [])';
VR.Tau_TR_A.OnePlusSpikeCol = reshape(VR.Tau_TR_A.OnePlusSpikeArr, 1, [])';

Si.Amy_WT.OnePlusSpikeCol = reshape(Si.Amy_WT.OnePlusSpikeArr, 1, [])';
Si.Amy_TR.OnePlusSpikeCol = reshape(Si.Amy_TR.OnePlusSpikeArr, 1, [])';
Si.Tau_WT.OnePlusSpikeCol = reshape(Si.Tau_WT.OnePlusSpikeArr, 1, [])';
Si.Tau_TR.OnePlusSpikeCol = reshape(Si.Tau_TR.OnePlusSpikeArr, 1, [])';
Si.Tau_WT_A.OnePlusSpikeCol = reshape(Si.Tau_WT_A.OnePlusSpikeArr, 1, [])';
Si.Tau_TR_A.OnePlusSpikeCol = reshape(Si.Tau_TR_A.OnePlusSpikeArr, 1, [])';

%% Graph one plus spikes
if graphType == "All"
    figure('Units', 'inch', 'Position', [0.5 1.5 10.5 9])
    t = tiledlayout(2,2);
    title(t, 'One or More Spikes By Step', 'FontSize', 24)
    
    t1 = nexttile;
        plot(ISteps, VR.Tau_WT.OnePlusSpikePer, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Tau_TR.OnePlusSpikePer, 'r', 'LineWidth', 2)
        plot(ISteps, VR.Tau_WT_A.OnePlusSpikePer, 'g', 'LineWidth', 2)
        plot(ISteps, VR.Tau_TR_A.OnePlusSpikePer, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'southeast', 'FontSize', 12)
    t2 = nexttile;
        plot(ISteps, VR.Amy_WT.OnePlusSpikePer, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Amy_TR.OnePlusSpikePer, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 12)
    t3 = nexttile;
        plot(ISteps, Si.Tau_WT.OnePlusSpikePer, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Tau_TR.OnePlusSpikePer, 'r', 'LineWidth', 2)
        plot(ISteps, Si.Tau_WT_A.OnePlusSpikePer, 'g', 'LineWidth', 2)
        plot(ISteps, Si.Tau_TR_A.OnePlusSpikePer, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'southeast', 'FontSize', 12)
    t4 = nexttile;
        plot(ISteps, Si.Amy_WT.OnePlusSpikePer, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Amy_TR.OnePlusSpikePer, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 12)
    saveas(gcf, "One or More Spikes By Step" + " " + cellType + ".png")
end

%% Calculate percentage of cells that fire no spikes at each step (averaged across steps)
VR.Amy_WT.NoSpike = nan(nSteps,1);
VR.Amy_TR.NoSpike = nan(nSteps,1);
VR.Tau_WT.NoSpike = nan(nSteps,1);
VR.Tau_TR.NoSpike = nan(nSteps,1);
VR.Tau_WT_A.NoSpike = nan(nSteps,1);
VR.Tau_TR_A.NoSpike = nan(nSteps,1);

Si.Amy_WT.NoSpike = nan(nSteps,1);
Si.Amy_TR.NoSpike = nan(nSteps,1);
Si.Tau_WT.NoSpike = nan(nSteps,1);
Si.Tau_TR.NoSpike = nan(nSteps,1);
Si.Tau_WT_A.NoSpike = nan(nSteps,1);
Si.Tau_TR_A.NoSpike = nan(nSteps,1);

VR.Amy_WT.NoSpike = NoSpike(VR.Amy_WT.Steps.N, VR.Amy_WT.Count);
VR.Amy_TR.NoSpike = NoSpike(VR.Amy_TR.Steps.N, VR.Amy_TR.Count);
VR.Tau_WT.NoSpike = NoSpike(VR.Tau_WT.Steps.N, VR.Tau_WT.Count);
VR.Tau_TR.NoSpike = NoSpike(VR.Tau_TR.Steps.N, VR.Tau_TR.Count);
VR.Tau_WT_A.NoSpike = NoSpike(VR.Tau_WT_A.Steps.N, VR.Tau_WT_A.Count);
VR.Tau_TR_A.NoSpike = NoSpike(VR.Tau_TR_A.Steps.N, VR.Tau_TR_A.Count);

Si.Amy_WT.NoSpike = NoSpike(Si.Amy_WT.Steps.N, Si.Amy_WT.Count);
Si.Amy_TR.NoSpike = NoSpike(Si.Amy_TR.Steps.N, Si.Amy_TR.Count);
Si.Tau_WT.NoSpike = NoSpike(Si.Tau_WT.Steps.N, Si.Tau_WT.Count);
Si.Tau_TR.NoSpike = NoSpike(Si.Tau_TR.Steps.N, Si.Tau_TR.Count);
Si.Tau_WT_A.NoSpike = NoSpike(Si.Tau_WT_A.Steps.N, Si.Tau_WT_A.Count);
Si.Tau_TR_A.NoSpike = NoSpike(Si.Tau_TR_A.Steps.N, Si.Tau_TR_A.Count);

%% Graph no spikes
if graphType == "All"
    figure('Units', 'inch', 'Position', [0.5 1.5 10.5 9])
    t = tiledlayout(2,2);
    title(t, 'No Spikes By Step', 'FontSize', 24)
    
    t1 = nexttile;
        plot(ISteps, VR.Tau_WT.NoSpike, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Tau_TR.NoSpike, 'r', 'LineWidth', 2)
        plot(ISteps, VR.Tau_WT_A.NoSpike, 'g', 'LineWidth', 2)
        plot(ISteps, VR.Tau_TR_A.NoSpike, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('No Spikes (%)')
        t1.XAxis.FontSize = 14;
        t1.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'northeast', 'FontSize', 12)
    t2 = nexttile;
        plot(ISteps, VR.Amy_WT.NoSpike, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, VR.Amy_TR.NoSpike, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('No Spikes (%)')
        t2.XAxis.FontSize = 14;
        t2.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northeast', 'FontSize', 12)
    t3 = nexttile;
        plot(ISteps, Si.Tau_WT.NoSpike, 'k', 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Tau_TR.NoSpike, 'r', 'LineWidth', 2)
        plot(ISteps, Si.Tau_WT_A.NoSpike, 'g', 'LineWidth', 2)
        plot(ISteps, Si.Tau_TR_A.NoSpike, 'b', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('No Spikes (%)')
        t3.XAxis.FontSize = 14;
        t3.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Tau WT', 'Tau Tg', 'Tau WT AR', 'Tau Tg AR', 'Location', 'northeast', 'FontSize', 12)
    t4 = nexttile;
        plot(ISteps, Si.Amy_WT.NoSpike, 'Color', [.3 .7 .9], 'LineWidth', 2)
        hold on
        plot(ISteps, Si.Amy_TR.NoSpike, 'm', 'LineWidth', 2)
        xlabel('Injected Current (pA)')
        ylabel('No Spikes (%)')
        t4.XAxis.FontSize = 14;
        t4.YAxis.FontSize = 14;
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
        legend('Amy WT', 'Amy Tg', 'Location', 'northeast', 'FontSize', 12)
    saveas(gcf, "No Spikes By Step" + " " + cellType + ".png")
end

%% Create graphical inset with one plus spikes (bigger) and one spike (inset)
if graphType == "All" || graphType == "Inset"
    figure('Units', 'inch', 'Position',  [1.5 1.5 6 5])
    t = tiledlayout(2,2);
    % title(t, 'One or More Spikes By Current Injection', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    
    t1 = nexttile;
        plot(ISteps, VR.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_WT_A.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau at Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        leg = legend('Tau WT', 'Tau WT AR', 'Tau Tg', 'Tau Tg AR', 'Position', [0.131, 0.802, 0.12789, 0.11979], 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [5, 5];
    t2 = nexttile;
        plot(ISteps, VR.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        leg = legend('Amy WT', 'Amy Tg', 'Position', [0.589, 0.858, 0.101851, 0.06354], 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [5, 5];
    t3 = nexttile;
        plot(ISteps, Si.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_TR.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_WT_A.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Tau at −60 mV', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    t4 = nexttile;
        plot(ISteps, Si.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Amy_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlim([min(ISteps) max(ISteps)])
        ylim([0 100])
        title('Amyloid at −60 mV', 'FontSize', 10, 'FontWeight', 'Normal')
    
    ax1 = axes('Position',[.33 .625 .1 .1]);
        plot(ISteps, VR.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_TR.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_WT_A.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        ylabel('One Spike (%)')
        xticks([-100, 480])
        yticks([0, 70])
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        ax1.XAxis.FontSize = 8;
        ax1.YAxis.FontSize = 8;
    ax2 = axes('Position',[.785 .625 .1 .1]);
        plot(ISteps, VR.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        ylabel('One Spike (%)')
        xticks([-100, 480])
        yticks([0, 70])
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        ax2.XAxis.FontSize = 8;
        ax2.YAxis.FontSize = 8;
    ax3 = axes('Position',[.33 .15 .1 .1]);
        plot(ISteps, Si.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_TR.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_WT_A.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        ylabel('One Spike (%)')
        xticks([-100, 480])
        yticks([0, 70])
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        ax3.XAxis.FontSize = 8;
        ax3.YAxis.FontSize = 8;
    ax4 = axes('Position',[.785 .15 .1 .1]);
        plot(ISteps, Si.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        ylabel('One Spike (%)')
        xticks([-100, 480])
        yticks([0, 70])
        xlim([min(ISteps) max(ISteps)])
        ylim([0 70])
        ax4.XAxis.FontSize = 8;
        ax4.YAxis.FontSize = 8;
    exportgraphics(gcf, "One Spike Inset.png", 'Resolution', 300)
end

%% Create graphs for just tau
if graphType == "All" || graphType == "Tau"
    figure('Units', 'inch', 'Position',  [1.5 1.5 6.4 5.8])
    t = tiledlayout(2,2);
    
    t1 = nexttile;
        plot(ISteps, VR.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_WT_A.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('At Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        leg = legend('WT', 'WT+AR', 'Tg', 'Tg+AR', 'Location', 'Best', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [20, 20];
    t2 = nexttile;
        plot(ISteps, Si.Tau_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_WT_A.OnePlusSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OnePlusSpikePer, 'Color', [.7 .7 0])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('Holding at −60 mV', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    t3 = nexttile;
        plot(ISteps, VR.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Tau_WT_A.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, VR.Tau_TR.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, VR.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        ylabel('Exactly One Spike (%)')
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('At Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    t4 = nexttile;
        plot(ISteps, Si.Tau_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Tau_WT_A.OneSpikePer, 'Color', [.7 0 .7])
        plot(ISteps, Si.Tau_TR.OneSpikePer, 'Color', [0 .7 .7])
        plot(ISteps, Si.Tau_TR_A.OneSpikePer, 'Color', [.7 .7 0])
        ylabel('Exactly One Spike (%)')
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('Holding at −60 mV', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    exportgraphics(gcf, "One Spike Tau.pdf", 'Resolution', 300)
end

%% Create graphs for just amy
if graphType == "All" || graphType == "Amy"
    figure('Units', 'inch', 'Position',  [1.5 1.5 6.4 5.8])
    t = tiledlayout(2,2);
    
    t1 = nexttile;
        plot(ISteps, VR.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t1.XAxis.FontSize = 8;
        t1.YAxis.FontSize = 8;
        t1.XAxis.FontName = 'Arial';
        t1.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('At Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
        leg = legend('Amy WT', 'Amy Tg', 'Location', 'northwest', 'FontSize', 8, 'FontName', 'Arial');
        legend('boxoff')
        leg.ItemTokenSize = [20, 20];
    t2 = nexttile;
        plot(ISteps, Si.Amy_WT.OnePlusSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Amy_TR.OnePlusSpikePer, 'Color', [0 .7 .7])
        xlabel('Injected Current (pA)')
        ylabel('One or More Spikes (%)')
        t2.XAxis.FontSize = 8;
        t2.YAxis.FontSize = 8;
        t2.XAxis.FontName = 'Arial';
        t2.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('Holding at −60 mV', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    t3 = nexttile;
        plot(ISteps, VR.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, VR.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        ylabel('Exactly One Spike (%)')
        t3.XAxis.FontSize = 8;
        t3.YAxis.FontSize = 8;
        t3.XAxis.FontName = 'Arial';
        t3.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('At Resting Potential', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    t4 = nexttile;
        plot(ISteps, Si.Amy_WT.OneSpikePer, 'k')
        hold on; box off
        plot(ISteps, Si.Amy_TR.OneSpikePer, 'Color', [0 .7 .7])
        ylabel('Exactly One Spike (%)')
        t4.XAxis.FontSize = 8;
        t4.YAxis.FontSize = 8;
        t4.XAxis.FontName = 'Arial';
        t4.YAxis.FontName = 'Arial';
        xlim([0 max(ISteps)])
        ylim([0 100])
        title('Holding at −60 mV', 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
    exportgraphics(gcf, "One Spike Amy.pdf", 'Resolution', 300)
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

function [noSpike, sumMatrix, tempMatrix] = NoSpike(inputMatrix, cellCount)
    tempMatrix = cell2mat(inputMatrix');
    fillMatrix = tempMatrix;
    fillMatrix(tempMatrix == 0) = 1;
    fillMatrix(tempMatrix ~= 0) = 0;
    sumMatrix = sum(fillMatrix, 2);
    noSpike = sumMatrix/cellCount * 100;
end

