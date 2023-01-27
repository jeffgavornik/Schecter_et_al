function [files,lhFiles,rhFiles] = define5DaySRPFemaleDay1Group

files = {};
files{end+1} = 'gend0109A_day1-45'; % bad day 3 file
files{end+1} = 'gend0109B_day1-45'; 
files{end+1} = 'gend0109C_day1-45'; %exclude, no day 5 data
files{end+1} = 'gend0116G_day1-45';
files{end+1} = 'gend0116H_day1-45';
files{end+1} = 'gend0202Q_day1-45';
files{end+1} = 'gend0202R_day1-45';
files{end+1} = 'gend0329V_day1-45';
files{end+1} = 'gend0329X_day1-45'; 
files{end+1} = 'gend0329Y_day1-45';
files{end+1} = 'gend0425Z_day1-45';
files{end+1} = 'gend0425BB_day1-45';
files{end+1} = 'gend0518DD_day1-45';


lhFiles = {};
lhFiles{end+1} = 'gend0116H_day1-45';
lhFiles{end+1} = 'gend0202Q_day1-45';
lhFiles{end+1} = 'gend0425BB_day1-45';
lhFiles{end+1} = 'gend0518DD_day1-45';

rhFiles = {};
rhFiles{end+1} = 'gend0109A_day1-45';
rhFiles{end+1} = 'gend0109B_day1-45';
rhFiles{end+1} = 'gend0109C_day1-45';
rhFiles{end+1} = 'gend0116G_day1-45';
rhFiles{end+1} = 'gend0202R_day1-45';
rhFiles{end+1} = 'gend0329V_day1-45';
rhFiles{end+1} = 'gend0329X_day1-45'; 
rhFiles{end+1} = 'gend0329Y_day1-45';
rhFiles{end+1} = 'gend0425Z_day1-45';

files = files(~contains(files,excludeFrom5DaySRPFemaleDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySRPFemaleDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySRPFemaleDataSets));
