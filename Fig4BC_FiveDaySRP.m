%#ok<*SAGROW>

AnalysisSetup;

days = [1 2 3 4 5];

dataPath = 'Data/gender srp+staging data/';
figPath = './Figures/Fig4BC';
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

baseName = "define5DayStagedSRPXXXDayYYYGroup";
stages = ["Diestrus" "Estrus"];
for stage = stages
    cmdNameGndr = regexprep(baseName,'XXX',stage);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        groupFiles = eval(cmdName);
        thePath = [dataPath char(lower(stage + "/"))];
        for iF = 1:length(groupFiles)
            theFile = [groupFiles{iF} '.plx'];
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
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
            theFile = lhFiles{iF};
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,'Fam','LH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Fam','LH');
            if day == 5
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
            theFile = rhFiles{iF};
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,'Fam','RH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Fam','RH');
            if day == 5
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
    fullfile(figPath,'FiveDaySRP_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'FiveDaySRP_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh1,'on')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'FiveDaySRP_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'FiveDaySRP_Norm_Indexed.csv'));

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
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_Day1to5'),'-depsc');


fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_Day1to5_Norm'),'-depsc');


%% Plot group traces
fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = diestrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Diestrus")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_Day1to5_FAM'),'-depsc');

fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = estrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Estrus")
ylim(yLims);
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_Day1to5_FAM'),'-depsc');

%% Plot group traces

[dFAM,tTr] = dFAMTr.getMeanTrace;
[dNOV,tTr] = dNOVTr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,dFAM,1e3*tTr,dNOV,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Diestrus")
legend('FAM','NOV');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_FAMvsNOV'),'-depsc');

[eFAM,tTr] = eFAMTr.getMeanTrace;
[eNOV,tTr] = eNOVTr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,eFAM,1e3*tTr,eNOV,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Estrus")
legend('FAM','NOV');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_FAMvsNOV'),'-depsc');



