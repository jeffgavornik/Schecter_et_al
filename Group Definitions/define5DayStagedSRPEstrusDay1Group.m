function [files,lhFiles,rhFiles] = define5DayStagedSRPEstrusDay1Group

files = {};
files{end+1} = 'gend0629A_stagedSRP-day1_45';
files{end+1} = 'gend0629C_stagedSRP-day1_45';
files{end+1} = 'gend0629E_stagedSRP-day1_45';
files{end+1} = 'gend0629J_stagedSRP-day1_45';
files{end+1} = 'gend0629L_stagedSRP-day1_45';
files{end+1} = 'gend0629M_stagedSRP-day1_45';
files{end+1} = 'gend0629N_stagedSRP-day1_45'; %exclude
files{end+1} = 'gend0629O_stagedSRP-day1_45';
files{end+1} = 'gend0629Q_stagedSRP-day1_45';
files{end+1} = 'gend0629S_stagedSRP-day1_45';
files{end+1} = 'gend0915T_stagedSRP-day1_45';
files{end+1} = 'gend0915U_stagedSRP-day1_45';
files{end+1} = 'gend0915Y_stagedSRP-day1_45';
files{end+1} = 'gend0915Z_stagedSRP-day1_45';

lhFiles = {};
lhFiles{end+1} = 'gend0629A_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629E_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629L_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629O_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629Q_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915T_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915U_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915Y_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915Z_stagedSRP-day1_45';

rhFiles = {};
rhFiles{end+1} = 'gend0629C_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629J_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629M_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629S_stagedSRP-day1_45';

files = files(~contains(files,excludeFrom5DayStagedSRPEstrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
