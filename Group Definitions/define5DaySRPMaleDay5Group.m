function [files,lhFiles,rhFiles] = define5DaySRPMaleDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0109E_day5-45-135';
files{end+1} = 'gend0116I_day5-45-135';
files{end+1} = 'gend0116J_day5-45-135';
files{end+1} = 'gend0116K_day5-45-135';
files{end+1} = 'gend0202M_day5-45-135';
files{end+1} = 'gend0202N_day5-45-135';
files{end+1} = 'gend0202O_day5-45-135';
files{end+1} = 'gend0202P_day5-45-135';
files{end+1} = 'gend0329S_day5-45-135'; 
files{end+1} = 'gend0329T_day5-45-135';
files{end+1} = 'gend0329U_day5-45-135';
files{end+1} = 'gend0425CC_day5-45-135';
files{end+1} = 'gend0518FF_day5-45-135';
files{end+1} = 'gend0518GG_day5-45-135';
files{end+1} = 'gend0518HH_day5-45-135';
files{end+1} = 'gend0518II_day5-45-135';


lhFiles = {};
lhFiles{end+1} = 'gend0116K_day5-45-135';
lhFiles{end+1} = 'gend0202N_day5-45-135';
lhFiles{end+1} = 'gend0202P_day5-45-135';
lhFiles{end+1} = 'gend0329T_day5-45-135';
lhFiles{end+1} = 'gend0518GG_day5-45-135';
lhFiles{end+1} = 'gend0518HH_day5-45-135';

rhFiles = {};
rhFiles{end+1} = 'gend0109E_day5-45-135';
rhFiles{end+1} = 'gend0116I_day5-45-135';
rhFiles{end+1} = 'gend0116J_day5-45-135';
rhFiles{end+1} = 'gend0202M_day5-45-135';
rhFiles{end+1} = 'gend0202O_day5-45-135';
rhFiles{end+1} = 'gend0329S_day5-45-135';
rhFiles{end+1} = 'gend0329U_day5-45-135';
rhFiles{end+1} = 'gend0425CC_day5-45-135';
rhFiles{end+1} = 'gend0518FF_day5-45-135';
rhFiles{end+1} = 'gend0518II_day5-45-135';


if returnExcluded
    files = files(contains(files,excludeFrom5DaySRPMaleDataSets));
else
    files = files(~contains(files,excludeFrom5DaySRPMaleDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DaySRPMaleDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySRPMaleDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DaySRPMaleDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySRPMaleDataSets));
end