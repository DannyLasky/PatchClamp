function MyBoxPlot(figCount, tileCount, figSize, figTitles, tileTitles, graphX, graphY, xLimits, xTicks, yLimits, yLimitType, xLabels, yLabels)

%% Function for making customizable box plots
% Danny Lasky, 8/23

for n = 1:figCount
    figure('Units', 'inch', 'Position', figSize)
    if tileCount == 1
        tiledlayout(11);
    elseif tileCount == 2
        tiledlayout(1, 2);
    elseif tileCount == 3
        tiledlayout(3,1);
    elseif tileCount == 4
        tiledlayout(2,2);
    elseif tileCount == 6
        tiledlayout(3, 2, 'TileSpacing', 'compact');
    elseif tileCount == 8
        tiledlayout(2, 4);
    end

    for m = 1:tileCount
        tile = nexttile;

        filt1 = graphX{m} == 1;
        filt2 = graphX{m} == 2;
        filt3 = graphX{m} == 3;
        filt4 = graphX{m} == 4;

        boxchart(graphX{m}, graphY{m, n}, 'MarkerStyle', 'None', 'BoxFaceColor', 'k', 'BoxFaceAlpha', 0)
        hold on
        swarmchart(graphX{m}(filt1), graphY{m, n}(filt1), 8, 'k', 'MarkerFaceColor', 'k', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        swarmchart(graphX{m}(filt2), graphY{m, n}(filt2), 8, [.7 0 .7], 'MarkerFaceColor', [.7 0 .7], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        swarmchart(graphX{m}(filt3), graphY{m, n}(filt3), 8, [0 .7 .7], 'MarkerFaceColor', [0 .7 .7], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        swarmchart(graphX{m}(filt4), graphY{m, n}(filt4), 8, [.7 .7 0], 'MarkerFaceColor', [.7 .7 0], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0)
        xlim(xLimits);
        if yLimitType == "Tile"
            ylim([yLimits(m, 1), yLimits(m, 2)])
        elseif yLimitType == "Figure"
            ylim([yLimits(n, 1), yLimits(n, 2)])
        end
        tile.XAxis.FontSize = 8;
        tile.YAxis.FontSize = 8;
        tile.XAxis.FontName = 'Arial';
        tile.YAxis.FontName = 'Arial';
        if tileTitles ~= "Off"
            if m < 3                    % Modified for producing final paper figures; you may want to remove this for your purposes
                title(tileTitles((n-1)*tileCount + m), 'FontSize', 10, 'FontName', 'Arial', 'FontWeight', 'Normal')
            end
        end
        xticks(xTicks)
        xticklabels(xLabels)
        xtickangle(0)
        ylabel(yLabels(m), 'FontSize', 8, 'FontName', 'Arial')
    end
    exportgraphics(gcf, figTitles(n) + ".pdf", 'Resolution', 300)
end