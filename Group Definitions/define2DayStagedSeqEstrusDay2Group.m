function [files,lhFiles,rhFiles] = define2DayStagedSeqEstrusDay2Group

% Cohort 1
files = {};
files{end+1} = 'gend1106A_sequence-day2_wnovel';
files{end+1} = 'gend1106D_sequence-day2_wnovel';
files{end+1} = 'gend1106E_sequence-day2_wnovel'; %excluded
files{end+1} = 'gend1106G_sequence-day2_wnovel'; %excluded
files{end+1} = 'gend1106I_sequence-day2_wnovel'; 
files{end+1} = 'gend1106N_sequence-day2_wnovel'; 
files{end+1} = 'gend1106O_sequence-day2_wnovel'; 
files{end+1} = 'gend1106P_sequence-day2_wnovel'; %excluded
files{end+1} = 'gend1106Q_sequence-day2_wnovel'; 
files{end+1} = 'gend1106R_sequence-day2_wnovel'; 
files{end+1} = 'gend1110J_sequence-day2_wnovel';
files{end+1} = 'gend1212DD_sequence-day2_wnovel';
files{end+1} = 'gend1212X_sequence-day2_wnovel';
files{end+1} = 'gend1212Z_sequence-day2_wnovel';

lhFiles = {};
lhFiles{end+1} = 'gend1106A_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1106E_sequence-day2_wnovel'; %exclude
lhFiles{end+1} = 'gend1106G_sequence-day2_wnovel'; %exclude
lhFiles{end+1} = 'gend1106N_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1106O_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1110J_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1212X_sequence-day2_wnovel';
lhFiles{end+1} = 'gend1212Z_sequence-day2_wnovel';

rhFiles = {};
rhFiles{end+1} = 'gend1106D_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1106I_sequence-day2_wnovel'; 
rhFiles{end+1} = 'gend1106P_sequence-day2_wnovel';%exclude 
rhFiles{end+1} = 'gend1106Q_sequence-day2_wnovel';  
rhFiles{end+1} = 'gend1106R_sequence-day2_wnovel';
rhFiles{end+1} = 'gend1212DD_sequence-day2_wnovel';

files = files(~contains(files,excludeFrom2DayStagedSeqEstrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedSeqEstrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedSeqEstrusDataSets));