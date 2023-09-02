function [VR, Si] = CCIV_GraphSteps(VR, Si, nSteps, ISteps, cellType, graphType)

%% Create plots for spike count, interval ratio, timing, peak, and width across all current steps
% Danny Lasky, 8/23

%% Prepare variables for all groups
VR.Amy_WT.ByStep.N              = cell(nSteps,1);
VR.Amy_WT.ByStep.NMn            = zeros(nSteps,1);
VR.Amy_WT.ByStep.NSEM           = zeros(nSteps,1);
VR.Amy_WT.ByStep.IntRatio       = cell(nSteps,1);
VR.Amy_WT.ByStep.IntRatioMn     = zeros(nSteps,1);
VR.Amy_WT.ByStep.IntRatioSEM    = zeros(nSteps,1);
VR.Amy_WT.ByStep.Latency        = cell(nSteps,1);
VR.Amy_WT.ByStep.LatencyMn      = zeros(nSteps,1);
VR.Amy_WT.ByStep.LatencySEM     = zeros(nSteps,1);
VR.Amy_WT.ByStep.Peak           = cell(nSteps,1);
VR.Amy_WT.ByStep.PeakMn         = zeros(nSteps,1);
VR.Amy_WT.ByStep.PeakSEM        = zeros(nSteps,1);
VR.Amy_WT.ByStep.Width          = cell(nSteps,1);
VR.Amy_WT.ByStep.WidthMn        = zeros(nSteps,1);
VR.Amy_WT.ByStep.WidthSEM       = zeros(nSteps,1);

VR.Amy_TR.ByStep.N              = cell(nSteps,1);
VR.Amy_TR.ByStep.NMn            = zeros(nSteps,1);
VR.Amy_TR.ByStep.NSEM           = zeros(nSteps,1);
VR.Amy_TR.ByStep.IntRatio       = cell(nSteps,1);
VR.Amy_TR.ByStep.IntRatioMn     = zeros(nSteps,1);
VR.Amy_TR.ByStep.IntRatioSEM    = zeros(nSteps,1);
VR.Amy_TR.ByStep.Latency        = cell(nSteps,1);
VR.Amy_TR.ByStep.LatencyMn      = zeros(nSteps,1);
VR.Amy_TR.ByStep.LatencySEM     = zeros(nSteps,1);
VR.Amy_TR.ByStep.Peak           = cell(nSteps,1);
VR.Amy_TR.ByStep.PeakMn         = zeros(nSteps,1);
VR.Amy_TR.ByStep.PeakSEM        = zeros(nSteps,1);
VR.Amy_TR.ByStep.Width          = cell(nSteps,1);
VR.Amy_TR.ByStep.WidthMn        = zeros(nSteps,1);
VR.Amy_TR.ByStep.WidthSEM       = zeros(nSteps,1);

VR.Tau_WT.ByStep.N              = cell(nSteps,1);
VR.Tau_WT.ByStep.NMn            = zeros(nSteps,1);
VR.Tau_WT.ByStep.NSEM           = zeros(nSteps,1);
VR.Tau_WT.ByStep.IntRatio       = cell(nSteps,1);
VR.Tau_WT.ByStep.IntRatioMn     = zeros(nSteps,1);
VR.Tau_WT.ByStep.IntRatioSEM    = zeros(nSteps,1);
VR.Tau_WT.ByStep.Latency        = cell(nSteps,1);
VR.Tau_WT.ByStep.LatencyMn      = zeros(nSteps,1);
VR.Tau_WT.ByStep.LatencySEM     = zeros(nSteps,1);
VR.Tau_WT.ByStep.Peak           = cell(nSteps,1);
VR.Tau_WT.ByStep.PeakMn         = zeros(nSteps,1);
VR.Tau_WT.ByStep.PeakSEM        = zeros(nSteps,1);
VR.Tau_WT.ByStep.Width          = cell(nSteps,1);
VR.Tau_WT.ByStep.WidthMn        = zeros(nSteps,1);
VR.Tau_WT.ByStep.WidthSEM       = zeros(nSteps,1);

VR.Tau_TR.ByStep.N              = cell(nSteps,1);
VR.Tau_TR.ByStep.NMn            = zeros(nSteps,1);
VR.Tau_TR.ByStep.NSEM           = zeros(nSteps,1);
VR.Tau_TR.ByStep.IntRatio       = cell(nSteps,1);
VR.Tau_TR.ByStep.IntRatioMn     = zeros(nSteps,1);
VR.Tau_TR.ByStep.IntRatioSEM    = zeros(nSteps,1);
VR.Tau_TR.ByStep.Latency        = cell(nSteps,1);
VR.Tau_TR.ByStep.LatencyMn      = zeros(nSteps,1);
VR.Tau_TR.ByStep.LatencySEM     = zeros(nSteps,1);
VR.Tau_TR.ByStep.Peak           = cell(nSteps,1);
VR.Tau_TR.ByStep.PeakMn         = zeros(nSteps,1);
VR.Tau_TR.ByStep.PeakSEM        = zeros(nSteps,1);
VR.Tau_TR.ByStep.Width          = cell(nSteps,1);
VR.Tau_TR.ByStep.WidthMn        = zeros(nSteps,1);
VR.Tau_TR.ByStep.WidthSEM       = zeros(nSteps,1);

VR.Tau_WT_A.ByStep.N            = cell(nSteps,1);
VR.Tau_WT_A.ByStep.NMn          = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.NSEM         = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.IntRatio     = cell(nSteps,1);
VR.Tau_WT_A.ByStep.IntRatioMn   = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.IntRatioSEM  = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.Latency      = cell(nSteps,1);
VR.Tau_WT_A.ByStep.LatencyMn    = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.LatencySEM   = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.Peak         = cell(nSteps,1);
VR.Tau_WT_A.ByStep.PeakMn       = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.PeakSEM      = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.Width        = cell(nSteps,1);
VR.Tau_WT_A.ByStep.WidthMn      = zeros(nSteps,1);
VR.Tau_WT_A.ByStep.WidthSEM     = zeros(nSteps,1);

