function [VC, VR, Si] = CCIV_ReadParams(fullExcel, VC, VR, Si)

%% Get values from Excel sheet for hand-written pre and post VR, CM, RS, and RM and compute means and stdevs
% Danny Lasky, 8/23

%% Voltage clamp for wild type amyloid
VC.Amy_WT.Pre_VR       = fullExcel{VC.Amy_WT.Rows,'Pre_VR'};
VC.Amy_WT.Pre_CM       = fullExcel{VC.Amy_WT.Rows,'Pre_CM'};
VC.Amy_WT.Pre_RS       = fullExcel{VC.Amy_WT.Rows,'Pre_RS'};
VC.Amy_WT.Pre_RM       = fullExcel{VC.Amy_WT.Rows,'Pre_RM'};

VC.Amy_WT.Post_VR      = fullExcel{VC.Amy_WT.Rows,'Post_VR'};
VC.Amy_WT.Post_CM      = fullExcel{VC.Amy_WT.Rows,'Post_CM'};
VC.Amy_WT.Post_RS      = fullExcel{VC.Amy_WT.Rows,'Post_RS'};
VC.Amy_WT.Post_RM      = fullExcel{VC.Amy_WT.Rows,'Post_RM'};

%% Voltage clamp for transgenic amyloid
VC.Amy_TR.Pre_VR       = fullExcel{VC.Amy_TR.Rows,'Pre_VR'};
VC.Amy_TR.Pre_CM       = fullExcel{VC.Amy_TR.Rows,'Pre_CM'};
VC.Amy_TR.Pre_RS       = fullExcel{VC.Amy_TR.Rows,'Pre_RS'};
VC.Amy_TR.Pre_RM       = fullExcel{VC.Amy_TR.Rows,'Pre_RM'};

VC.Amy_TR.Post_VR      = fullExcel{VC.Amy_TR.Rows,'Post_VR'};
VC.Amy_TR.Post_CM      = fullExcel{VC.Amy_TR.Rows,'Post_CM'};
VC.Amy_TR.Post_RS      = fullExcel{VC.Amy_TR.Rows,'Post_RS'};
VC.Amy_TR.Post_RM      = fullExcel{VC.Amy_TR.Rows,'Post_RM'};

%% Voltage clamp for all wild type tau
VC.Tau_WT.Pre_VR       = fullExcel{VC.Tau_WT.Rows,'Pre_VR'};
VC.Tau_WT.Pre_CM       = fullExcel{VC.Tau_WT.Rows,'Pre_CM'};
VC.Tau_WT.Pre_RS       = fullExcel{VC.Tau_WT.Rows,'Pre_RS'};
VC.Tau_WT.Pre_RM       = fullExcel{VC.Tau_WT.Rows,'Pre_RM'};

VC.Tau_WT.Post_VR      = fullExcel{VC.Tau_WT.Rows,'Post_VR'};
VC.Tau_WT.Post_CM      = fullExcel{VC.Tau_WT.Rows,'Post_CM'};
VC.Tau_WT.Post_RS      = fullExcel{VC.Tau_WT.Rows,'Post_RS'};
VC.Tau_WT.Post_RM      = fullExcel{VC.Tau_WT.Rows,'Post_RM'};

%% Voltage clamp for AdipoRon wild type tau
VC.Tau_WT_A.Pre_VR       = fullExcel{VC.Tau_WT_A.Rows,'Pre_VR'};
VC.Tau_WT_A.Pre_CM       = fullExcel{VC.Tau_WT_A.Rows,'Pre_CM'};
VC.Tau_WT_A.Pre_RS       = fullExcel{VC.Tau_WT_A.Rows,'Pre_RS'};
VC.Tau_WT_A.Pre_RM       = fullExcel{VC.Tau_WT_A.Rows,'Pre_RM'};

VC.Tau_WT_A.Post_VR      = fullExcel{VC.Tau_WT_A.Rows,'Post_VR'};
VC.Tau_WT_A.Post_CM      = fullExcel{VC.Tau_WT_A.Rows,'Post_CM'};
VC.Tau_WT_A.Post_RS      = fullExcel{VC.Tau_WT_A.Rows,'Post_RS'};
VC.Tau_WT_A.Post_RM      = fullExcel{VC.Tau_WT_A.Rows,'Post_RM'};

%% Voltage clamp for DMSO wild type tau
VC.Tau_WT_D.Pre_VR       = fullExcel{VC.Tau_WT_D.Rows,'Pre_VR'};
VC.Tau_WT_D.Pre_CM       = fullExcel{VC.Tau_WT_D.Rows,'Pre_CM'};
VC.Tau_WT_D.Pre_RS       = fullExcel{VC.Tau_WT_D.Rows,'Pre_RS'};
VC.Tau_WT_D.Pre_RM       = fullExcel{VC.Tau_WT_D.Rows,'Pre_RM'};

