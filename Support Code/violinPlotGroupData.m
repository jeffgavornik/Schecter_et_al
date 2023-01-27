function [vs,ah] = violinPlotGroupData(varargin)
% Pass a list of VEPMagGroupClass objects
% 'Normalize',true will plot normalized data
% 'AverageByAnimal',false will plot all data without averaging
% All of args are passed to violinplot

iGrps = cellfun(@(x)isa(x,'VEPMagGroupClass'),varargin);
grps = varargin(iGrps);
args = varargin(~iGrps);

p = inputParser();
p.KeepUnmatched=true;
p.addParameter('AverageByAnimal',true,@(x)(islogical(x)&isscalar(x)));
p.addParameter('Normalize',false,@(x)(islogical(x)&isscalar(x)));
p.parse(args{:});

argNames = fieldnames(p.Unmatched);
passThroughArgs = cell(1,2*numel(argNames));
passThroughArgs(1:2:end) = argNames;
passThroughArgs(2:2:end) = struct2cell(p.Unmatched);

nGrps = length(grps);

allData = [];
allLabels = {};


grpOrder = cell(1,nGrps); % plot in order passed to this function
bwVals = zeros(1,nGrps); % optimal BW calculations
for iG = 1:nGrps
    grp = grps{iG};
    if p.Results.AverageByAnimal
        [grpData,normData] = grp.getGroupData('AverageByAnimal');
    else
        [grpData,normData] = grp.getGroupData;
    end
    if p.Results.Normalize
        grpData = normData;
    end
    nData = length(grpData);
    allData(end+1:end+nData) = grpData;
    allLabels(end+1:end+nData) = {char(grp.ID)};
    grpOrder{iG} = char(grp.ID);
    bwVals(iG) = std(grpData) * (4/((1+2)*nData))^(1/(1+4));
end

% use group average of optimal bandwidth 
bwInd = find(strcmp(passThroughArgs,'Bandwidth'));
val = passThroughArgs{bwInd+1};
if strcmp(val,'BestGuess')
    %d = 1;
    %N = nGrps;
    %sig = std(allData);
    %bwVal = sig * (4/((d+2)*N))^(1/(d+4));
    passThroughArgs{bwInd+1} = mean(bwVals);
end

ah = gca;
vs = violinplot(allData,allLabels,'GroupOrder',grpOrder,passThroughArgs{:});
for iV = 1:length(vs)
    vs(iV).ShowData = false;
    vs(iV).ShowBox = false;
    vs(iV).ShowWhiskers = false;
    vs(iV).ShowMedian = false;
    vs(iV).ShowQuartiles = true;
    vs(iV).ShowMean = true;
    vs(iV).ShowRange = false;
    %     vs(iV).ViolinAlpha = 1;
    %     vs(iV).Bandwidth
end


    