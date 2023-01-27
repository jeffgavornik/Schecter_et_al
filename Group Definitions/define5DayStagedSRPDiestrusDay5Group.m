function [files,lhFiles,rhFiles] = define5DayStagedSRPDiestrusDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0629B_stagedSRP-day5_45-135';
files{end+1} = 'gend0629F_stagedSRP-day5_45-135';
files{end+1} = 'gend0629G_stagedSRP-day5_45-135';
files{end+1} = 'gend0629I_stagedSRP-day5_45-135';
files{end+1} = 'gend0629K_stagedSRP-day5_45-135';
files{end+1} = 'gend0629P_stagedSRP-day5_45-135';
files{end+1} = 'gend0629R_stagedSRP-day5_45-135';
files{end+1} = 'gend0915AA_stagedSRP-day5_45-135';
files{end+1} = 'gend0915BB_stagedSRP-day5_45-135';
files{end+1} = 'gend0915CC_stagedSRP-day5_45-135';
files{end+1} = 'gend0915V_stagedSRP-day5_45-135';
files{end+1} = 'gend0915W_stagedSRP-day5_45-135';
files{end+1} = 'gend0915X_stagedSRP-day5_45-135';

lhFiles = {};
lhFiles{end+1} = 'gend0629F_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629G_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0629K_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915AA_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915BB_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915CC_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915W_stagedSRP-day5_45-135';
lhFiles{end+1} = 'gend0915X_stagedSRP-day5_45-135';

rhFiles = {};
rhFiles{end+1} = 'gend0629B_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629I_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629P_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0629R_stagedSRP-day5_45-135';
rhFiles{end+1} = 'gend0915V_stagedSRP-day5_45-135';

if returnExcluded
    files = files(contains(files,excludeFrom5DayStagedSRPDiestrusDataSets));
else
    files = files(~contains(files,excludeFrom5DayStagedSRPDiestrusDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DayStagedSRPDiestrusDataSets));
end