VC.Tau_WT_D.Post_VR      = fullExcel{VC.Tau_WT_D.Rows,'Post_VR'};
VC.Tau_WT_D.Post_CM      = fullExcel{VC.Tau_WT_D.Rows,'Post_CM'};
VC.Tau_WT_D.Post_RS      = fullExcel{VC.Tau_WT_D.Rows,'Post_RS'};
VC.Tau_WT_D.Post_RM      = fullExcel{VC.Tau_WT_D.Rows,'Post_RM'};

%% Voltage clamp for PBS seeded wild type tau
VC.Tau_WT_PBS.Pre_VR       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_VR'};
VC.Tau_WT_PBS.Pre_CM       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_CM'};
VC.Tau_WT_PBS.Pre_RS       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_RS'};
VC.Tau_WT_PBS.Pre_RM       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_RM'};

VC.Tau_WT_PBS.Post_VR      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_VR'};
VC.Tau_WT_PBS.Post_CM      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_CM'};
VC.Tau_WT_PBS.Post_RS      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_RS'};
VC.Tau_WT_PBS.Post_RM      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_RM'};

%% Voltage clamp for PBS seeded AdipoRon wild type tau
VC.Tau_WT_PBS.Pre_VR       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_VR'};
VC.Tau_WT_PBS.Pre_CM       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_CM'};
VC.Tau_WT_PBS.Pre_RS       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_RS'};
VC.Tau_WT_PBS.Pre_RM       = fullExcel{VC.Tau_WT_PBS.Rows,'Pre_RM'};

VC.Tau_WT_PBS.Post_VR      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_VR'};
VC.Tau_WT_PBS.Post_CM      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_CM'};
VC.Tau_WT_PBS.Post_RS      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_RS'};
VC.Tau_WT_PBS.Post_RM      = fullExcel{VC.Tau_WT_PBS.Rows,'Post_RM'};

%% Voltage clamp for PFF seeded wild type tau
VC.Tau_WT_PFF.Pre_VR       = fullExcel{VC.Tau_WT_PFF.Rows,'Pre_VR'};
VC.Tau_WT_PFF.Pre_CM       = fullExcel{VC.Tau_WT_PFF.Rows,'Pre_CM'};
VC.Tau_WT_PFF.Pre_RS       = fullExcel{VC.Tau_WT_PFF.Rows,'Pre_RS'};
VC.Tau_WT_PFF.Pre_RM       = fullExcel{VC.Tau_WT_PFF.Rows,'Pre_RM'};

VC.Tau_WT_PFF.Post_VR      = fullExcel{VC.Tau_WT_PFF.Rows,'Post_VR'};
VC.Tau_WT_PFF.Post_CM      = fullExcel{VC.Tau_WT_PFF.Rows,'Post_CM'};
VC.Tau_WT_PFF.Post_RS      = fullExcel{VC.Tau_WT_PFF.Rows,'Post_RS'};
VC.Tau_WT_PFF.Post_RM      = fullExcel{VC.Tau_WT_PFF.Rows,'Post_RM'};

%% Voltage clamp for all transgenic tau
VC.Tau_TR.Pre_VR       = fullExcel{VC.Tau_TR.Rows,'Pre_VR'};
VC.Tau_TR.Pre_CM       = fullExcel{VC.Tau_TR.Rows,'Pre_CM'};
VC.Tau_TR.Pre_RS       = fullExcel{VC.Tau_TR.Rows,'Pre_RS'};
VC.Tau_TR.Pre_RM       = fullExcel{VC.Tau_TR.Rows,'Pre_RM'};

VC.Tau_TR.Post_VR      = fullExcel{VC.Tau_TR.Rows,'Post_VR'};
VC.Tau_TR.Post_CM      = fullExcel{VC.Tau_TR.Rows,'Post_CM'};
VC.Tau_TR.Post_RS      = fullExcel{VC.Tau_TR.Rows,'Post_RS'};
VC.Tau_TR.Post_RM      = fullExcel{VC.Tau_TR.Rows,'Post_RM'};

%% Voltage clamp for AdipoRon transgenic tau
VC.Tau_TR_A.Pre_VR       = fullExcel{VC.Tau_TR_A.Rows,'Pre_VR'};
VC.Tau_TR_A.Pre_CM       = fullExcel{VC.Tau_TR_A.Rows,'Pre_CM'};
VC.Tau_TR_A.Pre_RS       = fullExcel{VC.Tau_TR_A.Rows,'Pre_RS'};
VC.Tau_TR_A.Pre_RM       = fullExcel{VC.Tau_TR_A.Rows,'Pre_RM'};

VC.Tau_TR_A.Post_VR      = fullExcel{VC.Tau_TR_A.Rows,'Post_VR'};
VC.Tau_TR_A.Post_CM      = fullExcel{VC.Tau_TR_A.Rows,'Post_CM'};
VC.Tau_TR_A.Post_RS      = fullExcel{VC.Tau_TR_A.Rows,'Post_RS'};
VC.Tau_TR_A.Post_RM      = fullExcel{VC.Tau_TR_A.Rows,'Post_RM'};

