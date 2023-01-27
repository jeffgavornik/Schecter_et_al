%#ok<*SAGROW>

AnalysisSetup;

days = [1 2];

dataPath = 'Data/2 Day SRP Staging Data/plx/';
figPath = './Figures/Fig4EF';
[~,~,~] = mkdir(figPath);

figType = '-depsc';

extractTimeWindow = 0.25;
yLims = [-500 500];
stimXs = 0;


%%
% Create VDO and add data
vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = srpStimDefs;

baseName = "define2DayStagedSRPXXXDayYYYGroup";
stages = ["Diestrus" "Estrus"];
for stage = stages
    cmdNameGndr = regexprep(baseName,'XXX',stage);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        groupFiles = eval(cmdName);
        thePath = dataPath;
        for iF = 1:length(groupFiles)
            plxFile = dir([dataPath '*' groupFiles{iF} '*plx']);
            theFile = plxFile.name;
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2}(1:end-4);
            vdo.addDataFromPlxFile(theFile,thePath,animalID,sessionID);
        end
    end
end

%%
% Create groups for all days and order
vdo.deleteAllGroups
grps = {};
trGrps = {};
grpSex = logical([]);
eFAM = vdo.createNewGroup("Estrus FAM",'VEPMagGroupClass');
eFAMTr = vdo.createNewGroup("Estrus FAMtrace",'VEPTraceGroupClass');
dFAM = vdo.createNewGroup("Diestrus FAM",'VEPMagGroupClass');
dFAMTr = vdo.createNewGroup("Diestrus FAMtrace",'VEPTraceGroupClass');
eNOV = vdo.createNewGroup("Estrus NOV",'VEPMagGroupClass');
eNOVTr = vdo.createNewGroup("Estrus NOVtrace",'VEPTraceGroupClass');
dNOV = vdo.createNewGroup("Diestrus NOV",'VEPMagGroupClass');
dNOVTr = vdo.createNewGroup("Diestrus NOVtrace",'VEPTraceGroupClass');
for stage = stages
    cmdNameGndr = regexprep(baseName,'XXX',stage);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        [~,lhFiles,rhFiles] = eval(cmdName);
        grpKey = stage + " Day" + num2str(day);
        grpTrcKey = grpKey+"trace";
        grps{end+1} = vdo.createNewGroup(grpKey,'VEPMagGroupClass'); 
        trGrps{end+1} = vdo.createNewGroup(grpTrcKey,'VEPTraceGroupClass');
        grpSex(end+1) = stage == "Estrus";
        for iF = 1:length(lhFiles)
            plxFile = dir([dataPath '*' lhFiles{iF} '*plx']);
            theFile = plxFile.name;
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2}(1:end-4);
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,'Fam','LH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Fam','LH');
            if day == 2
                vdo.addMultipleKeysToGroup(stage+" FAM",animalID,...
                    sessionID,'Fam','LH');
                vdo.addMultipleKeysToGroup(stage+" FAMtrace",animalID,...
                    sessionID,'Fam','LH');
                vdo.addMultipleKeysToGroup(stage+" NOV",animalID,...
                    sessionID,'Nov','LH');
                vdo.addMultipleKeysToGroup(stage+" NOVtrace",animalID,...
                    sessionID,'Nov','LH');
            end
        end
        for iF = 1:length(rhFiles)
            plxFile = dir([dataPath '*' rhFiles{iF} '*plx']);
            theFile = plxFile.name;
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2}(1:end-4);
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,'Fam','RH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Fam','RH');
            if day == 2
                vdo.addMultipleKeysToGroup(stage+" FAM",animalID,...
                    sessionID,'Fam','RH');
                vdo.addMultipleKeysToGroup(stage+" FAMtrace",animalID,...
                    sessionID,'Fam','RH');
                vdo.addMultipleKeysToGroup(stage+" NOV",animalID,...
                    sessionID,'Nov','RH');
                vdo.addMultipleKeysToGroup(stage+" NOVtrace",animalID,...
                    sessionID,'Nov','RH');
            end
        end
    end
end
diestrusGrps = grps(~grpSex);
estrusGrps = grps(grpSex);
diestrusTrcGrps = trGrps(~grpSex);
estrusTrcGrps = trGrps(grpSex);

%%
for day = days
    normalizeByGroupMean(vdo,['Diestrus Day' num2str(day)],'Diestrus Day1');
    normalizeByGroupMean(vdo,['Estrus Day' num2str(day)],'Estrus Day1');
end
normalizeByGroupMean(vdo,'Diestrus FAM','Diestrus Day1');
normalizeByGroupMean(vdo,'Diestrus NOV','Diestrus Day1');
normalizeByGroupMean(vdo,'Estrus FAM','Estrus Day1');
normalizeByGroupMean(vdo,'Estrus NOV','Estrus Day1');


%% Launch a group data plot viewer and populate
dayStrs = {'Day1' 'Day2' 'Day3' 'Day4' 'Day5'};
fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  dayStrs(days));
GroupDataBarPlotter('newRow',fh1,...
  {'Estrus' 'Diestrus'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'TwoDayStagedSRP_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'TwoDayStagedSRP_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh1,'on')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'TwoDayStagedSRP_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'TwoDayStagedSRP_Norm_Indexed.csv'));

%%

fh2 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh2,...
  {'Day1' 'FAM' 'NOV'});
GroupDataBarPlotter('newRow',fh2,...
  {'Estrus' 'Diestrus'})
GroupDataBarPlotter('AutoFill',fh2)
GroupDataBarPlotter('SetPlotStyle',fh2,'Box')

GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'FAMvsNOV_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'FAMvsNOV_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh2,'on')
GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'FAMvsNOV_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'FAMvsNOV_Norm_Indexed.csv'));

%%
interleavedGrps = cell(1,2*length(days));
for iD = 1:length(days)
    interleavedGrps{2*iD-1} = diestrusGrps{iD};
    interleavedGrps{2*iD} = estrusGrps{iD};
end
interleavedGrps{end+1} = dNOV;
interleavedGrps{end+1} = eNOV;
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_FamvsNov_Day1to2'),'-depsc');


fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_FamvsNov_Day1to2_Norm'),'-depsc');


%% Plot group traces
fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = diestrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
[trace,tTr] = dNOVTr.getMeanTrace;
plot(1e3*tTr,trace,'linewidth',2);
legStr{iD+1} = "Nov";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Diestrus")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_Day1to2_FAMvsNov'),'-depsc');

fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = estrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
[trace,tTr] = eNOVTr.getMeanTrace;
plot(1e3*tTr,trace,'linewidth',2);
legStr{iD+1} = "Nov";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Estrus")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_Day1to2_FAMvsNov'),'-depsc');



