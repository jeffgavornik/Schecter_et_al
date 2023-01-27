function [files,lhFiles,rhFiles] = define5DaySRPFemaleDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0109A_day5-45-135';
files{end+1} = 'gend0109B_day5-45-135'; 
files{end+1} = 'gend0109C_day5-45-135'; %exclude, no day 5 data
files{end+1} = 'gend0116G_day5-45-135';
files{end+1} = 'gend0116H_day5-45-135';
files{end+1} = 'gend0202Q_day5-45-135';
files{end+1} = 'gend0202R_day5-45-135';
files{end+1} = 'gend0329V_day5-45-135';
files{end+1} = 'gend0329X_day5-45-135'; 
files{end+1} = 'gend0329Y_day5-45-135';
files{end+1} = 'gend0425Z_day5-45-135';
files{end+1} = 'gend0425BB_day5-45-135';
files{end+1} = 'gend0518DD_day5-45-135';

lhFiles = {};
lhFiles{end+1} = 'gend0116H_day5-45-135';
lhFiles{end+1} = 'gend0202Q_day5-45-135';
lhFiles{end+1} = 'gend0425BB_day5-45-135';
lhFiles{end+1} = 'gend0518DD_day5-45-135';

rhFiles = {};
rhFiles{end+1} = 'gend0109A_day5-45-135';
rhFiles{end+1} = 'gend0109B_day5-45-135';
rhFiles{end+1} = 'gend0109C_day5-45-135';
rhFiles{end+1} = 'gend0116G_day5-45-135';
rhFiles{end+1} = 'gend0202R_day5-45-135';
rhFiles{end+1} = 'gend0329V_day5-45-135';
rhFiles{end+1} = 'gend0329X_day5-45-135'; 
rhFiles{end+1} = 'gend0329Y_day5-45-135';
rhFiles{end+1} = 'gend0425Z_day5-45-135';

if returnExcluded
    files = files(contains(files,excludeFrom5DaySRPFemaleDataSets));
else
    files = files(~contains(files,excludeFrom5DaySRPFemaleDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DaySRPFemaleDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySRPFemaleDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DaySRPFemaleDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySRPFemaleDataSets));
end