%% Voltage clamp for DMSO transgenic tau
VC.Tau_TR_D.Pre_VR       = fullExcel{VC.Tau_TR_D.Rows,'Pre_VR'};
VC.Tau_TR_D.Pre_CM       = fullExcel{VC.Tau_TR_D.Rows,'Pre_CM'};
VC.Tau_TR_D.Pre_RS       = fullExcel{VC.Tau_TR_D.Rows,'Pre_RS'};
VC.Tau_TR_D.Pre_RM       = fullExcel{VC.Tau_TR_D.Rows,'Pre_RM'};

VC.Tau_TR_D.Post_VR      = fullExcel{VC.Tau_TR_D.Rows,'Post_VR'};
VC.Tau_TR_D.Post_CM      = fullExcel{VC.Tau_TR_D.Rows,'Post_CM'};
VC.Tau_TR_D.Post_RS      = fullExcel{VC.Tau_TR_D.Rows,'Post_RS'};
VC.Tau_TR_D.Post_RM      = fullExcel{VC.Tau_TR_D.Rows,'Post_RM'};

%% Voltage clamp for PBS seeded transgenic tau
VC.Tau_TR_PBS.Pre_VR       = fullExcel{VC.Tau_TR_PBS.Rows,'Pre_VR'};
VC.Tau_TR_PBS.Pre_CM       = fullExcel{VC.Tau_TR_PBS.Rows,'Pre_CM'};
VC.Tau_TR_PBS.Pre_RS       = fullExcel{VC.Tau_TR_PBS.Rows,'Pre_RS'};
VC.Tau_TR_PBS.Pre_RM       = fullExcel{VC.Tau_TR_PBS.Rows,'Pre_RM'};

VC.Tau_TR_PBS.Post_VR      = fullExcel{VC.Tau_TR_PBS.Rows,'Post_VR'};
VC.Tau_TR_PBS.Post_CM      = fullExcel{VC.Tau_TR_PBS.Rows,'Post_CM'};
VC.Tau_TR_PBS.Post_RS      = fullExcel{VC.Tau_TR_PBS.Rows,'Post_RS'};
VC.Tau_TR_PBS.Post_RM      = fullExcel{VC.Tau_TR_PBS.Rows,'Post_RM'};

%% Voltage clamp for PFF seeded transgenic tau
VC.Tau_TR_PFF.Pre_VR       = fullExcel{VC.Tau_TR_PFF.Rows,'Pre_VR'};
VC.Tau_TR_PFF.Pre_CM       = fullExcel{VC.Tau_TR_PFF.Rows,'Pre_CM'};
VC.Tau_TR_PFF.Pre_RS       = fullExcel{VC.Tau_TR_PFF.Rows,'Pre_RS'};
VC.Tau_TR_PFF.Pre_RM       = fullExcel{VC.Tau_TR_PFF.Rows,'Pre_RM'};

VC.Tau_TR_PFF.Post_VR      = fullExcel{VC.Tau_TR_PFF.Rows,'Post_VR'};
VC.Tau_TR_PFF.Post_CM      = fullExcel{VC.Tau_TR_PFF.Rows,'Post_CM'};
VC.Tau_TR_PFF.Post_RS      = fullExcel{VC.Tau_TR_PFF.Rows,'Post_RS'};
VC.Tau_TR_PFF.Post_RM      = fullExcel{VC.Tau_TR_PFF.Rows,'Post_RM'};

%% Resting potential CC-IV for wild type amyloid
VR.Amy_WT.Pre_VR       = fullExcel{VR.Amy_WT.Rows,'Pre_VR'};
VR.Amy_WT.Pre_CM       = fullExcel{VR.Amy_WT.Rows,'Pre_CM'};
VR.Amy_WT.Pre_RS       = fullExcel{VR.Amy_WT.Rows,'Pre_RS'};
VR.Amy_WT.Pre_RM       = fullExcel{VR.Amy_WT.Rows,'Pre_RM'};

VR.Amy_WT.Post_VR      = fullExcel{VR.Amy_WT.Rows,'Post_VR'};
VR.Amy_WT.Post_CM      = fullExcel{VR.Amy_WT.Rows,'Post_CM'};
VR.Amy_WT.Post_RS      = fullExcel{VR.Amy_WT.Rows,'Post_RS'};
VR.Amy_WT.Post_RM      = fullExcel{VR.Amy_WT.Rows,'Post_RM'};

%% Resting potential CC-IV for transgenic amyloid
VR.Amy_TR.Pre_VR       = fullExcel{VR.Amy_TR.Rows,'Pre_VR'};
VR.Amy_TR.Pre_CM       = fullExcel{VR.Amy_TR.Rows,'Pre_CM'};
VR.Amy_TR.Pre_RS       = fullExcel{VR.Amy_TR.Rows,'Pre_RS'};
VR.Amy_TR.Pre_RM       = fullExcel{VR.Amy_TR.Rows,'Pre_RM'};

