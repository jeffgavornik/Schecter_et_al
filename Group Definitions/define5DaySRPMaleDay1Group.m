function [files,lhFiles,rhFiles] = define5DaySRPMaleDay1Group

files = {};
files{end+1} = 'gend0109E_day1-45';
files{end+1} = 'gend0116I_day1-45';
files{end+1} = 'gend0116J_day1-45';
files{end+1} = 'gend0116K_day1-45';
files{end+1} = 'gend0202M_day1-45';
files{end+1} = 'gend0202N_day1-45';
files{end+1} = 'gend0202O_day1-45';
files{end+1} = 'gend0202P_day1-45';
files{end+1} = 'gend0329S_day1-45'; 
files{end+1} = 'gend0329T_day1-45';
files{end+1} = 'gend0329U_day1-45';
files{end+1} = 'gend0425CC_day1-45';
files{end+1} = 'gend0518FF_day1-45';
files{end+1} = 'gend0518GG_day1-45';
files{end+1} = 'gend0518HH_day1-45';
files{end+1} = 'gend0518II_day1-45';


lhFiles = {};
lhFiles{end+1} = 'gend0116K_day1-45';
lhFiles{end+1} = 'gend0202N_day1-45';
lhFiles{end+1} = 'gend0202P_day1-45';
lhFiles{end+1} = 'gend0329T_day1-45';
lhFiles{end+1} = 'gend0518GG_day1-45';
lhFiles{end+1} = 'gend0518HH_day1-45';

rhFiles = {};
rhFiles{end+1} = 'gend0109E_day1-45';
rhFiles{end+1} = 'gend0116I_day1-45';
rhFiles{end+1} = 'gend0116J_day1-45';
rhFiles{end+1} = 'gend0202M_day1-45';
rhFiles{end+1} = 'gend0202O_day1-45';
rhFiles{end+1} = 'gend0329S_day1-45';
rhFiles{end+1} = 'gend0329U_day1-45';
rhFiles{end+1} = 'gend0425CC_day1-45';
rhFiles{end+1} = 'gend0518FF_day1-45';
rhFiles{end+1} = 'gend0518II_day1-45';

files = files(~contains(files,excludeFrom5DaySRPMaleDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySRPMaleDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySRPMaleDataSets));