VR.Tau_TR_A.ByStep.N            = cell(nSteps,1);
VR.Tau_TR_A.ByStep.NMn          = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.NSEM         = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.IntRatio     = cell(nSteps,1);
VR.Tau_TR_A.ByStep.IntRatioMn   = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.IntRatioSEM  = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.Latency      = cell(nSteps,1);
VR.Tau_TR_A.ByStep.LatencyMn    = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.LatencySEM   = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.Peak         = cell(nSteps,1);
VR.Tau_TR_A.ByStep.PeakMn       = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.PeakSEM      = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.Width        = cell(nSteps,1);
VR.Tau_TR_A.ByStep.WidthMn      = zeros(nSteps,1);
VR.Tau_TR_A.ByStep.WidthSEM     = zeros(nSteps,1);

Si.Amy_WT.ByStep.N              = cell(nSteps,1);
Si.Amy_WT.ByStep.NMn            = zeros(nSteps,1);
Si.Amy_WT.ByStep.NSEM           = zeros(nSteps,1);
Si.Amy_WT.ByStep.IntRatio       = cell(nSteps,1);
Si.Amy_WT.ByStep.IntRatioMn     = zeros(nSteps,1);
Si.Amy_WT.ByStep.IntRatioSEM    = zeros(nSteps,1);
Si.Amy_WT.ByStep.Latency        = cell(nSteps,1);
Si.Amy_WT.ByStep.LatencyMn      = zeros(nSteps,1);
Si.Amy_WT.ByStep.LatencySEM     = zeros(nSteps,1);
Si.Amy_WT.ByStep.Peak           = cell(nSteps,1);
Si.Amy_WT.ByStep.PeakMn         = zeros(nSteps,1);
Si.Amy_WT.ByStep.PeakSEM        = zeros(nSteps,1);
Si.Amy_WT.ByStep.Width          = cell(nSteps,1);
Si.Amy_WT.ByStep.WidthMn        = zeros(nSteps,1);
Si.Amy_WT.ByStep.WidthSEM       = zeros(nSteps,1);

Si.Amy_TR.ByStep.N              = cell(nSteps,1);
Si.Amy_TR.ByStep.NMn            = zeros(nSteps,1);
Si.Amy_TR.ByStep.NSEM           = zeros(nSteps,1);
Si.Amy_TR.ByStep.IntRatio       = cell(nSteps,1);
Si.Amy_TR.ByStep.IntRatioMn     = zeros(nSteps,1);
Si.Amy_TR.ByStep.IntRatioSEM    = zeros(nSteps,1);
Si.Amy_TR.ByStep.Latency        = cell(nSteps,1);
Si.Amy_TR.ByStep.LatencyMn      = zeros(nSteps,1);
Si.Amy_TR.ByStep.LatencySEM     = zeros(nSteps,1);
Si.Amy_TR.ByStep.Peak           = cell(nSteps,1);
Si.Amy_TR.ByStep.PeakMn         = zeros(nSteps,1);
Si.Amy_TR.ByStep.PeakSEM        = zeros(nSteps,1);
Si.Amy_TR.ByStep.Width          = cell(nSteps,1);
Si.Amy_TR.ByStep.WidthMn        = zeros(nSteps,1);
Si.Amy_TR.ByStep.WidthSEM       = zeros(nSteps,1);

Si.Tau_WT.ByStep.N              = cell(nSteps,1);
Si.Tau_WT.ByStep.NMn            = zeros(nSteps,1);
Si.Tau_WT.ByStep.NSEM           = zeros(nSteps,1);
Si.Tau_WT.ByStep.IntRatio       = cell(nSteps,1);
Si.Tau_WT.ByStep.IntRatioMn     = zeros(nSteps,1);
Si.Tau_WT.ByStep.IntRatioSEM    = zeros(nSteps,1);
Si.Tau_WT.ByStep.Latency        = cell(nSteps,1);
Si.Tau_WT.ByStep.LatencyMn      = zeros(nSteps,1);
Si.Tau_WT.ByStep.LatencySEM     = zeros(nSteps,1);
Si.Tau_WT.ByStep.Peak           = cell(nSteps,1);
Si.Tau_WT.ByStep.PeakMn         = zeros(nSteps,1);
Si.Tau_WT.ByStep.PeakSEM        = zeros(nSteps,1);
Si.Tau_WT.ByStep.Width          = cell(nSteps,1);
Si.Tau_WT.ByStep.WidthMn        = zeros(nSteps,1);
Si.Tau_WT.ByStep.WidthSEM       = zeros(nSteps,1);

Si.Tau_TR.ByStep.N              = cell(nSteps,1);
Si.Tau_TR.ByStep.NMn            = zeros(nSteps,1);
Si.Tau_TR.ByStep.NSEM           = zeros(nSteps,1);
Si.Tau_TR.ByStep.IntRatio       = cell(nSteps,1);
Si.Tau_TR.ByStep.IntRatioMn     = zeros(nSteps,1);
Si.Tau_TR.ByStep.IntRatioSEM    = zeros(nSteps,1);
Si.Tau_TR.ByStep.Latency        = cell(nSteps,1);
Si.Tau_TR.ByStep.LatencyMn      = zeros(nSteps,1);
Si.Tau_TR.ByStep.LatencySEM     = zeros(nSteps,1);
Si.Tau_TR.ByStep.Peak           = cell(nSteps,1);
Si.Tau_TR.ByStep.PeakMn         = zeros(nSteps,1);
Si.Tau_TR.ByStep.PeakSEM        = zeros(nSteps,1);
Si.Tau_TR.ByStep.Width          = cell(nSteps,1);
Si.Tau_TR.ByStep.WidthMn        = zeros(nSteps,1);
Si.Tau_TR.ByStep.WidthSEM       = zeros(nSteps,1);

Si.Tau_WT_A.ByStep.N            = cell(nSteps,1);
Si.Tau_WT_A.ByStep.NMn          = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.NSEM         = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.IntRatio     = cell(nSteps,1);
Si.Tau_WT_A.ByStep.IntRatioMn   = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.IntRatioSEM  = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.Latency      = cell(nSteps,1);
Si.Tau_WT_A.ByStep.LatencyMn    = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.LatencySEM   = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.Peak         = cell(nSteps,1);
Si.Tau_WT_A.ByStep.PeakMn       = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.PeakSEM      = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.Width        = cell(nSteps,1);
Si.Tau_WT_A.ByStep.WidthMn      = zeros(nSteps,1);
Si.Tau_WT_A.ByStep.WidthSEM     = zeros(nSteps,1);