VR.Amy_TR.Post_VR      = fullExcel{VR.Amy_TR.Rows,'Post_VR'};
VR.Amy_TR.Post_CM      = fullExcel{VR.Amy_TR.Rows,'Post_CM'};
VR.Amy_TR.Post_RS      = fullExcel{VR.Amy_TR.Rows,'Post_RS'};
VR.Amy_TR.Post_RM      = fullExcel{VR.Amy_TR.Rows,'Post_RM'};

%% Resting potential CC-IV for all wild type tau
VR.Tau_WT.Pre_VR       = fullExcel{VR.Tau_WT.Rows,'Pre_VR'};
VR.Tau_WT.Pre_CM       = fullExcel{VR.Tau_WT.Rows,'Pre_CM'};
VR.Tau_WT.Pre_RS       = fullExcel{VR.Tau_WT.Rows,'Pre_RS'};
VR.Tau_WT.Pre_RM       = fullExcel{VR.Tau_WT.Rows,'Pre_RM'};

VR.Tau_WT.Post_VR      = fullExcel{VR.Tau_WT.Rows,'Post_VR'};
VR.Tau_WT.Post_CM      = fullExcel{VR.Tau_WT.Rows,'Post_CM'};
VR.Tau_WT.Post_RS      = fullExcel{VR.Tau_WT.Rows,'Post_RS'};
VR.Tau_WT.Post_RM      = fullExcel{VR.Tau_WT.Rows,'Post_RM'};

%% Resting potential CC-IV for AdipoRon wild type tau
VR.Tau_WT_A.Pre_VR       = fullExcel{VR.Tau_WT_A.Rows,'Pre_VR'};
VR.Tau_WT_A.Pre_CM       = fullExcel{VR.Tau_WT_A.Rows,'Pre_CM'};
VR.Tau_WT_A.Pre_RS       = fullExcel{VR.Tau_WT_A.Rows,'Pre_RS'};
VR.Tau_WT_A.Pre_RM       = fullExcel{VR.Tau_WT_A.Rows,'Pre_RM'};

VR.Tau_WT_A.Post_VR      = fullExcel{VR.Tau_WT_A.Rows,'Post_VR'};
VR.Tau_WT_A.Post_CM      = fullExcel{VR.Tau_WT_A.Rows,'Post_CM'};
VR.Tau_WT_A.Post_RS      = fullExcel{VR.Tau_WT_A.Rows,'Post_RS'};
VR.Tau_WT_A.Post_RM      = fullExcel{VR.Tau_WT_A.Rows,'Post_RM'};

%% Resting potential CC-IV for DMSO wild type tau
VR.Tau_WT_D.Pre_VR       = fullExcel{VR.Tau_WT_D.Rows,'Pre_VR'};
VR.Tau_WT_D.Pre_CM       = fullExcel{VR.Tau_WT_D.Rows,'Pre_CM'};
VR.Tau_WT_D.Pre_RS       = fullExcel{VR.Tau_WT_D.Rows,'Pre_RS'};
VR.Tau_WT_D.Pre_RM       = fullExcel{VR.Tau_WT_D.Rows,'Pre_RM'};

VR.Tau_WT_D.Post_VR      = fullExcel{VR.Tau_WT_D.Rows,'Post_VR'};
VR.Tau_WT_D.Post_CM      = fullExcel{VR.Tau_WT_D.Rows,'Post_CM'};
VR.Tau_WT_D.Post_RS      = fullExcel{VR.Tau_WT_D.Rows,'Post_RS'};
VR.Tau_WT_D.Post_RM      = fullExcel{VR.Tau_WT_D.Rows,'Post_RM'};

%% Resting potential CC-IV for PBS seeded wild type tau
VR.Tau_WT_PBS.Pre_VR       = fullExcel{VR.Tau_WT_PBS.Rows,'Pre_VR'};
VR.Tau_WT_PBS.Pre_CM       = fullExcel{VR.Tau_WT_PBS.Rows,'Pre_CM'};
VR.Tau_WT_PBS.Pre_RS       = fullExcel{VR.Tau_WT_PBS.Rows,'Pre_RS'};
VR.Tau_WT_PBS.Pre_RM       = fullExcel{VR.Tau_WT_PBS.Rows,'Pre_RM'};

VR.Tau_WT_PBS.Post_VR      = fullExcel{VR.Tau_WT_PBS.Rows,'Post_VR'};
VR.Tau_WT_PBS.Post_CM      = fullExcel{VR.Tau_WT_PBS.Rows,'Post_CM'};
VR.Tau_WT_PBS.Post_RS      = fullExcel{VR.Tau_WT_PBS.Rows,'Post_RS'};
VR.Tau_WT_PBS.Post_RM      = fullExcel{VR.Tau_WT_PBS.Rows,'Post_RM'};

