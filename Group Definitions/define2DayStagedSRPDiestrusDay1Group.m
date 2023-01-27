function [files,lhFiles,rhFiles] = define2DayStagedSRPDiestrusDay1Group

% Cohort 1
files = {};
files{end+1} = 'f8-A_Day1';
files{end+1} = 'f8-S_Day1';
files{end+1} = 'f8-U_Day1';
files{end+1} = 'f8-V_Day1'; %exclude bc estrus day 2
files{end+1} = 'f8-W_Day1'; %exclude
files{end+1} = 'f8-Y_Day1'; 
files{end+1} = 'f8-Z_Day1';
files{end+1} = 'mf3-L_Day1';
files{end+1} = 'mf5-D_Day1'; %exclude
files{end+1} = 'mf5-Z_Day1'; %exclude bc estrus day 2
files{end+1} = 'mf6-K_Day1';
files{end+1} = 'mf6-L_Day1';

lhFiles = {};
lhFiles{end+1} = 'f8-S_Day1'; 
lhFiles{end+1} = 'f8-Y_Day1';
lhFiles{end+1} = 'f8-Z_Day1'; 

rhFiles = {};
rhFiles{end+1} = 'f8-A_Day1';
rhFiles{end+1} = 'f8-U_Day1';
rhFiles{end+1} = 'mf3-L_Day1';
rhFiles{end+1} = 'mf6-K_Day1';
rhFiles{end+1} = 'mf6-L_Day1';

files = files(~contains(files,excludeFrom2DayStagedDiestrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedDiestrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedDiestrusDataSets));