Si.Tau_TR_A.ByStep.N            = cell(nSteps,1);
Si.Tau_TR_A.ByStep.NMn          = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.NSEM         = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.IntRatio     = cell(nSteps,1);
Si.Tau_TR_A.ByStep.IntRatioMn   = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.IntRatioSEM  = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.Latency      = cell(nSteps,1);
Si.Tau_TR_A.ByStep.LatencyMn    = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.LatencySEM   = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.Peak         = cell(nSteps,1);
Si.Tau_TR_A.ByStep.PeakMn       = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.PeakSEM      = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.Width        = cell(nSteps,1);
Si.Tau_TR_A.ByStep.WidthMn      = zeros(nSteps,1);
Si.Tau_TR_A.ByStep.WidthSEM     = zeros(nSteps,1);

%% Read in variables for all groups
for n = 1:nSteps
    for m = 1:VR.Amy_WT.Count
        VR.Amy_WT.ByStep.N{n}(m)        = VR.Amy_WT.Steps.N{m}(n);
        VR.Amy_WT.ByStep.IntRatio{n}(m) = VR.Amy_WT.Steps.IntRatio{m}(n);
        VR.Amy_WT.ByStep.Latency{n}(m)  = VR.Amy_WT.Steps.Latency{m}(n);
        VR.Amy_WT.ByStep.Peak{n}(m)     = VR.Amy_WT.Steps.Peak{m}(n);
        VR.Amy_WT.ByStep.Width{n}(m)    = VR.Amy_WT.Steps.Width{m}(n);
    end
    for m = 1:VR.Amy_TR.Count  
        VR.Amy_TR.ByStep.N{n}(m)        = VR.Amy_TR.Steps.N{m}(n);
        VR.Amy_TR.ByStep.IntRatio{n}(m) = VR.Amy_TR.Steps.IntRatio{m}(n);
        VR.Amy_TR.ByStep.Latency{n}(m)  = VR.Amy_TR.Steps.Latency{m}(n);
        VR.Amy_TR.ByStep.Peak{n}(m)     = VR.Amy_TR.Steps.Peak{m}(n);
        VR.Amy_TR.ByStep.Width{n}(m)    = VR.Amy_TR.Steps.Width{m}(n);
    end
    for m = 1:VR.Tau_WT.Count
        VR.Tau_WT.ByStep.N{n}(m)        = VR.Tau_WT.Steps.N{m}(n);
        VR.Tau_WT.ByStep.IntRatio{n}(m) = VR.Tau_WT.Steps.IntRatio{m}(n);
        VR.Tau_WT.ByStep.Latency{n}(m)  = VR.Tau_WT.Steps.Latency{m}(n);
        VR.Tau_WT.ByStep.Peak{n}(m)     = VR.Tau_WT.Steps.Peak{m}(n);
        VR.Tau_WT.ByStep.Width{n}(m)    = VR.Tau_WT.Steps.Width{m}(n);
    end
    for m = 1:VR.Tau_TR.Count  
        VR.Tau_TR.ByStep.N{n}(m)        = VR.Tau_TR.Steps.N{m}(n);
        VR.Tau_TR.ByStep.IntRatio{n}(m) = VR.Tau_TR.Steps.IntRatio{m}(n);
        VR.Tau_TR.ByStep.Latency{n}(m)  = VR.Tau_TR.Steps.Latency{m}(n);
        VR.Tau_TR.ByStep.Peak{n}(m)     = VR.Tau_TR.Steps.Peak{m}(n);
        VR.Tau_TR.ByStep.Width{n}(m)    = VR.Tau_TR.Steps.Width{m}(n);
    end
    for m = 1:VR.Tau_WT_A.Count
        VR.Tau_WT_A.ByStep.N{n}(m)        = VR.Tau_WT_A.Steps.N{m}(n);
        VR.Tau_WT_A.ByStep.IntRatio{n}(m) = VR.Tau_WT_A.Steps.IntRatio{m}(n);
        VR.Tau_WT_A.ByStep.Latency{n}(m)  = VR.Tau_WT_A.Steps.Latency{m}(n);
        VR.Tau_WT_A.ByStep.Peak{n}(m)     = VR.Tau_WT_A.Steps.Peak{m}(n);
        VR.Tau_WT_A.ByStep.Width{n}(m)    = VR.Tau_WT_A.Steps.Width{m}(n);
    end
    for m = 1:VR.Tau_TR_A.Count  
        VR.Tau_TR_A.ByStep.N{n}(m)        = VR.Tau_TR_A.Steps.N{m}(n);
        VR.Tau_TR_A.ByStep.IntRatio{n}(m) = VR.Tau_TR_A.Steps.IntRatio{m}(n);
        VR.Tau_TR_A.ByStep.Latency{n}(m)  = VR.Tau_TR_A.Steps.Latency{m}(n);
        VR.Tau_TR_A.ByStep.Peak{n}(m)     = VR.Tau_TR_A.Steps.Peak{m}(n);
        VR.Tau_TR_A.ByStep.Width{n}(m)    = VR.Tau_TR_A.Steps.Width{m}(n);
    end
    for m = 1:Si.Amy_WT.Count
        Si.Amy_WT.ByStep.N{n}(m)        = Si.Amy_WT.Steps.N{m}(n);
        Si.Amy_WT.ByStep.IntRatio{n}(m) = Si.Amy_WT.Steps.IntRatio{m}(n);
        Si.Amy_WT.ByStep.Latency{n}(m)  = Si.Amy_WT.Steps.Latency{m}(n);
        Si.Amy_WT.ByStep.Peak{n}(m)     = Si.Amy_WT.Steps.Peak{m}(n);
        Si.Amy_WT.ByStep.Width{n}(m)    = Si.Amy_WT.Steps.Width{m}(n);
    end
    for m = 1:Si.Amy_TR.Count  
        Si.Amy_TR.ByStep.N{n}(m)        = Si.Amy_TR.Steps.N{m}(n);
        Si.Amy_TR.ByStep.IntRatio{n}(m) = Si.Amy_TR.Steps.IntRatio{m}(n);
        Si.Amy_TR.ByStep.Latency{n}(m)  = Si.Amy_TR.Steps.Latency{m}(n);
        Si.Amy_TR.ByStep.Peak{n}(m)     = Si.Amy_TR.Steps.Peak{m}(n);
        Si.Amy_TR.ByStep.Width{n}(m)    = Si.Amy_TR.Steps.Width{m}(n);
    end
    for m = 1:Si.Tau_WT.Count
        Si.Tau_WT.ByStep.N{n}(m)            = Si.Tau_WT.Steps.N{m}(n);
        Si.Tau_WT.ByStep.IntRatio{n}(m)     = Si.Tau_WT.Steps.IntRatio{m}(n);
        Si.Tau_WT.ByStep.Latency{n}(m)      = Si.Tau_WT.Steps.Latency{m}(n);
        Si.Tau_WT.ByStep.Peak{n}(m)         = Si.Tau_WT.Steps.Peak{m}(n);
        Si.Tau_WT.ByStep.Width{n}(m)        = Si.Tau_WT.Steps.Width{m}(n);
    end
    for m = 1:Si.Tau_TR.Count  
        Si.Tau_TR.ByStep.N{n}(m)            = Si.Tau_TR.Steps.N{m}(n);
        Si.Tau_TR.ByStep.IntRatio{n}(m)     = Si.Tau_TR.Steps.IntRatio{m}(n);
        Si.Tau_TR.ByStep.Latency{n}(m)      = Si.Tau_TR.Steps.Latency{m}(n);
        Si.Tau_TR.ByStep.Peak{n}(m)         = Si.Tau_TR.Steps.Peak{m}(n);
        Si.Tau_TR.ByStep.Width{n}(m)        = Si.Tau_TR.Steps.Width{m}(n);
    end
    for m = 1:Si.Tau_WT_A.Count
        Si.Tau_WT_A.ByStep.N{n}(m)          = Si.Tau_WT_A.Steps.N{m}(n);
        Si.Tau_WT_A.ByStep.IntRatio{n}(m)   = Si.Tau_WT_A.Steps.IntRatio{m}(n);
        Si.Tau_WT_A.ByStep.Latency{n}(m)    = Si.Tau_WT_A.Steps.Latency{m}(n);
        Si.Tau_WT_A.ByStep.Peak{n}(m)       = Si.Tau_WT_A.Steps.Peak{m}(n);
        Si.Tau_WT_A.ByStep.Width{n}(m)      = Si.Tau_WT_A.Steps.Width{m}(n);
    end
    for m = 1:Si.Tau_TR_A.Count  
        Si.Tau_TR_A.ByStep.N{n}(m)          = Si.Tau_TR_A.Steps.N{m}(n);
        Si.Tau_TR_A.ByStep.IntRatio{n}(m)   = Si.Tau_TR_A.Steps.IntRatio{m}(n);
        Si.Tau_TR_A.ByStep.Latency{n}(m)    = Si.Tau_TR_A.Steps.Latency{m}(n);
        Si.Tau_TR_A.ByStep.Peak{n}(m)       = Si.Tau_TR_A.Steps.Peak{m}(n);
        Si.Tau_TR_A.ByStep.Width{n}(m)      = Si.Tau_TR_A.Steps.Width{m}(n);
    end
