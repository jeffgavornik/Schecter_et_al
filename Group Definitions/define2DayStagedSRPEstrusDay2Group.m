function [files,lhFiles,rhFiles] = define2DayStagedSRPEstrusDay2Group

files = {};
% Cohort 1

files{end+1} = 'f8-B_Day2';
files{end+1} = 'f8-T_Day2';
files{end+1} = 'f8-X_Day2';
files{end+1} = 'mf3-N_Day2';
files{end+1} = 'mf5-A_Day2'; %exclude because Day 2 is diestrus
files{end+1} = 'mf5-B_Day2';
files{end+1} = 'mf6-I_Day2';

lhFiles = {};
lhFiles{end+1} = 'mf3-N_Day2';
lhFiles{end+1} = 'mf6-I_Day2';

rhFiles = {};
rhFiles{end+1} = 'f8-B_Day2';
rhFiles{end+1} = 'f8-T_Day2';
rhFiles{end+1} = 'f8-X_Day2';
rhFiles{end+1} = 'mf5-B_Day2';

files = files(~contains(files,excludeFrom2DayStagedEstrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedEstrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedEstrusDataSets));
