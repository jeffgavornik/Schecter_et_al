function [files,lhFiles,rhFiles] = define5DayStagedSRPDiestrusDay1Group

files = {};
files{end+1} = 'gend0629B_stagedSRP-day1_45';
files{end+1} = 'gend0629F_stagedSRP-day1_45';
files{end+1} = 'gend0629G_stagedSRP-day1_45';
files{end+1} = 'gend0629I_stagedSRP-day1_45';
files{end+1} = 'gend0629K_stagedSRP-day1_45';
files{end+1} = 'gend0629P_stagedSRP-day1_45';
files{end+1} = 'gend0629R_stagedSRP-day1_45';
files{end+1} = 'gend0915AA_stagedSRP-day1_45';
files{end+1} = 'gend0915BB_stagedSRP-day1_45';
files{end+1} = 'gend0915CC_stagedSRP-day1_45';
files{end+1} = 'gend0915V_stagedSRP-day1_45';
files{end+1} = 'gend0915W_stagedSRP-day1_45';
files{end+1} = 'gend0915X_stagedSRP-day1_45';

lhFiles = {};
lhFiles{end+1} = 'gend0629F_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629G_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0629K_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915AA_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915BB_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915CC_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915W_stagedSRP-day1_45';
lhFiles{end+1} = 'gend0915X_stagedSRP-day1_45';

rhFiles = {};
rhFiles{end+1} = 'gend0629B_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629I_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629P_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0629R_stagedSRP-day1_45';
rhFiles{end+1} = 'gend0915V_stagedSRP-day1_45';

files = files(~contains(files,excludeFrom5DayStagedSRPDiestrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