%% Resting potential CC-IV for PFF seeded wild type tau
VR.Tau_WT_PFF.Pre_VR       = fullExcel{VR.Tau_WT_PFF.Rows,'Pre_VR'};
VR.Tau_WT_PFF.Pre_CM       = fullExcel{VR.Tau_WT_PFF.Rows,'Pre_CM'};
VR.Tau_WT_PFF.Pre_RS       = fullExcel{VR.Tau_WT_PFF.Rows,'Pre_RS'};
VR.Tau_WT_PFF.Pre_RM       = fullExcel{VR.Tau_WT_PFF.Rows,'Pre_RM'};

VR.Tau_WT_PFF.Post_VR      = fullExcel{VR.Tau_WT_PFF.Rows,'Post_VR'};
VR.Tau_WT_PFF.Post_CM      = fullExcel{VR.Tau_WT_PFF.Rows,'Post_CM'};
VR.Tau_WT_PFF.Post_RS      = fullExcel{VR.Tau_WT_PFF.Rows,'Post_RS'};
VR.Tau_WT_PFF.Post_RM      = fullExcel{VR.Tau_WT_PFF.Rows,'Post_RM'};

%% Resting potential CC-IV for all transgenic tau
VR.Tau_TR.Pre_VR       = fullExcel{VR.Tau_TR.Rows,'Pre_VR'};
VR.Tau_TR.Pre_CM       = fullExcel{VR.Tau_TR.Rows,'Pre_CM'};
VR.Tau_TR.Pre_RS       = fullExcel{VR.Tau_TR.Rows,'Pre_RS'};
VR.Tau_TR.Pre_RM       = fullExcel{VR.Tau_TR.Rows,'Pre_RM'};

VR.Tau_TR.Post_VR      = fullExcel{VR.Tau_TR.Rows,'Post_VR'};
VR.Tau_TR.Post_CM      = fullExcel{VR.Tau_TR.Rows,'Post_CM'};
VR.Tau_TR.Post_RS      = fullExcel{VR.Tau_TR.Rows,'Post_RS'};
VR.Tau_TR.Post_RM      = fullExcel{VR.Tau_TR.Rows,'Post_RM'};

%% Resting potential CC-IV for AdipoRon transgenic tau
VR.Tau_TR_A.Pre_VR       = fullExcel{VR.Tau_TR_A.Rows,'Pre_VR'};
VR.Tau_TR_A.Pre_CM       = fullExcel{VR.Tau_TR_A.Rows,'Pre_CM'};
VR.Tau_TR_A.Pre_RS       = fullExcel{VR.Tau_TR_A.Rows,'Pre_RS'};
VR.Tau_TR_A.Pre_RM       = fullExcel{VR.Tau_TR_A.Rows,'Pre_RM'};

VR.Tau_TR_A.Post_VR      = fullExcel{VR.Tau_TR_A.Rows,'Post_VR'};
VR.Tau_TR_A.Post_CM      = fullExcel{VR.Tau_TR_A.Rows,'Post_CM'};
VR.Tau_TR_A.Post_RS      = fullExcel{VR.Tau_TR_A.Rows,'Post_RS'};
VR.Tau_TR_A.Post_RM      = fullExcel{VR.Tau_TR_A.Rows,'Post_RM'};

%% Resting potential CC-IV for DMSO transgenic tau
VR.Tau_TR_D.Pre_VR       = fullExcel{VR.Tau_TR_D.Rows,'Pre_VR'};
VR.Tau_TR_D.Pre_CM       = fullExcel{VR.Tau_TR_D.Rows,'Pre_CM'};
VR.Tau_TR_D.Pre_RS       = fullExcel{VR.Tau_TR_D.Rows,'Pre_RS'};
VR.Tau_TR_D.Pre_RM       = fullExcel{VR.Tau_TR_D.Rows,'Pre_RM'};

VR.Tau_TR_D.Post_VR      = fullExcel{VR.Tau_TR_D.Rows,'Post_VR'};
VR.Tau_TR_D.Post_CM      = fullExcel{VR.Tau_TR_D.Rows,'Post_CM'};
VR.Tau_TR_D.Post_RS      = fullExcel{VR.Tau_TR_D.Rows,'Post_RS'};
VR.Tau_TR_D.Post_RM      = fullExcel{VR.Tau_TR_D.Rows,'Post_RM'};

%% Resting potential CC-IV for PBS seeded transgenic tau
VR.Tau_TR_PBS.Pre_VR       = fullExcel{VR.Tau_TR_PBS.Rows,'Pre_VR'};
VR.Tau_TR_PBS.Pre_CM       = fullExcel{VR.Tau_TR_PBS.Rows,'Pre_CM'};
VR.Tau_TR_PBS.Pre_RS       = fullExcel{VR.Tau_TR_PBS.Rows,'Pre_RS'};
VR.Tau_TR_PBS.Pre_RM       = fullExcel{VR.Tau_TR_PBS.Rows,'Pre_RM'};

