%#ok<*SAGROW>

AnalysisSetup;

days = [1 2 3 4 5];

dataPath = 'Data/gender acuity data/';
figPath = './Figures/Fig1A';
[~,~,~] = mkdir(figPath);

figType = '-depsc';

extractTimeWindow = 0.25;
yLims = [-500 500];
stimXs = 0;


%%
% Create VDO and add data
vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.dataExtractParams.maxPositiveLatency = 0.2;
vdo.stimDefs = acuityStimDef;

femaleFiles = dir([dataPath 'female/*plx']);
maleFiles = dir([dataPath 'male/*plx']);

% Add all data
for iF = 1:length(femaleFiles)
    theFile = femaleFiles(iF).name;
    parts = split(theFile(1:end-4),'_');
    animalID = parts{1};
    sessionID = parts{2};
    vdo.addDataFromPlxFile(theFile,femaleFiles(iF).folder,animalID,sessionID);
end
for iF = 1:length(maleFiles)
    theFile = maleFiles(iF).name;
    parts = split(theFile(1:end-4),'_');
    animalID = parts{1};
    sessionID = parts{2};
    vdo.addDataFromPlxFile(theFile,maleFiles(iF).folder,animalID,sessionID);
end

%% Create groups
vdo.deleteAllGroups

stimKeys = acuityStimDef.keys;
nKeys = length(stimKeys);
maleGrps = cell(1,nKeys-1);
femaleGrps = cell(1,nKeys-1);
for iK = 1:nKeys-1
    femaleGrps{iK} = vdo.createNewGroup(['Female ' stimKeys{iK}],'VEPMagGroupClass');
    maleGrps{iK} = vdo.createNewGroup(['Male ' stimKeys{iK}],'VEPMagGroupClass');
end
noiseGrp = vdo.createNewGroup('Noise','VEPMagGroupClass');
for iK = 1:nKeys-1
    for iF = 1:length(femaleFiles)
        theFile = femaleFiles(iF).name;
        parts = split(theFile(1:end-4),'_');
        animalID = parts{1};
        sessionID = parts{2};
        vdo.addMultipleKeysToGroup(['Female ' stimKeys{iK}],animalID,...
            sessionID,stimKeys{iK},{'LH','RH'});
        vdo.addMultipleKeysToGroup('Noise',animalID,sessionID,'Noise',{'LH','RH'});
    end
    for iF = 1:length(maleFiles)
        theFile = maleFiles(iF).name;
        parts = split(theFile(1:end-4),'_');
        animalID = parts{1};
        sessionID = parts{2};
        vdo.addMultipleKeysToGroup(['Male ' stimKeys{iK}],animalID,...
            sessionID,stimKeys{iK},{'LH','RH'});
        vdo.addMultipleKeysToGroup('Noise',animalID,sessionID,'Noise',{'LH','RH'});
    end
end
vdo.removeSpecifiersFromAllGroups({'gend0329W'  },[],[],[]);
vdo.removeSpecifiersFromAllGroups({'gend0202Q' 'gend0202N' 'gend0518HH'},[],[],'RH');
vdo.removeSpecifiersFromAllGroups({'gend0329X' 'gend0329Y' 'gend0116J' 'gend0202M' 'gend0518II'},[],[],'LH');

%% Launch a group data plot viewer and populate
fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  stimKeys(1:end-1));
GroupDataBarPlotter('newRow',fh1,...
  {'Female' 'Male'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'Sex_Acuity_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'Sex_Acuity_Indexed.csv'));

%%
interleavedGrps = cell(1,2*(nKeys-1));
for iD = 1:nKeys-1
    interleavedGrps{2*iD-1} = femaleGrps{iD};
    interleavedGrps{2*iD} = maleGrps{iD};
end
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_Sex_Acuity'),'-depsc');

%% Plot group traces

fh = figure;
hold on
legStr = cell(1,nKeys-1);
for iG = 1:length(femaleGrps)
    grpID = femaleGrps{iG}.ID;
    newGrp = VEPTraceGroupClass(vdo,'tmp');
    newGrp.copyExistingGroup(femaleGrps{iG},'OrphanGroup');
    [trace,tTr] = newGrp.getMeanTrace;
    delete(newGrp);
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iG} = grpID;
end
title("Female")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Female_Acuity'),'-depsc');

fh = figure;
hold on
legStr = cell(1,nKeys-1);
for iG = 1:length(maleGrps)
    grpID = maleGrps{iG}.ID;
    newGrp = VEPTraceGroupClass(vdo,'tmp');
    newGrp.copyExistingGroup(maleGrps{iG},'OrphanGroup');
    [trace,tTr] = newGrp.getMeanTrace;
    delete(newGrp);
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iG} = grpID;
end
title("Male")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Male_Acuity'),'-depsc');
