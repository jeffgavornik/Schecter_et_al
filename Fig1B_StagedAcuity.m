%#ok<*SAGROW>

AnalysisSetup;

days = [1 2 3 4 5];

dataPath = 'Data/gender acuity - staged/';
figPath = './Figures/Fig1B';
[~,~,~] = mkdir(figPath);

figType = '-depsc';

extractTimeWindow = 0.25;
yLims = [-200 200];
stimXs = 0;


%%
% Create VDO and add data
vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.dataExtractParams.maxPositiveLatency = 0.2;
vdo.stimDefs = acuityStimDef;

% Add all data
allFiles = dir([dataPath '*acuity*plx']);
animalIDs = cell(1,length(allFiles));
for iF = 1:length(allFiles)
    theFile = allFiles(iF).name;
    parts = split(theFile(1:end-4),'_');
    animalID = parts{1};
    sessionID = 'acuity';
    vdo.addDataFromPlxFile(theFile,dataPath,animalID,sessionID);
    animalIDs{iF} = animalID;
end
animalIDs = string(animalIDs);

%% Create groups
vdo.deleteAllGroups

[diestrus,estrus] = defineStagedAcuityGroups;
dID = {diestrus.ID};
eID = {estrus.ID};
stimKeys = acuityStimDef.keys;
nKeys = length(stimKeys);
estrusGrps = cell(1,nKeys-1);
diestrusGrps = cell(1,nKeys-1);
for iK = 1:nKeys-1
    diestrusGrps{iK} = vdo.createNewGroup(['Diestrus ' stimKeys{iK}],'VEPMagGroupClass');
    estrusGrps{iK} = vdo.createNewGroup(['Estrus ' stimKeys{iK}],'VEPMagGroupClass');
end

for animalID = animalIDs
    if contains(animalID,dID)
        rcd = diestrus(contains(dID,animalID));
        grpStr = 'Diestrus ';
    elseif contains(animalID,eID)
        rcd = estrus(contains(eID,animalID));
        grpStr = 'Estrus ';
    else
        warning("AnimalID " + animalID + " not in estrus or diestrus groups");
        grpStr = '';
    end
    if ~isempty(grpStr)
        for iK = 1:nKeys-1
            vdo.addMultipleKeysToGroup([grpStr stimKeys{iK}],...
                rcd.ID,'acuity',stimKeys{iK},rcd.Hemi);
        end
    end
end

%% Launch a group data plot viewer and populate
fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  stimKeys(1:end-1));
GroupDataBarPlotter('newRow',fh1,...
  {'Estrus' 'Diestrus'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'Staged_Acuity_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'Staged_Acuity_Indexed.csv'));

%%
interleavedGrps = cell(1,2*(nKeys-1));
for iD = 1:nKeys-1
    interleavedGrps{2*iD-1} = diestrusGrps{iD};
    interleavedGrps{2*iD} = estrusGrps{iD};
end
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_Staged_Acuity'),'-depsc');

%% Plot group traces

fh = figure;
hold on
legStr = cell(1,nKeys-1);
for iG = 1:length(diestrusGrps)
    grpID = diestrusGrps{iG}.ID;
    newGrp = VEPTraceGroupClass(vdo,'tmp');
    newGrp.copyExistingGroup(diestrusGrps{iG},'OrphanGroup');
    [trace,tTr] = newGrp.getMeanTrace;
    delete(newGrp);
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iG} = grpID;
end
title("Diestrus")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_Acuity'),'-depsc');

fh = figure;
hold on
legStr = cell(1,nKeys-1);
for iG = 1:length(estrusGrps)
    grpID = estrusGrps{iG}.ID;
    newGrp = VEPTraceGroupClass(vdo,'tmp');
    newGrp.copyExistingGroup(estrusGrps{iG},'OrphanGroup');
    [trace,tTr] = newGrp.getMeanTrace;
    delete(newGrp);
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iG} = grpID;
end
title("Estrus")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_Acuity'),'-depsc');