VR.Tau_TR_PBS.Post_VR      = fullExcel{VR.Tau_TR_PBS.Rows,'Post_VR'};
VR.Tau_TR_PBS.Post_CM      = fullExcel{VR.Tau_TR_PBS.Rows,'Post_CM'};
VR.Tau_TR_PBS.Post_RS      = fullExcel{VR.Tau_TR_PBS.Rows,'Post_RS'};
VR.Tau_TR_PBS.Post_RM      = fullExcel{VR.Tau_TR_PBS.Rows,'Post_RM'};

%% Resting potential CC-IV for PFF seeded transgenic tau
VR.Tau_TR_PFF.Pre_VR       = fullExcel{VR.Tau_TR_PFF.Rows,'Pre_VR'};
VR.Tau_TR_PFF.Pre_CM       = fullExcel{VR.Tau_TR_PFF.Rows,'Pre_CM'};
VR.Tau_TR_PFF.Pre_RS       = fullExcel{VR.Tau_TR_PFF.Rows,'Pre_RS'};
VR.Tau_TR_PFF.Pre_RM       = fullExcel{VR.Tau_TR_PFF.Rows,'Pre_RM'};

VR.Tau_TR_PFF.Post_VR      = fullExcel{VR.Tau_TR_PFF.Rows,'Post_VR'};
VR.Tau_TR_PFF.Post_CM      = fullExcel{VR.Tau_TR_PFF.Rows,'Post_CM'};
VR.Tau_TR_PFF.Post_RS      = fullExcel{VR.Tau_TR_PFF.Rows,'Post_RS'};
VR.Tau_TR_PFF.Post_RM      = fullExcel{VR.Tau_TR_PFF.Rows,'Post_RM'};

%% -60 mV CC-IV for wild type amyloid
Si.Amy_WT.Pre_VR       = fullExcel{Si.Amy_WT.Rows,'Pre_VR'};
Si.Amy_WT.Pre_CM       = fullExcel{Si.Amy_WT.Rows,'Pre_CM'};
Si.Amy_WT.Pre_RS       = fullExcel{Si.Amy_WT.Rows,'Pre_RS'};
Si.Amy_WT.Pre_RM       = fullExcel{Si.Amy_WT.Rows,'Pre_RM'};

Si.Amy_WT.Post_VR      = fullExcel{Si.Amy_WT.Rows,'Post_VR'};
Si.Amy_WT.Post_CM      = fullExcel{Si.Amy_WT.Rows,'Post_CM'};
Si.Amy_WT.Post_RS      = fullExcel{Si.Amy_WT.Rows,'Post_RS'};
Si.Amy_WT.Post_RM      = fullExcel{Si.Amy_WT.Rows,'Post_RM'};

%% -60 mV CC-IV for transgenic amyloid
Si.Amy_TR.Pre_VR    = fullExcel{Si.Amy_TR.Rows,'Post_VR'};
Si.Amy_TR.Pre_CM    = fullExcel{Si.Amy_TR.Rows,'Post_CM'};
Si.Amy_TR.Pre_RS    = fullExcel{Si.Amy_TR.Rows,'Post_RS'};
Si.Amy_TR.Pre_RM    = fullExcel{Si.Amy_TR.Rows,'Post_RM'};

Si.Amy_TR.Post_VR    = fullExcel{Si.Amy_TR.Rows,'Post_VR'};
Si.Amy_TR.Post_CM    = fullExcel{Si.Amy_TR.Rows,'Post_CM'};
Si.Amy_TR.Post_RS    = fullExcel{Si.Amy_TR.Rows,'Post_RS'};
Si.Amy_TR.Post_RM    = fullExcel{Si.Amy_TR.Rows,'Post_RM'};

%% -60 mV CC-IV for all wild type tau
Si.Tau_WT.Pre_VR    = fullExcel{Si.Tau_WT.Rows,'Pre_VR'};
Si.Tau_WT.Pre_CM    = fullExcel{Si.Tau_WT.Rows,'Pre_CM'};
Si.Tau_WT.Pre_RS    = fullExcel{Si.Tau_WT.Rows,'Pre_RS'};
Si.Tau_WT.Pre_RM    = fullExcel{Si.Tau_WT.Rows,'Pre_RM'};

Si.Tau_WT.Post_VR    = fullExcel{Si.Tau_WT.Rows,'Post_VR'};
Si.Tau_WT.Post_CM    = fullExcel{Si.Tau_WT.Rows,'Post_CM'};
Si.Tau_WT.Post_RS    = fullExcel{Si.Tau_WT.Rows,'Post_RS'};
Si.Tau_WT.Post_RM    = fullExcel{Si.Tau_WT.Rows,'Post_RM'};

