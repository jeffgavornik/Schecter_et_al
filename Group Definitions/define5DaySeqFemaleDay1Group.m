function [files,lhFiles,rhFiles] = define5DaySeqFemaleDay1Group

files = {};
files{end+1} = 'gend0606B_sequence-day1';
files{end+1} = 'gend0606C_sequence-day1';
files{end+1} = 'gend0621D_sequence-day1';
files{end+1} = 'gend0621E_sequence-day1';
files{end+1} = 'gend0712H_sequence-day1';
files{end+1} = 'gend0712I_sequence-day1';
files{end+1} = 'gend0824L_sequence-day1';
files{end+1} = 'gend0824M_sequence-day1';
files{end+1} = 'gend0824N_sequence-day1';
files{end+1} = 'gend0901P_sequence-day1';
files{end+1} = 'gend0901Q_sequence-day1';
files{end+1} = 'gend0905W_sequence-day1';
files{end+1} = 'gend0905X_sequence-day1';
files{end+1} = 'gend0905Y_sequence-day1';
files{end+1} = 'gend1004AA_sequence-day1'; %exclude (no day 5 file?)
files{end+1} = 'gend1004BB_sequence-day1';
files{end+1} = 'gend1004Z_sequence-day1';

lhFiles = {};
lhFiles{end+1} = 'gend0606B_sequence-day1';
lhFiles{end+1} = 'gend0606C_sequence-day1';
lhFiles{end+1} = 'gend0621E_sequence-day1';
lhFiles{end+1} = 'gend0824M_sequence-day1';
lhFiles{end+1} = 'gend0824N_sequence-day1';
lhFiles{end+1} = 'gend0901P_sequence-day1';
lhFiles{end+1} = 'gend1004BB_sequence-day1';

rhFiles = {};
rhFiles{end+1} = 'gend0621D_sequence-day1';
rhFiles{end+1} = 'gend0712H_sequence-day1';
rhFiles{end+1} = 'gend0712I_sequence-day1';
rhFiles{end+1} = 'gend0824L_sequence-day1';
rhFiles{end+1} = 'gend0901Q_sequence-day1';
rhFiles{end+1} = 'gend0905X_sequence-day1';
rhFiles{end+1} = 'gend0905Y_sequence-day1';
rhFiles{end+1} = 'gend1004Z_sequence-day1';

files = files(~contains(files,excludeFrom5DaySeqFemaleDataSets));
lhFiles = lhFiles(~contains(lhFiles,excludeFrom5DaySeqFemaleDataSets));
rhFiles = rhFiles(~contains(rhFiles,excludeFrom5DaySeqFemaleDataSets));
