function [files,lhFiles,rhFiles] = define5DaySeqMaleDay1Group

files = {};
files{end+1} = 'gend0712F_sequence-day1';
files{end+1} = 'gend0712G_sequence-day1';
files{end+1} = 'gend0712J_sequence-day1';
files{end+1} = 'gend0712K_sequence-day1';
files{end+1} = 'gend0824O_sequence-day1';
files{end+1} = 'gend0901R_sequence-day1';
files{end+1} = 'gend0901S_sequence-day1';
files{end+1} = 'gend0901T_sequence-day1';
files{end+1} = 'gend0901U_sequence-day1'; %exclude
files{end+1} = 'gend0905V_sequence-day1';
files{end+1} = 'gend1004CC_sequence-day1';
files{end+1} = 'gend1004DD_sequence-day1';
files{end+1} = 'gend1004EE_sequence-day1';

lhFiles = {};
lhFiles{end+1} = 'gend0712F_sequence-day1';
lhFiles{end+1} = 'gend0712G_sequence-day1';
lhFiles{end+1} = 'gend0712J_sequence-day1';
lhFiles{end+1} = 'gend0712K_sequence-day1';
lhFiles{end+1} = 'gend0901R_sequence-day1';
lhFiles{end+1} = 'gend0901T_sequence-day1';
lhFiles{end+1} = 'gend1004DD_sequence-day1';

rhFiles = {};
rhFiles{end+1} = 'gend0824O_sequence-day1';
rhFiles{end+1} = 'gend0901S_sequence-day1';
rhFiles{end+1} = 'gend0905V_sequence-day1';
rhFiles{end+1} = 'gend1004CC_sequence-day1';
rhFiles{end+1} = 'gend1004EE_sequence-day1';


files = files(~contains(files,excludeFrom5DaySeqMaleDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySeqMaleDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySeqMaleDataSets));