%% -60 mV CC-IV for AdipoRon wild type tau
Si.Tau_WT_A.Pre_VR       = fullExcel{Si.Tau_WT_A.Rows,'Pre_VR'};
Si.Tau_WT_A.Pre_CM       = fullExcel{Si.Tau_WT_A.Rows,'Pre_CM'};
Si.Tau_WT_A.Pre_RS       = fullExcel{Si.Tau_WT_A.Rows,'Pre_RS'};
Si.Tau_WT_A.Pre_RM       = fullExcel{Si.Tau_WT_A.Rows,'Pre_RM'};

Si.Tau_WT_A.Post_VR      = fullExcel{Si.Tau_WT_A.Rows,'Post_VR'};
Si.Tau_WT_A.Post_CM      = fullExcel{Si.Tau_WT_A.Rows,'Post_CM'};
Si.Tau_WT_A.Post_RS      = fullExcel{Si.Tau_WT_A.Rows,'Post_RS'};
Si.Tau_WT_A.Post_RM      = fullExcel{Si.Tau_WT_A.Rows,'Post_RM'};

%% -60 mV CC-IV for DMSO wild type tau
Si.Tau_WT_D.Pre_VR       = fullExcel{Si.Tau_WT_D.Rows,'Pre_VR'};
Si.Tau_WT_D.Pre_CM       = fullExcel{Si.Tau_WT_D.Rows,'Pre_CM'};
Si.Tau_WT_D.Pre_RS       = fullExcel{Si.Tau_WT_D.Rows,'Pre_RS'};
Si.Tau_WT_D.Pre_RM       = fullExcel{Si.Tau_WT_D.Rows,'Pre_RM'};

Si.Tau_WT_D.Post_VR      = fullExcel{Si.Tau_WT_D.Rows,'Post_VR'};
Si.Tau_WT_D.Post_CM      = fullExcel{Si.Tau_WT_D.Rows,'Post_CM'};
Si.Tau_WT_D.Post_RS      = fullExcel{Si.Tau_WT_D.Rows,'Post_RS'};
Si.Tau_WT_D.Post_RM      = fullExcel{Si.Tau_WT_D.Rows,'Post_RM'};

%% -60 mV CC-IV for PBS seeded wild type tau
Si.Tau_WT_PBS.Pre_VR    = fullExcel{Si.Tau_WT_PBS.Rows,'Pre_VR'};
Si.Tau_WT_PBS.Pre_CM    = fullExcel{Si.Tau_WT_PBS.Rows,'Pre_CM'};
Si.Tau_WT_PBS.Pre_RS    = fullExcel{Si.Tau_WT_PBS.Rows,'Pre_RS'};
Si.Tau_WT_PBS.Pre_RM    = fullExcel{Si.Tau_WT_PBS.Rows,'Pre_RM'};

Si.Tau_WT_PBS.Post_VR    = fullExcel{Si.Tau_WT_PBS.Rows,'Post_VR'};
Si.Tau_WT_PBS.Post_CM    = fullExcel{Si.Tau_WT_PBS.Rows,'Post_CM'};
Si.Tau_WT_PBS.Post_RS    = fullExcel{Si.Tau_WT_PBS.Rows,'Post_RS'};
Si.Tau_WT_PBS.Post_RM    = fullExcel{Si.Tau_WT_PBS.Rows,'Post_RM'};

%% -60 mV CC-IV for PFF seeded wild type tau
Si.Tau_WT_PFF.Pre_VR    = fullExcel{Si.Tau_WT_PFF.Rows,'Pre_VR'};
Si.Tau_WT_PFF.Pre_CM    = fullExcel{Si.Tau_WT_PFF.Rows,'Pre_CM'};
Si.Tau_WT_PFF.Pre_RS    = fullExcel{Si.Tau_WT_PFF.Rows,'Pre_RS'};
Si.Tau_WT_PFF.Pre_RM    = fullExcel{Si.Tau_WT_PFF.Rows,'Pre_RM'};

Si.Tau_WT_PFF.Post_VR    = fullExcel{Si.Tau_WT_PFF.Rows,'Post_VR'};
Si.Tau_WT_PFF.Post_CM    = fullExcel{Si.Tau_WT_PFF.Rows,'Post_CM'};
Si.Tau_WT_PFF.Post_RS    = fullExcel{Si.Tau_WT_PFF.Rows,'Post_RS'};
Si.Tau_WT_PFF.Post_RM    = fullExcel{Si.Tau_WT_PFF.Rows,'Post_RM'};

%% -60 mV CC-IV for all transgenic tau
Si.Tau_TR.Pre_VR    = fullExcel{Si.Tau_TR.Rows,'Pre_VR'};
Si.Tau_TR.Pre_CM    = fullExcel{Si.Tau_TR.Rows,'Pre_CM'};
Si.Tau_TR.Pre_RS    = fullExcel{Si.Tau_TR.Rows,'Pre_RS'};
Si.Tau_TR.Pre_RM    = fullExcel{Si.Tau_TR.Rows,'Pre_RM'};

