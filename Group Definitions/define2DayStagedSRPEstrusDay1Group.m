function [files,lhFiles,rhFiles] = define2DayStagedSRPEstrusDay1Group

files = {};
files{end+1} = 'f8-B_Day1';
files{end+1} = 'f8-T_Day1';
files{end+1} = 'f8-X_Day1';
files{end+1} = 'mf3-N_Day1';
files{end+1} = 'mf5-A_Day1'; %exclude because Day 2 is diestrus
files{end+1} = 'mf5-B_Day1';
files{end+1} = 'mf6-I_Day1';

lhFiles = {};
lhFiles{end+1} = 'mf3-N_Day1';
lhFiles{end+1} = 'mf6-I_Day1';

rhFiles = {};
rhFiles{end+1} = 'f8-B_Day1';
rhFiles{end+1} = 'f8-T_Day1';
rhFiles{end+1} = 'f8-X_Day1';
rhFiles{end+1} = 'mf5-B_Day1';

files = files(~contains(files,excludeFrom2DayStagedEstrusDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom2DayStagedEstrusDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom2DayStagedEstrusDataSets));