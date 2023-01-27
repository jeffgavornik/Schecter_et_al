function [files,lhFiles,rhFiles] = define2DayStagedSeqDiestrusDay2Group

% Cohort 1
files = {};
files{end+1} = 'gend1106B_sequence-day2_wnovel';
files{end+1} = 'gend1106C_sequence-day2_wnovel';
files{end+1} = 'gend1106H_sequence-day2_wnovel';
files{end+1} = 'gend1106K_sequence-day2_wnovel'; 
files{end+1} = 'gend1106L_sequence-day2_wnovel'; %exclude
files{end+1} = 'gend1106M_sequence-day2_wnovel'; 
files{end+1} = 'gend1106S_sequence-day2_wnovel';
files{end+1} = 'gend1106T_sequence-day2_wnovel'; %exclude
files{end+1} = 'gend1106U_sequence-day2_wnovel'; %exclude
files{end+1} = 'gend1110F_sequence-day2_wnovel'; %exclude
files{end+1} = 'gend1212AA_sequence-day2_wnovel';
files{end+1} = 'gend1212BB_sequence-day2_wnovel';
files{end+1} = 'gend1212EE_sequence-day2_wnovel';
files{end+1} = 'gend1212V_sequence-day2_wnovel';
files{end+1} = 'gend1212W_sequence-day2_wnovel';
files{end+1} = 'gend1212Y_sequence-day2_wnovel';

lhFiles = {};
lhFiles{end+1} = 'gend1106C_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1106K_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1106L_sequence-day2_wnovel'; %exclude
lhFiles{end+1} = 'gend1106S_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1106T_sequence-day2_wnovel'; %exclude
lhFiles{end+1} = 'gend1212AA_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1212EE_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1212V_sequence-day2_wnovel';

rhFiles = {};
rhFiles{end+1} = 'gend1106B_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1106H_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1106M_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1106U_sequence-day2_wnovel'; %exclude
rhFiles{end+1} = 'gend1110F_sequence-day2_wnovel'; %exclude
rhFiles{end+1} = 'gend1212BB_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1212W_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1212Y_sequence-day2_wnovel';

files = files(~contains(files,excludeFrom2DayStagedSeqDiestrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedSeqDiestrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedSeqDiestrusDataSets));