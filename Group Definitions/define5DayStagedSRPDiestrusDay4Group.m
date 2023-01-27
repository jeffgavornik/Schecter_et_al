function [files,lhFiles,rhFiles] = define5DayStagedSRPDiestrusDay4Group

[files,lhFiles,rhFiles] = define5DayStagedSRPDiestrusDay1Group;
files = cellfun(@(x)regexprep(x,'day1','day4'),files,'UniformOutput',false);
lhFiles = cellfun(@(x)regexprep(x,'day1','day4'),lhFiles,'UniformOutput',false);
rhFiles = cellfun(@(x)regexprep(x,'day1','day4'),rhFiles,'UniformOutput',false);