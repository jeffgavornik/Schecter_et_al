function [files,lhFiles,rhFiles] = define5DaySeqFemaleDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0606B_sequence-day5_wnovel';
files{end+1} = 'gend0606C_sequence-day5_wnovel';
files{end+1} = 'gend0621D_sequence-day5_wnovel';
files{end+1} = 'gend0621E_sequence-day5_wnovel';
files{end+1} = 'gend0712H_sequence-day5_wnovel';
files{end+1} = 'gend0712I_sequence-day5_wnovel';
files{end+1} = 'gend0824L_sequence-day5_wnovel';
files{end+1} = 'gend0824M_sequence-day5_wnovel';
files{end+1} = 'gend0824N_sequence-day5_wnovel';
files{end+1} = 'gend0901P_sequence-day5_wnovel';
files{end+1} = 'gend0901Q_sequence-day5_wnovel';
files{end+1} = 'gend0905W_sequence-day5_wnovel';
files{end+1} = 'gend0905X_sequence-day5_wnovel';
files{end+1} = 'gend0905Y_sequence-day5_wnovel';
files{end+1} = 'gend1004AA_sequence-day5_wnovel'; %exclude (no day 5 file?)
files{end+1} = 'gend1004BB_sequence-day5_wnovel';
files{end+1} = 'gend1004Z_sequence-day5_wnovel';

lhFiles = {};
lhFiles{end+1} = 'gend0606B_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0606C_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0621E_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0824M_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0824N_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0901P_sequence-day5_wnovel';
lhFiles{end+1} = 'gend1004BB_sequence-day5_wnovel';

rhFiles = {};
rhFiles{end+1} = 'gend0621D_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0712H_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0712I_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0824L_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0901Q_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0905X_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0905Y_sequence-day5_wnovel';
rhFiles{end+1} = 'gend1004Z_sequence-day5_wnovel';

if returnExcluded
    files = files(contains(files,excludeFrom5DaySeqFemaleDataSets));
else
    files = files(~contains(files,excludeFrom5DaySeqFemaleDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DaySeqFemaleDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySeqFemaleDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DaySeqFemaleDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySeqFemaleDataSets));
end