Si.Tau_TR.Post_VR    = fullExcel{Si.Tau_TR.Rows,'Post_VR'};
Si.Tau_TR.Post_CM    = fullExcel{Si.Tau_TR.Rows,'Post_CM'};
Si.Tau_TR.Post_RS    = fullExcel{Si.Tau_TR.Rows,'Post_RS'};
Si.Tau_TR.Post_RM    = fullExcel{Si.Tau_TR.Rows,'Post_RM'};

%% -60 mV CC-IV for AdipoRon wild type tau
Si.Tau_TR_A.Pre_VR       = fullExcel{Si.Tau_TR_A.Rows,'Pre_VR'};
Si.Tau_TR_A.Pre_CM       = fullExcel{Si.Tau_TR_A.Rows,'Pre_CM'};
Si.Tau_TR_A.Pre_RS       = fullExcel{Si.Tau_TR_A.Rows,'Pre_RS'};
Si.Tau_TR_A.Pre_RM       = fullExcel{Si.Tau_TR_A.Rows,'Pre_RM'};

Si.Tau_TR_A.Post_VR      = fullExcel{Si.Tau_TR_A.Rows,'Post_VR'};
Si.Tau_TR_A.Post_CM      = fullExcel{Si.Tau_TR_A.Rows,'Post_CM'};
Si.Tau_TR_A.Post_RS      = fullExcel{Si.Tau_TR_A.Rows,'Post_RS'};
Si.Tau_TR_A.Post_RM      = fullExcel{Si.Tau_TR_A.Rows,'Post_RM'};

%% -60 mV CC-IV for DMSO wild type tau
Si.Tau_TR_D.Pre_VR       = fullExcel{Si.Tau_TR_D.Rows,'Pre_VR'};
Si.Tau_TR_D.Pre_CM       = fullExcel{Si.Tau_TR_D.Rows,'Pre_CM'};
Si.Tau_TR_D.Pre_RS       = fullExcel{Si.Tau_TR_D.Rows,'Pre_RS'};
Si.Tau_TR_D.Pre_RM       = fullExcel{Si.Tau_TR_D.Rows,'Pre_RM'};

Si.Tau_TR_D.Post_VR      = fullExcel{Si.Tau_TR_D.Rows,'Post_VR'};
Si.Tau_TR_D.Post_CM      = fullExcel{Si.Tau_TR_D.Rows,'Post_CM'};
Si.Tau_TR_D.Post_RS      = fullExcel{Si.Tau_TR_D.Rows,'Post_RS'};
Si.Tau_TR_D.Post_RM      = fullExcel{Si.Tau_TR_D.Rows,'Post_RM'};

%% -60 mV CC-IV for PBS seeded transgenic tau
Si.Tau_TR_PBS.Pre_VR    = fullExcel{Si.Tau_TR_PBS.Rows,'Pre_VR'};
Si.Tau_TR_PBS.Pre_CM    = fullExcel{Si.Tau_TR_PBS.Rows,'Pre_CM'};
Si.Tau_TR_PBS.Pre_RS    = fullExcel{Si.Tau_TR_PBS.Rows,'Pre_RS'};
Si.Tau_TR_PBS.Pre_RM    = fullExcel{Si.Tau_TR_PBS.Rows,'Pre_RM'};

Si.Tau_TR_PBS.Post_VR    = fullExcel{Si.Tau_TR_PBS.Rows,'Post_VR'};
Si.Tau_TR_PBS.Post_CM    = fullExcel{Si.Tau_TR_PBS.Rows,'Post_CM'};
Si.Tau_TR_PBS.Post_RS    = fullExcel{Si.Tau_TR_PBS.Rows,'Post_RS'};
Si.Tau_TR_PBS.Post_RM    = fullExcel{Si.Tau_TR_PBS.Rows,'Post_RM'};

%% -60 mV CC-IV for PFF seeded transgenic tau
Si.Tau_TR_PFF.Pre_VR    = fullExcel{Si.Tau_TR_PFF.Rows,'Pre_VR'};
Si.Tau_TR_PFF.Pre_CM    = fullExcel{Si.Tau_TR_PFF.Rows,'Pre_CM'};
Si.Tau_TR_PFF.Pre_RS    = fullExcel{Si.Tau_TR_PFF.Rows,'Pre_RS'};
Si.Tau_TR_PFF.Pre_RM    = fullExcel{Si.Tau_TR_PFF.Rows,'Pre_RM'};

Si.Tau_TR_PFF.Post_VR    = fullExcel{Si.Tau_TR_PFF.Rows,'Post_VR'};
Si.Tau_TR_PFF.Post_CM    = fullExcel{Si.Tau_TR_PFF.Rows,'Post_CM'};
Si.Tau_TR_PFF.Post_RS    = fullExcel{Si.Tau_TR_PFF.Rows,'Post_RS'};
Si.Tau_TR_PFF.Post_RM    = fullExcel{Si.Tau_TR_PFF.Rows,'Post_RM'};
