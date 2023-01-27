function [files,lhFiles,rhFiles] = define5DaySeqMaleDay3Group

[files,lhFiles,rhFiles] = define5DaySeqMaleDay1Group;
files = cellfun(@(x)regexprep(x,'day1','day3'),files,'UniformOutput',false);
lhFiles = cellfun(@(x)regexprep(x,'day1','day3'),lhFiles,'UniformOutput',false);
rhFiles = cellfun(@(x)regexprep(x,'day1','day3'),rhFiles,'UniformOutput',false);