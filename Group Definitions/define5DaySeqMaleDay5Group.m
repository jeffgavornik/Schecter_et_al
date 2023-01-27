function [files,lhFiles,rhFiles] = define5DaySeqMaleDay5Group(returnExcluded)

if nargin == 0
    returnExcluded = false;
end

files = {};
files{end+1} = 'gend0712F_sequence-day5_wnovel';
files{end+1} = 'gend0712G_sequence-day5_wnovel';
files{end+1} = 'gend0712J_sequence-day5_wnovel';
files{end+1} = 'gend0712K_sequence-day5_wnovel';
files{end+1} = 'gend0824O_sequence-day5_wnovel';
files{end+1} = 'gend0901R_sequence-day5_wnovel';
files{end+1} = 'gend0901S_sequence-day5_wnovel';
files{end+1} = 'gend0901T_sequence-day5_wnovel';
files{end+1} = 'gend0901U_sequence-day5_wnovel'; %exclude
files{end+1} = 'gend0905V_sequence-day5_wnovel';
files{end+1} = 'gend1004CC_sequence-day5_wnovel';
files{end+1} = 'gend1004DD_sequence-day5_wnovel';
files{end+1} = 'gend1004EE_sequence-day5_wnovel';

lhFiles = {};
lhFiles{end+1} = 'gend0712F_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0712G_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0712J_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0712K_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0901R_sequence-day5_wnovel';
lhFiles{end+1} = 'gend0901T_sequence-day5_wnovel';
lhFiles{end+1} = 'gend1004DD_sequence-day5_wnovel';

rhFiles = {};
rhFiles{end+1} = 'gend0824O_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0901S_sequence-day5_wnovel';
rhFiles{end+1} = 'gend0905V_sequence-day5_wnovel';
rhFiles{end+1} = 'gend1004CC_sequence-day5_wnovel';
rhFiles{end+1} = 'gend1004EE_sequence-day5_wnovel';



if returnExcluded
    files = files(contains(files,excludeFrom5DaySeqMaleDataSets));
else
    files = files(~contains(files,excludeFrom5DaySeqMaleDataSets));
end
if returnExcluded
    lhFiles = lhFiles(contains(lhFiles,excludeFrom5DaySeqMaleDataSets));
else
    lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySeqMaleDataSets));
end
if returnExcluded
    rhFiles = rhFiles(contains(rhFiles,excludeFrom5DaySeqMaleDataSets));
else
    rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySeqMaleDataSets));
end