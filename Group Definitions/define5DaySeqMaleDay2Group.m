function [files,lhFiles,rhFiles] = define5DaySeqMaleDay2Group

[files,lhFiles,rhFiles] = define5DaySeqMaleDay1Group;
files = cellfun(@(x)regexprep(x,'day1','day2'),files,'UniformOutput',false);
lhFiles = cellfun(@(x)regexprep(x,'day1','day2'),lhFiles,'UniformOutput',false);
rhFiles = cellfun(@(x)regexprep(x,'day1','day2'),rhFiles,'UniformOutput',false);