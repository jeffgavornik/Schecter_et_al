function [files,lhFiles,rhFiles] = define5DaySRPEstrusDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0629A_stagedSRP-day5_45-135';
files{end+1} = 'gend0629C_stagedSRP-day5_45-135';
files{end+1} = 'gend0629E_stagedSRP-day5_45-135';
files{end+1} = 'gend0629J_stagedSRP-day5_45-135';
files{end+1} = 'gend0629L_stagedSRP-day5_45-135';
files{end+1} = 'gend0629M_stagedSRP-day5_45-135';
files{end+1} = 'gend0629N_stagedSRP-day5_45-135'; %exclude
files{end+1} = 'gend0629O_stagedSRP-day5_45-135';
files{end+1} = 'gend0629Q_stagedSRP-day5_45-135';
files{end+1} = 'gend0629S_stagedSRP-day5_45-135';
files{end+1} = 'gend0915T_stagedSRP-day5_45-135';
files{end+1} = 'gend0915U_stagedSRP-day5_45-135';
files{end+1} = 'gend0915Y_stagedSRP-day5_45-135';
files{end+1} = 'gend0915Z_stagedSRP-day5_45-135';

lhFiles = {};
lhFiles{end+1} = 'gend0629A_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629E_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629L_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629O_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629Q_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915T_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915U_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915Y_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915Z_stagedSRP-day5_45-135';

rhFiles = {};
rhFiles{end+1} = 'gend0629C_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629J_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629M_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629S_stagedSRP-day5_45-135';

if returnExcluded
    files = files(contains(files,excludeFrom5DayStagedSRPEstrusDataSets));
else
    files = files(~contains(files,excludeFrom5DayStagedSRPEstrusDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DayStagedSRPEstrusDataSets));
end