end

%% Calculate mean and standard error of the mean (SEM) for all groups
VR.Amy_WT.ByStep.NMn            = mean(cell2mat(VR.Amy_WT.ByStep.N), 2);
VR.Amy_WT.ByStep.NSEM           = std(cell2mat(VR.Amy_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.N)), 2));
VR.Amy_WT.ByStep.IntRatioMn     = mean(cell2mat(VR.Amy_WT.ByStep.IntRatio), 2, 'omitnan');
VR.Amy_WT.ByStep.IntRatioSEM    = std(cell2mat(VR.Amy_WT.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.IntRatio)), 2));
VR.Amy_WT.ByStep.LatencyMn      = mean(cell2mat(VR.Amy_WT.ByStep.Latency), 2, 'omitnan');
VR.Amy_WT.ByStep.LatencySEM     = std(cell2mat(VR.Amy_WT.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.Latency)), 2));
VR.Amy_WT.ByStep.PeakMn         = mean(cell2mat(VR.Amy_WT.ByStep.Peak), 2, 'omitnan');
VR.Amy_WT.ByStep.PeakSEM        = std(cell2mat(VR.Amy_WT.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.Peak)), 2));
VR.Amy_WT.ByStep.WidthMn        = mean(cell2mat(VR.Amy_WT.ByStep.Width), 2, 'omitnan');
VR.Amy_WT.ByStep.WidthSEM       = std(cell2mat(VR.Amy_WT.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_WT.ByStep.Width)), 2));

VR.Amy_TR.ByStep.NMn            = mean(cell2mat(VR.Amy_TR.ByStep.N), 2);
VR.Amy_TR.ByStep.NSEM           = std(cell2mat(VR.Amy_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.N)), 2));
VR.Amy_TR.ByStep.IntRatioMn     = mean(cell2mat(VR.Amy_TR.ByStep.IntRatio), 2, 'omitnan');
VR.Amy_TR.ByStep.IntRatioSEM    = std(cell2mat(VR.Amy_TR.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.IntRatio)), 2));
VR.Amy_TR.ByStep.LatencyMn      = mean(cell2mat(VR.Amy_TR.ByStep.Latency), 2, 'omitnan');
VR.Amy_TR.ByStep.LatencySEM     = std(cell2mat(VR.Amy_TR.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.Latency)), 2));
VR.Amy_TR.ByStep.PeakMn         = mean(cell2mat(VR.Amy_TR.ByStep.Peak), 2, 'omitnan');
VR.Amy_TR.ByStep.PeakSEM        = std(cell2mat(VR.Amy_TR.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.Peak)), 2));
VR.Amy_TR.ByStep.WidthMn        = mean(cell2mat(VR.Amy_TR.ByStep.Width), 2, 'omitnan');
VR.Amy_TR.ByStep.WidthSEM       = std(cell2mat(VR.Amy_TR.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Amy_TR.ByStep.Width)), 2));

VR.Tau_WT.ByStep.NMn            = mean(cell2mat(VR.Tau_WT.ByStep.N), 2);
VR.Tau_WT.ByStep.NSEM           = std(cell2mat(VR.Tau_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.N)), 2));
VR.Tau_WT.ByStep.IntRatioMn     = mean(cell2mat(VR.Tau_WT.ByStep.IntRatio), 2, 'omitnan');
VR.Tau_WT.ByStep.IntRatioSEM    = std(cell2mat(VR.Tau_WT.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.IntRatio)), 2));
VR.Tau_WT.ByStep.LatencyMn      = mean(cell2mat(VR.Tau_WT.ByStep.Latency), 2, 'omitnan');
VR.Tau_WT.ByStep.LatencySEM     = std(cell2mat(VR.Tau_WT.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.Latency)), 2));
VR.Tau_WT.ByStep.PeakMn         = mean(cell2mat(VR.Tau_WT.ByStep.Peak), 2, 'omitnan');
VR.Tau_WT.ByStep.PeakSEM        = std(cell2mat(VR.Tau_WT.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.Peak)), 2));
VR.Tau_WT.ByStep.WidthMn        = mean(cell2mat(VR.Tau_WT.ByStep.Width), 2, 'omitnan');
VR.Tau_WT.ByStep.WidthSEM       = std(cell2mat(VR.Tau_WT.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT.ByStep.Width)), 2));

