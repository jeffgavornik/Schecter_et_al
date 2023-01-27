function [files,lhFiles,rhFiles] = define2DayStagedSeqEstrusDay1Group

% Cohort 1
files = {};
files{end+1} = 'gend1106A_sequence-day1';
files{end+1} = 'gend1106D_sequence-day1';
files{end+1} = 'gend1106E_sequence-day1'; %exclude
files{end+1} = 'gend1106G_sequence-day1'; %exclude
files{end+1} = 'gend1106I_sequence-day1'; 
files{end+1} = 'gend1106N_sequence-day1'; 
files{end+1} = 'gend1106O_sequence-day1';
files{end+1} = 'gend1106P_sequence-day1'; %exclude
files{end+1} = 'gend1106Q_sequence-day1'; 
files{end+1} = 'gend1106R_sequence-day1'; 
files{end+1} = 'gend1110J_sequence-day1';
files{end+1} = 'gend1212DD_sequence-day1';
files{end+1} = 'gend1212X_sequence-day1';
files{end+1} = 'gend1212Z_sequence-day1';

lhFiles = {};
lhFiles{end+1} = 'gend1106A_sequence-day1';
lhFiles{end+1} = 'gend1106E_sequence-day1'; %exclude
lhFiles{end+1} = 'gend1106G_sequence-day1'; %exclude
lhFiles{end+1} = 'gend1106N_sequence-day1';
lhFiles{end+1} = 'gend1106O_sequence-day1';
lhFiles{end+1} = 'gend1110J_sequence-day1';
lhFiles{end+1} = 'gend1212X_sequence-day1';
lhFiles{end+1} = 'gend1212Z_sequence-day1';

rhFiles = {};
rhFiles{end+1} = 'gend1106D_sequence-day1';
rhFiles{end+1} = 'gend1106I_sequence-day1'; 
rhFiles{end+1} = 'gend1106P_sequence-day1'; %exclude
rhFiles{end+1} = 'gend1106Q_sequence-day1';  
rhFiles{end+1} = 'gend1106R_sequence-day1';
rhFiles{end+1} = 'gend1212DD_sequence-day1';


files = files(~contains(files,excludeFrom2DayStagedSeqEstrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedSeqEstrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedSeqEstrusDataSets));
