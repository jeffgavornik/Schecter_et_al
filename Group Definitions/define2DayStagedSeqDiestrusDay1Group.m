function [files,lhFiles,rhFiles] = define2DayStagedSeqDiestrusDay1Group

% Cohort 1
files = {};
files{end+1} = 'gend1106B_sequence-day1';
files{end+1} = 'gend1106C_sequence-day1';
files{end+1} = 'gend1106H_sequence-day1';
files{end+1} = 'gend1106K_sequence-day1'; 
files{end+1} = 'gend1106L_sequence-day1'; %exclude
files{end+1} = 'gend1106M_sequence-day1'; 
files{end+1} = 'gend1106S_sequence-day1';
files{end+1} = 'gend1106T_sequence-day1'; %exclude
files{end+1} = 'gend1106U_sequence-day1'; %exclude
files{end+1} = 'gend1110F_sequence-day1'; %exclude
files{end+1} = 'gend1212AA_sequence-day1';
files{end+1} = 'gend1212BB_sequence-day1';
files{end+1} = 'gend1212EE_sequence-day1';
files{end+1} = 'gend1212V_sequence-day1';
files{end+1} = 'gend1212W_sequence-day1';
files{end+1} = 'gend1212Y_sequence-day1';

lhFiles = {};
lhFiles{end+1} = 'gend1106C_sequence-day1';
lhFiles{end+1} = 'gend1106K_sequence-day1';
lhFiles{end+1} = 'gend1106L_sequence-day1'; %exclude
lhFiles{end+1} = 'gend1106S_sequence-day1';
lhFiles{end+1} = 'gend1106T_sequence-day1'; %exclude
lhFiles{end+1} = 'gend1212AA_sequence-day1';
lhFiles{end+1} = 'gend1212EE_sequence-day1';
lhFiles{end+1} = 'gend1212V_sequence-day1';

rhFiles = {};
rhFiles{end+1} = 'gend1106B_sequence-day1';
rhFiles{end+1} = 'gend1106H_sequence-day1';
rhFiles{end+1} = 'gend1106M_sequence-day1';
rhFiles{end+1} = 'gend1106U_sequence-day1'; %exclude
rhFiles{end+1} = 'gend1110F_sequence-day1'; %exclude
rhFiles{end+1} = 'gend1212BB_sequence-day1';
rhFiles{end+1} = 'gend1212W_sequence-day1';
rhFiles{end+1} = 'gend1212Y_sequence-day1';


files = files(~contains(files,excludeFrom2DayStagedSeqDiestrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedSeqDiestrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedSeqDiestrusDataSets));
