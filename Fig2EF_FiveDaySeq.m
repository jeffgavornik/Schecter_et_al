%#ok<*SAGROW>

AnalysisSetup;
% Score B&C only
bcKeys = abcdKeys(2:3);
cbKeys = dcbaKeys(2:3);

days = [1 2 3 4 5];

dataPath = 'Data/gender sequence data/';
figPath = './Figures/Fig2EF';
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

% Create groups for all days of ABCD
baseName = "define5DaySeqXXXDayYYYGroup";
genders = ["Female" "Male"];
for gender = genders
    cmdNameGndr = regexprep(baseName,'XXX',gender);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        groupFiles = eval(cmdName);
        thePath = [dataPath char(lower(gender + " plx/"))];
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
mABCD = vdo.createNewGroup("Male ABCD",'VEPMagGroupClass');
mABCDTr = vdo.createNewGroup("Male ABCDtrace",'VEPTraceGroupClass');
fABCD = vdo.createNewGroup("Female ABCD",'VEPMagGroupClass');
fABCDTr = vdo.createNewGroup("Female ABCDtrace",'VEPTraceGroupClass');
mDCBA = vdo.createNewGroup("Male DCBA",'VEPMagGroupClass');
mDCBATr = vdo.createNewGroup("Male DCBAtrace",'VEPTraceGroupClass');
fDCBA = vdo.createNewGroup("Female DCBA",'VEPMagGroupClass');
fDCBATr = vdo.createNewGroup("Female DCBAtrace",'VEPTraceGroupClass');
for gender = genders
    cmdNameGndr = regexprep(baseName,'XXX',gender);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        [~,lhFiles,rhFiles] = eval(cmdName);
        grpKey = gender + " Day" + num2str(day);
        grpTrcKey = grpKey+"trace";
        grps{end+1} = vdo.createNewGroup(grpKey,'VEPMagGroupClass'); 
        trGrps{end+1} = vdo.createNewGroup(grpTrcKey,'VEPTraceGroupClass');
        grpSex(end+1) = gender == "Male";
        for iF = 1:length(lhFiles)
            theFile = lhFiles{iF};
            parts = split(theFile,'_');
            animalID = parts{1};
            sessionID = parts{2};
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,bcKeys,'LH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Abcd','LH');
            if day == 5
                vdo.addMultipleKeysToGroup(gender+" ABCD",animalID,...
                    sessionID,bcKeys,'LH');
                vdo.addMultipleKeysToGroup(gender+" ABCDtrace",animalID,...
                    sessionID,'Abcd','LH');
                vdo.addMultipleKeysToGroup(gender+" DCBA",animalID,...
                    sessionID,cbKeys,'LH');
                vdo.addMultipleKeysToGroup(gender+" DCBAtrace",animalID,...
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
            if day == 5
                vdo.addMultipleKeysToGroup(gender+" ABCD",animalID,...
                    sessionID,bcKeys,'RH');
                vdo.addMultipleKeysToGroup(gender+" ABCDtrace",animalID,...
                    sessionID,'Abcd','RH');
                vdo.addMultipleKeysToGroup(gender+" DCBA",animalID,...
                    sessionID,cbKeys,'RH');
                vdo.addMultipleKeysToGroup(gender+" DCBAtrace",animalID,...
                    sessionID,'Dcba','RH');
            end
        end
    end
end
femaleGrps = grps(~grpSex);
maleGrps = grps(grpSex);
femaleTrcGrps = trGrps(~grpSex);
maleTrcGrps = trGrps(grpSex);

%%
for day = days
    normalizeByGroupMean(vdo,['Female Day' num2str(day)],'Female Day1');
    normalizeByGroupMean(vdo,['Male Day' num2str(day)],'Male Day1');
end
normalizeByGroupMean(vdo,'Female ABCD','Female Day1');
normalizeByGroupMean(vdo,'Female DCBA','Female Day1');
normalizeByGroupMean(vdo,'Male ABCD','Male Day1');
normalizeByGroupMean(vdo,'Male DCBA','Male Day1');



%% Launch a group data plot viewer and populate
dayStrs = {'Day1' 'Day2' 'Day3' 'Day4' 'Day5'};
fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  dayStrs(days));
GroupDataBarPlotter('newRow',fh1,...
  {'Male' 'Female'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'SexFiveDaySeq_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'SexFiveDaySeq_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh1,'on')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'SexFiveDaySeq_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'SexFiveDaySeq_Norm_Indexed.csv'));

%%

fh2 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh2,...
  {'Day1' 'ABCD' 'DCBA'});
GroupDataBarPlotter('newRow',fh2,...
  {'Male' 'Female'})
GroupDataBarPlotter('AutoFill',fh2)
GroupDataBarPlotter('SetPlotStyle',fh2,'Box')

GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'SexABCDvsDCBASeq_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'SexABCDvsDCBASeq_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh2,'on')
GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'SexABCDvsDCBASeq_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'SexABCDvsDCBASeq_Norm_Indexed.csv'));


%%
interleavedGrps = cell(1,2*length(days));
for iD = 1:length(days)
    interleavedGrps{2*iD-1} = femaleGrps{iD};
    interleavedGrps{2*iD} = maleGrps{iD};
end
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5'),'-depsc');

%%
interleavedGrps{end+1} = fDCBA;
interleavedGrps{end+1} = mDCBA;
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5_DCBA'),'-depsc');

%%
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5_Norm'),'-depsc');

%%
interleavedGrps{end+1} = fDCBA;
interleavedGrps{end+1} = mDCBA;
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5_DCBA_Norm'),'-depsc');

%%
interleavedGrps = {femaleGrps{1} maleGrps{1} fABCD mABCD fDCBA mDCBA};
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_ABCDvsDCBA'),'-depsc');

fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_BCDvsDCBA_Norm'),'-depsc');



%% Plot group traces
fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = femaleTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Female")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Female_Day1to5_ABCD'),'-depsc');

fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = maleTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Male")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Male_Day1to5_ABCD'),'-depsc');

%% Plot group traces

[fABCD_,tTr] = fABCDTr.getMeanTrace;
[fDCBA_,tTr] = fDCBATr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,fABCD_,1e3*tTr,fDCBA_,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Female")
legend('ABCD','DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Female_ABCDvsDCBA'),'-depsc');

[mABCD_,tTr] = mABCDTr.getMeanTrace;
[mDCBA_,tTr] = mDCBATr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,mABCD_,1e3*tTr,mDCBA_,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Male")
legend('ABCD','DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Male_ABCDvsDCBA'),'-depsc');

%% Plot group traces
fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = femaleTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
[trace,tTr] = fDCBATr.getMeanTrace;
plot(1e3*tTr,trace,'linewidth',2);
legStr{iD+1} = "DCBA";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Female")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Female_Day1to5_ABCDandDBCA'),'-depsc');

fh = figure;
hold on
legStr = cell(1,length(days));
for iD = 1:length(days)
    [trace,tTr] = maleTrcGrps{iD}.getMeanTrace;
    plot(1e3*tTr,trace,'linewidth',2);
    legStr{iD} = "Day "+days(iD);
end
[trace,tTr] = mDCBATr.getMeanTrace;
plot(1e3*tTr,trace,'linewidth',2);
legStr{iD+1} = "DCBA";
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Male")
legend(legStr);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Male_Day1to5_ABCDandDBCA'),'-depsc');