VR.Tau_TR.ByStep.NMn            = mean(cell2mat(VR.Tau_TR.ByStep.N), 2);
VR.Tau_TR.ByStep.NSEM           = std(cell2mat(VR.Tau_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.N)), 2));
VR.Tau_TR.ByStep.IntRatioMn     = mean(cell2mat(VR.Tau_TR.ByStep.IntRatio), 2, 'omitnan');
VR.Tau_TR.ByStep.IntRatioSEM    = std(cell2mat(VR.Tau_TR.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.IntRatio)), 2));
VR.Tau_TR.ByStep.LatencyMn      = mean(cell2mat(VR.Tau_TR.ByStep.Latency), 2, 'omitnan');
VR.Tau_TR.ByStep.LatencySEM     = std(cell2mat(VR.Tau_TR.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.Latency)), 2));
VR.Tau_TR.ByStep.PeakMn         = mean(cell2mat(VR.Tau_TR.ByStep.Peak), 2, 'omitnan');
VR.Tau_TR.ByStep.PeakSEM        = std(cell2mat(VR.Tau_TR.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.Peak)), 2));
VR.Tau_TR.ByStep.WidthMn        = mean(cell2mat(VR.Tau_TR.ByStep.Width), 2, 'omitnan');
VR.Tau_TR.ByStep.WidthSEM       = std(cell2mat(VR.Tau_TR.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR.ByStep.Width)), 2));

VR.Tau_WT_A.ByStep.NMn          = mean(cell2mat(VR.Tau_WT_A.ByStep.N), 2);
VR.Tau_WT_A.ByStep.NSEM         = std(cell2mat(VR.Tau_WT_A.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.N)), 2));
VR.Tau_WT_A.ByStep.IntRatioMn   = mean(cell2mat(VR.Tau_WT_A.ByStep.IntRatio), 2, 'omitnan');
VR.Tau_WT_A.ByStep.IntRatioSEM  = std(cell2mat(VR.Tau_WT_A.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.IntRatio)), 2));
VR.Tau_WT_A.ByStep.LatencyMn    = mean(cell2mat(VR.Tau_WT_A.ByStep.Latency), 2, 'omitnan');
VR.Tau_WT_A.ByStep.LatencySEM   = std(cell2mat(VR.Tau_WT_A.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.Latency)), 2));
VR.Tau_WT_A.ByStep.PeakMn       = mean(cell2mat(VR.Tau_WT_A.ByStep.Peak), 2, 'omitnan');
VR.Tau_WT_A.ByStep.PeakSEM      = std(cell2mat(VR.Tau_WT_A.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.Peak)), 2));
VR.Tau_WT_A.ByStep.WidthMn      = mean(cell2mat(VR.Tau_WT_A.ByStep.Width), 2, 'omitnan');
VR.Tau_WT_A.ByStep.WidthSEM     = std(cell2mat(VR.Tau_WT_A.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_WT_A.ByStep.Width)), 2));

VR.Tau_TR_A.ByStep.NMn          = mean(cell2mat(VR.Tau_TR_A.ByStep.N), 2);
VR.Tau_TR_A.ByStep.NSEM         = std(cell2mat(VR.Tau_TR_A.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.N)), 2));
VR.Tau_TR_A.ByStep.IntRatioMn   = mean(cell2mat(VR.Tau_TR_A.ByStep.IntRatio), 2, 'omitnan');
VR.Tau_TR_A.ByStep.IntRatioSEM  = std(cell2mat(VR.Tau_TR_A.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.IntRatio)), 2));
VR.Tau_TR_A.ByStep.LatencyMn    = mean(cell2mat(VR.Tau_TR_A.ByStep.Latency), 2, 'omitnan');
VR.Tau_TR_A.ByStep.LatencySEM   = std(cell2mat(VR.Tau_TR_A.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.Latency)), 2));
VR.Tau_TR_A.ByStep.PeakMn       = mean(cell2mat(VR.Tau_TR_A.ByStep.Peak), 2, 'omitnan');
VR.Tau_TR_A.ByStep.PeakSEM      = std(cell2mat(VR.Tau_TR_A.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.Peak)), 2));
VR.Tau_TR_A.ByStep.WidthMn      = mean(cell2mat(VR.Tau_TR_A.ByStep.Width), 2, 'omitnan');
VR.Tau_TR_A.ByStep.WidthSEM     = std(cell2mat(VR.Tau_TR_A.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(VR.Tau_TR_A.ByStep.Width)), 2));

Si.Amy_WT.ByStep.NMn            = mean(cell2mat(Si.Amy_WT.ByStep.N), 2);
Si.Amy_WT.ByStep.NSEM           = std(cell2mat(Si.Amy_WT.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.N)), 2));
Si.Amy_WT.ByStep.IntRatioMn     = mean(cell2mat(Si.Amy_WT.ByStep.IntRatio), 2, 'omitnan');
Si.Amy_WT.ByStep.IntRatioSEM    = std(cell2mat(Si.Amy_WT.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.IntRatio)), 2));
Si.Amy_WT.ByStep.LatencyMn      = mean(cell2mat(Si.Amy_WT.ByStep.Latency), 2, 'omitnan');
Si.Amy_WT.ByStep.LatencySEM     = std(cell2mat(Si.Amy_WT.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.Latency)), 2));
Si.Amy_WT.ByStep.PeakMn         = mean(cell2mat(Si.Amy_WT.ByStep.Peak), 2, 'omitnan');
Si.Amy_WT.ByStep.PeakSEM        = std(cell2mat(Si.Amy_WT.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.Peak)), 2));
Si.Amy_WT.ByStep.WidthMn        = mean(cell2mat(Si.Amy_WT.ByStep.Width), 2, 'omitnan');
Si.Amy_WT.ByStep.WidthSEM       = std(cell2mat(Si.Amy_WT.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_WT.ByStep.Width)), 2));

