%#ok<*SAGROW>

AnalysisSetup;
% Score B&C only
bcKeys = abcdKeys(2:3);
cbKeys = dcbaKeys(2:3);

days = [1 2];

dataPath = 'Data/gender sequence+staging data/';
figPath = './Figures/Fig4HI';
[~,~,~] = mkdir(figPath);

figType = '-depsc';

realStimTime = 0.1667; % stim timing issue, draw cmds issued one frame late
extractTimeWindow = 4 * realStimTime;
yLims = [-500 500];
stimXs = realStimTime * [0 1 2 3];

%%
% Create VDO and add data
vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = seqStimDefs;

baseName = "define2DayStagedSeqXXXDayYYYGroup";
stages = ["Diestrus" "Estrus"];
for stage = stages
    cmdNameGndr = regexprep(baseName,'XXX',stage);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        groupFiles = eval(cmdName);
        thePath = [dataPath  lower(char(stage)) '/'];
        for iF = 1:length(groupFiles)
            theFile = groupFiles{iF};
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
            vdo.addDataFromPlxFile([theFile '.plx'],thePath,animalID,sessionID);
        end
    end
end

%%
% Create groups for all days and order
vdo.deleteAllGroups
grps = {};
trGrps = {};
grpSex = logical([]);
eABCD = vdo.createNewGroup("Estrus ABCD",'VEPMagGroupClass');
eABCDTr = vdo.createNewGroup("Estrus ABCDtrace",'VEPTraceGroupClass');
dABCD = vdo.createNewGroup("Diestrus ABCD",'VEPMagGroupClass');
dABCDTr = vdo.createNewGroup("Diestrus ABCDtrace",'VEPTraceGroupClass');
eDCBA = vdo.createNewGroup("Estrus DCBA",'VEPMagGroupClass');
eDCBATr = vdo.createNewGroup("Estrus DCBAtrace",'VEPTraceGroupClass');
dDCBA = vdo.createNewGroup("Diestrus DCBA",'VEPMagGroupClass');
dDCBATr = vdo.createNewGroup("Diestrus DCBAtrace",'VEPTraceGroupClass');
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
                sessionID,bcKeys,'LH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Abcd','LH');
            if day == 2
                vdo.addMultipleKeysToGroup(stage+" ABCD",animalID,...
                    sessionID,bcKeys,'LH');
                vdo.addMultipleKeysToGroup(stage+" ABCDtrace",animalID,...
                    sessionID,'Abcd','LH');
                vdo.addMultipleKeysToGroup(stage+" DCBA",animalID,...
                    sessionID,cbKeys,'LH');
                vdo.addMultipleKeysToGroup(stage+" DCBAtrace",animalID,...
                    sessionID,'Dcba','LH');
            end
        end
        for iF = 1:length(rhFiles)
            theFile = rhFiles{iF};
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,bcKeys,'RH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Abcd','RH');
            if day == 2
                vdo.addMultipleKeysToGroup(stage+" ABCD",animalID,...
                    sessionID,bcKeys,'RH');
                vdo.addMultipleKeysToGroup(stage+" ABCDtrace",animalID,...
                    sessionID,'Abcd','RH');
                vdo.addMultipleKeysToGroup(stage+" DCBA",animalID,...
                    sessionID,cbKeys,'RH');
                vdo.addMultipleKeysToGroup(stage+" DCBAtrace",animalID,...
                    sessionID,'Dcba','RH');
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
normalizeByGroupMean(vdo,'Diestrus ABCD','Diestrus Day1');
normalizeByGroupMean(vdo,'Diestrus DCBA','Diestrus Day1');
normalizeByGroupMean(vdo,'Estrus ABCD','Estrus Day1');
normalizeByGroupMean(vdo,'Estrus DCBA','Estrus Day1');


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
    fullfile(figPath,'TwoDayStagedSeq_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'TwoDayStagedSeq_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh1,'on')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'TwoDayStagedSeq_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'TwoDayStagedSeq_Norm_Indexed.csv'));

fh2 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh2,...
  {'Day1' 'ABCD' 'DCBA'});
GroupDataBarPlotter('newRow',fh2,...
  {'Estrus' 'Diestrus'})
GroupDataBarPlotter('AutoFill',fh2)
GroupDataBarPlotter('SetPlotStyle',fh2,'Box')

GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'ABCDvsDCBASeq_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'ABCDvsDCBASeq_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh2,'on')
GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'ABCDvsDCBASeq_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'ABCDvsDCBASeq_Norm_Indexed.csv'));

%%
interleavedGrps = cell(1,2*length(days));
for iD = 1:length(days)
    interleavedGrps{2*iD-1} = diestrusGrps{iD};
    interleavedGrps{2*iD} = estrusGrps{iD};
end
interleavedGrps{end+1} = dDCBA;
interleavedGrps{end+1} = eDCBA;
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_Day1to2_ABCDvsDCBA'),'-depsc');


fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_EvsD_Day1to2_Norm_ABCDvsDCBA'),'-depsc');


%% Plot group traces
fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = diestrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
plot(1e3*tTr,dDCBATr.getMeanTrace,'linewidth',2);
legStr{iD+1} = "DCBA";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Diestrus")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_Day1to2_ABCDvsDCBA'),'-depsc');

fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = estrusTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
plot(1e3*tTr,eDCBATr.getMeanTrace,'linewidth',2);
legStr{iD+1} = "DCBA";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Estrus")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_Day1to2_ABCDvsDCBA'),'-depsc');

%% Plot group traces
fh = figure;
hold on
plot(1e3*tTr,dABCDTr.getMeanTrace,1e3*tTr,dDCBATr.getMeanTrace,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Diestrus")
legend('ABCD','DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Diestrus_ABCDvsDCBA'),'-depsc');

fh = figure;
hold on
plot(1e3*tTr,eABCDTr.getMeanTrace,1e3*tTr,eDCBATr.getMeanTrace,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Estrus")
legend('ABCD','DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Estrus_ABCDvsDCBA'),'-depsc');