Si.Amy_TR.ByStep.NMn            = mean(cell2mat(Si.Amy_TR.ByStep.N), 2);
Si.Amy_TR.ByStep.NSEM           = std(cell2mat(Si.Amy_TR.ByStep.N), [], 2) ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.N)), 2));
Si.Amy_TR.ByStep.IntRatioMn     = mean(cell2mat(Si.Amy_TR.ByStep.IntRatio), 2, 'omitnan');
Si.Amy_TR.ByStep.IntRatioSEM    = std(cell2mat(Si.Amy_TR.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.IntRatio)), 2));
Si.Amy_TR.ByStep.LatencyMn      = mean(cell2mat(Si.Amy_TR.ByStep.Latency), 2, 'omitnan');
Si.Amy_TR.ByStep.LatencySEM     = std(cell2mat(Si.Amy_TR.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.Latency)), 2));
Si.Amy_TR.ByStep.PeakMn         = mean(cell2mat(Si.Amy_TR.ByStep.Peak), 2, 'omitnan');
Si.Amy_TR.ByStep.PeakSEM        = std(cell2mat(Si.Amy_TR.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.Peak)), 2));
Si.Amy_TR.ByStep.WidthMn        = mean(cell2mat(Si.Amy_TR.ByStep.Width), 2, 'omitnan');
Si.Amy_TR.ByStep.WidthSEM       = std(cell2mat(Si.Amy_TR.ByStep.Width), [], 2, 'omitnan') ./ sqrt(sum(~isnan(cell2mat(Si.Amy_TR.ByStep.Width)), 2));

Si.Tau_WT.ByStep.NMn            = mean(cell2mat(Si.Tau_WT.ByStep.N), 2);
Si.Tau_WT.ByStep.NSEM           = std(cell2mat(Si.Tau_WT.ByStep.N), [], 2) ./ sqrt(Si.Tau_WT.Count);
Si.Tau_WT.ByStep.IntRatioMn     = mean(cell2mat(Si.Tau_WT.ByStep.IntRatio), 2, 'omitnan');
Si.Tau_WT.ByStep.IntRatioSEM    = std(cell2mat(Si.Tau_WT.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT.Count);
Si.Tau_WT.ByStep.LatencyMn      = mean(cell2mat(Si.Tau_WT.ByStep.Latency), 2, 'omitnan');
Si.Tau_WT.ByStep.LatencySEM     = std(cell2mat(Si.Tau_WT.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT.Count);
Si.Tau_WT.ByStep.PeakMn         = mean(cell2mat(Si.Tau_WT.ByStep.Peak), 2, 'omitnan');
Si.Tau_WT.ByStep.PeakSEM        = std(cell2mat(Si.Tau_WT.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT.Count);
Si.Tau_WT.ByStep.WidthMn        = mean(cell2mat(Si.Tau_WT.ByStep.Width), 2, 'omitnan');
Si.Tau_WT.ByStep.WidthSEM       = std(cell2mat(Si.Tau_WT.ByStep.Width), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT.Count);

Si.Tau_TR.ByStep.NMn            = mean(cell2mat(Si.Tau_TR.ByStep.N), 2);
Si.Tau_TR.ByStep.NSEM           = std(cell2mat(Si.Tau_TR.ByStep.N), [], 2) ./ sqrt(Si.Tau_TR.Count);
Si.Tau_TR.ByStep.IntRatioMn     = mean(cell2mat(Si.Tau_TR.ByStep.IntRatio), 2, 'omitnan');
Si.Tau_TR.ByStep.IntRatioSEM    = std(cell2mat(Si.Tau_TR.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR.Count);
Si.Tau_TR.ByStep.LatencyMn      = mean(cell2mat(Si.Tau_TR.ByStep.Latency), 2, 'omitnan');
Si.Tau_TR.ByStep.LatencySEM     = std(cell2mat(Si.Tau_TR.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR.Count);
Si.Tau_TR.ByStep.PeakMn         = mean(cell2mat(Si.Tau_TR.ByStep.Peak), 2, 'omitnan');
Si.Tau_TR.ByStep.PeakSEM        = std(cell2mat(Si.Tau_TR.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR.Count);
Si.Tau_TR.ByStep.WidthMn        = mean(cell2mat(Si.Tau_TR.ByStep.Width), 2, 'omitnan');
Si.Tau_TR.ByStep.WidthSEM       = std(cell2mat(Si.Tau_TR.ByStep.Width), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR.Count);

Si.Tau_WT_A.ByStep.NMn          = mean(cell2mat(Si.Tau_WT_A.ByStep.N), 2);
Si.Tau_WT_A.ByStep.NSEM         = std(cell2mat(Si.Tau_WT_A.ByStep.N), [], 2) ./ sqrt(Si.Tau_WT_A.Count);
Si.Tau_WT_A.ByStep.IntRatioMn   = mean(cell2mat(Si.Tau_WT_A.ByStep.IntRatio), 2, 'omitnan');
Si.Tau_WT_A.ByStep.IntRatioSEM  = std(cell2mat(Si.Tau_WT_A.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT_A.Count);
Si.Tau_WT_A.ByStep.LatencyMn    = mean(cell2mat(Si.Tau_WT_A.ByStep.Latency), 2, 'omitnan');
Si.Tau_WT_A.ByStep.LatencySEM   = std(cell2mat(Si.Tau_WT_A.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT_A.Count);
Si.Tau_WT_A.ByStep.PeakMn       = mean(cell2mat(Si.Tau_WT_A.ByStep.Peak), 2, 'omitnan');
Si.Tau_WT_A.ByStep.PeakSEM      = std(cell2mat(Si.Tau_WT_A.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT_A.Count);
Si.Tau_WT_A.ByStep.WidthMn      = mean(cell2mat(Si.Tau_WT_A.ByStep.Width), 2, 'omitnan');
Si.Tau_WT_A.ByStep.WidthSEM     = std(cell2mat(Si.Tau_WT_A.ByStep.Width), [], 2, 'omitnan') ./ sqrt(Si.Tau_WT_A.Count);

Si.Tau_TR_A.ByStep.NMn          = mean(cell2mat(Si.Tau_TR_A.ByStep.N), 2);
Si.Tau_TR_A.ByStep.NSEM         = std(cell2mat(Si.Tau_TR_A.ByStep.N), [], 2) ./ sqrt(Si.Tau_TR_A.Count);
Si.Tau_TR_A.ByStep.IntRatioMn   = mean(cell2mat(Si.Tau_TR_A.ByStep.IntRatio), 2, 'omitnan');
Si.Tau_TR_A.ByStep.IntRatioSEM  = std(cell2mat(Si.Tau_TR_A.ByStep.IntRatio), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR_A.Count);
Si.Tau_TR_A.ByStep.LatencyMn    = mean(cell2mat(Si.Tau_TR_A.ByStep.Latency), 2, 'omitnan');
Si.Tau_TR_A.ByStep.LatencySEM   = std(cell2mat(Si.Tau_TR_A.ByStep.Latency), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR_A.Count);
Si.Tau_TR_A.ByStep.PeakMn       = mean(cell2mat(Si.Tau_TR_A.ByStep.Peak), 2, 'omitnan');
Si.Tau_TR_A.ByStep.PeakSEM      = std(cell2mat(Si.Tau_TR_A.ByStep.Peak), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR_A.Count);
Si.Tau_TR_A.ByStep.WidthMn      = mean(cell2mat(Si.Tau_TR_A.ByStep.Width), 2, 'omitnan');
Si.Tau_TR_A.ByStep.WidthSEM     = std(cell2mat(Si.Tau_TR_A.ByStep.Width), [], 2, 'omitnan') ./ sqrt(Si.Tau_TR_A.Count);

%% Plot Spike Count
if graphType == "All" || graphType == "Count"
figure('Units', 'inch', 'Position', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, 'Spike Count By Current Injection', 'FontSize', 24)

t1 = nexttile;
    shadedErrorBar(ISteps, VR.Amy_WT.ByStep.NMn, VR.Amy_WT.ByStep.NSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, VR.Amy_TR.ByStep.NMn, VR.Amy_TR.ByStep.NSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Count')
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t2 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.NMn, VR.Tau_WT.ByStep.NSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.NMn, VR.Tau_TR.ByStep.NSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Count')
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Tau at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t3 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.NMn, VR.Tau_WT.ByStep.NSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.NMn, VR.Tau_TR.ByStep.NSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.NMn, VR.Tau_WT_A.ByStep.NSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.NMn, VR.Tau_TR_A.ByStep.NSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
t4 = nexttile;
    shadedErrorBar(ISteps, Si.Amy_WT.ByStep.NMn, Si.Amy_WT.ByStep.NSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, Si.Amy_TR.ByStep.NMn, Si.Amy_TR.ByStep.NSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Count')
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t5 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.NMn, Si.Tau_WT.ByStep.NSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.NMn, Si.Tau_TR.ByStep.NSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Count')
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Tau at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t6 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.NMn, Si.Tau_WT.ByStep.NSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.NMn, Si.Tau_TR.ByStep.NSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.NMn, Si.Tau_WT_A.ByStep.NSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.NMn, Si.Tau_TR_A.ByStep.NSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Count')
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    ylim([0 30])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
saveas(gcf, "Spike Count By Step" + " " + cellType + ".png")
end

%% Plot Spike Interval
if graphType == "All" || graphType == "Interval"
figure('Units', 'inch', 'Position', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, 'Spike Interval By Current Injection', 'FontSize', 24)

t1 = nexttile;
    shadedErrorBar(ISteps, VR.Amy_WT.ByStep.IntRatioMn, VR.Amy_WT.ByStep.IntRatioSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, VR.Amy_TR.ByStep.IntRatioMn, VR.Amy_TR.ByStep.IntRatioSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t2 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.IntRatioMn, VR.Tau_WT.ByStep.IntRatioSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.IntRatioMn, VR.Tau_TR.ByStep.IntRatioSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Tau at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t3 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.IntRatioMn, VR.Tau_WT.ByStep.IntRatioSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.IntRatioMn, VR.Tau_TR.ByStep.IntRatioSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.IntRatioMn, VR.Tau_WT_A.ByStep.IntRatioSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.IntRatioMn, VR.Tau_TR_A.ByStep.IntRatioSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
t4 = nexttile;
    shadedErrorBar(ISteps, Si.Amy_WT.ByStep.IntRatioMn, Si.Amy_WT.ByStep.IntRatioSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, Si.Amy_TR.ByStep.IntRatioMn, Si.Amy_TR.ByStep.IntRatioSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t5 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.IntRatioMn, Si.Tau_WT.ByStep.IntRatioSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.IntRatioMn, Si.Tau_TR.ByStep.IntRatioSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Tau at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t6 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.IntRatioMn, Si.Tau_WT.ByStep.IntRatioSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.IntRatioMn, Si.Tau_TR.ByStep.IntRatioSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.IntRatioMn, Si.Tau_WT_A.ByStep.IntRatioSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.IntRatioMn, Si.Tau_TR_A.ByStep.IntRatioSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Interval Ratio')
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    ylim([0 5])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
saveas(gcf, "Spike Interval Ratio By Step" + " " + cellType + ".png")
end

%% Plot Spike Latency
if graphType == "All" || graphType == "Latency"
figure('Units', 'inch', 'Position', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, 'Spike Latency By Current Injection', 'FontSize', 24)

t1 = nexttile;
    shadedErrorBar(ISteps, VR.Amy_WT.ByStep.LatencyMn, VR.Amy_WT.ByStep.LatencySEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, VR.Amy_TR.ByStep.LatencyMn, VR.Amy_TR.ByStep.LatencySEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t2 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.LatencyMn, VR.Tau_WT.ByStep.LatencySEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.LatencyMn, VR.Tau_TR.ByStep.LatencySEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Tau at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t3 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.LatencyMn, VR.Tau_WT.ByStep.LatencySEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.LatencyMn, VR.Tau_TR.ByStep.LatencySEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.LatencyMn, VR.Tau_WT_A.ByStep.LatencySEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.LatencyMn, VR.Tau_TR_A.ByStep.LatencySEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
t4 = nexttile;
    shadedErrorBar(ISteps, Si.Amy_WT.ByStep.LatencyMn, Si.Amy_WT.ByStep.LatencySEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, Si.Amy_TR.ByStep.LatencyMn, Si.Amy_TR.ByStep.LatencySEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northeast', 'FontSize', 12)
t5 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.LatencyMn, Si.Tau_WT.ByStep.LatencySEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.LatencyMn, Si.Tau_TR.ByStep.LatencySEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Tau at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northeast', 'FontSize', 12)
t6 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.LatencyMn, Si.Tau_WT.ByStep.LatencySEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.LatencyMn, Si.Tau_TR.ByStep.LatencySEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.LatencyMn, Si.Tau_WT_A.ByStep.LatencySEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.LatencyMn, Si.Tau_TR_A.ByStep.LatencySEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Latency (ms)')
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    ylim([0 180])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northeast', 'FontSize', 12)
saveas(gcf, "Spike Latency By Step" + " " + cellType + ".png")
end

%% Plot Spike Peak
if graphType == "All" || graphType == "Peak"
figure('Units', 'inch', 'Position', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, 'Spike Peak By Current Injection', 'FontSize', 24)

t1 = nexttile;
    shadedErrorBar(ISteps, VR.Amy_WT.ByStep.PeakMn, VR.Amy_WT.ByStep.PeakSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, VR.Amy_TR.ByStep.PeakMn, VR.Amy_TR.ByStep.PeakSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'southeast', 'FontSize', 12)
t2 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.PeakMn, VR.Tau_WT.ByStep.PeakSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.PeakMn, VR.Tau_TR.ByStep.PeakSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Tau at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'southeast', 'FontSize', 12)
t3 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.PeakMn, VR.Tau_WT.ByStep.PeakSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.PeakMn, VR.Tau_TR.ByStep.PeakSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.PeakMn, VR.Tau_WT_A.ByStep.PeakSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.PeakMn, VR.Tau_TR_A.ByStep.PeakSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'southeast', 'FontSize', 12)
t4 = nexttile;
    shadedErrorBar(ISteps, Si.Amy_WT.ByStep.PeakMn, Si.Amy_WT.ByStep.PeakSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, Si.Amy_TR.ByStep.PeakMn, Si.Amy_TR.ByStep.PeakSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'southeast', 'FontSize', 12)
t5 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.PeakMn, Si.Tau_WT.ByStep.PeakSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.PeakMn, Si.Tau_TR.ByStep.PeakSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Tau at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'southeast', 'FontSize', 12)
t6 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.PeakMn, Si.Tau_WT.ByStep.PeakSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.PeakMn, Si.Tau_TR.ByStep.PeakSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.PeakMn, Si.Tau_WT_A.ByStep.PeakSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.PeakMn, Si.Tau_TR_A.ByStep.PeakSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Peak (mV)')
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    ylim([25 55])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'southeast', 'FontSize', 12)
saveas(gcf, "Spike Peak By Step" + " " + cellType + ".png")
end

%% Plot Spike Width
if graphType == "All" || graphType == "Width"
figure('Units', 'inch', 'Position', [0.5 1.5 15 9])
t = tiledlayout(2,3);
title(t, 'Spike Width By Current Injection', 'FontSize', 24)

t1 = nexttile;
    shadedErrorBar(ISteps, VR.Amy_WT.ByStep.WidthMn, VR.Amy_WT.ByStep.WidthSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, VR.Amy_TR.ByStep.WidthMn, VR.Amy_TR.ByStep.WidthSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t1.XAxis.FontSize = 14;
    t1.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Amyloid at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northwest', 'FontSize', 12)
t2 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.WidthMn, VR.Tau_WT.ByStep.WidthSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.WidthMn, VR.Tau_TR.ByStep.WidthSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t2.XAxis.FontSize = 14;
    t2.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Tau at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northwest', 'FontSize', 12)
t3 = nexttile;
    shadedErrorBar(ISteps, VR.Tau_WT.ByStep.WidthMn, VR.Tau_WT.ByStep.WidthSEM)
    hold on
    shadedErrorBar(ISteps, VR.Tau_TR.ByStep.WidthMn, VR.Tau_TR.ByStep.WidthSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, VR.Tau_WT_A.ByStep.WidthMn, VR.Tau_WT_A.ByStep.WidthSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, VR.Tau_TR_A.ByStep.WidthMn, VR.Tau_TR_A.ByStep.WidthSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t3.XAxis.FontSize = 14;
    t3.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at Resting Potential', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northwest', 'FontSize', 12, 'NumColumns', 2)
t4 = nexttile;
    shadedErrorBar(ISteps, Si.Amy_WT.ByStep.WidthMn, Si.Amy_WT.ByStep.WidthSEM, 'LineProps', {'markerfacecolor', [.8 .8 .8]})
    hold on
    shadedErrorBar(ISteps, Si.Amy_TR.ByStep.WidthMn, Si.Amy_TR.ByStep.WidthSEM, 'LineProps', 'm')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t4.XAxis.FontSize = 14;
    t4.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Amyloid at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Amy WT', 'Amy TR', 'Location', 'northwest', 'FontSize', 12)
t5 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.WidthMn, Si.Tau_WT.ByStep.WidthSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.WidthMn, Si.Tau_TR.ByStep.WidthSEM, 'LineProps', 'r')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t5.XAxis.FontSize = 14;
    t5.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Tau at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Location', 'northwest', 'FontSize', 12)
t6 = nexttile;
    shadedErrorBar(ISteps, Si.Tau_WT.ByStep.WidthMn, Si.Tau_WT.ByStep.WidthSEM)
    hold on
    shadedErrorBar(ISteps, Si.Tau_TR.ByStep.WidthMn, Si.Tau_TR.ByStep.WidthSEM, 'LineProps', 'r')
    shadedErrorBar(ISteps, Si.Tau_WT_A.ByStep.WidthMn, Si.Tau_WT_A.ByStep.WidthSEM, 'LineProps', 'g')
    shadedErrorBar(ISteps, Si.Tau_TR_A.ByStep.WidthMn, Si.Tau_TR_A.ByStep.WidthSEM, 'LineProps', 'b')
    xlabel('Injected Current (pA)')
    ylabel('Spike Width (ms)')
    t6.XAxis.FontSize = 14;
    t6.YAxis.FontSize = 14;
    ylim([0.8 2])
    xlim([20 max(ISteps)])
    title('Tau AdipoRon at -60 mV', 'FontSize', 16, 'FontWeight', 'Normal')
    legend('Tau WT', 'Tau TR', 'Tau WT A', 'Tau TR A', 'Location', 'northwest', 'FontSize', 12, 'NumColumns', 2)
saveas(gcf, "Spike Width By Step" + " " + cellType + ".png")
end
