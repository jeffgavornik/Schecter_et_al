%#ok<*SAGROW>

AnalysisSetup;

days = [1 2 3 4 5];

dataPath = 'Data/gender srp data/';
figPath = './Figures/Fig2BC';
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

% Create groups for all days of FAM
baseName = "define5DaySRPXXXDayYYYGroup";
genders = ["Female" "Male"];
for gender = genders
    cmdNameGndr = regexprep(baseName,'XXX',gender);
    for day = days
        cmdName = regexprep(cmdNameGndr,'YYY',num2str(day));
        groupFiles = eval(cmdName);
        thePath = [dataPath char(lower(gender + "/"))];
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
mFAM = vdo.createNewGroup("Male FAM",'VEPMagGroupClass');
mFAMTr = vdo.createNewGroup("Male FAMtrace",'VEPTraceGroupClass');
fFAM = vdo.createNewGroup("Female FAM",'VEPMagGroupClass');
fFAMTr = vdo.createNewGroup("Female FAMtrace",'VEPTraceGroupClass');
mNOV = vdo.createNewGroup("Male NOV",'VEPMagGroupClass');
mNOVTr = vdo.createNewGroup("Male NOVtrace",'VEPTraceGroupClass');
fNOV = vdo.createNewGroup("Female NOV",'VEPMagGroupClass');
fNOVTr = vdo.createNewGroup("Female NOVtrace",'VEPTraceGroupClass');
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
                sessionID,'Fam','LH');
            vdo.addMultipleKeysToGroup(grpTrcKey,animalID,...
                sessionID,'Fam','LH');
            if day == 5
                vdo.addMultipleKeysToGroup(gender+" FAM",animalID,...
                    sessionID,'Fam','LH');
                vdo.addMultipleKeysToGroup(gender+" FAMtrace",animalID,...
                    sessionID,'Fam','LH');
                vdo.addMultipleKeysToGroup(gender+" NOV",animalID,...
                    sessionID,'Nov','LH');
                vdo.addMultipleKeysToGroup(gender+" NOVtrace",animalID,...
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
                vdo.addMultipleKeysToGroup(gender+" FAM",animalID,...
                    sessionID,'Fam','RH');
                vdo.addMultipleKeysToGroup(gender+" FAMtrace",animalID,...
                    sessionID,'Fam','RH');
                vdo.addMultipleKeysToGroup(gender+" NOV",animalID,...
                    sessionID,'Nov','RH');
                vdo.addMultipleKeysToGroup(gender+" NOVtrace",animalID,...
                    sessionID,'Nov','RH');
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
normalizeByGroupMean(vdo,'Female FAM','Female Day1');
normalizeByGroupMean(vdo,'Female NOV','Female Day1');
normalizeByGroupMean(vdo,'Male FAM','Male Day1');
normalizeByGroupMean(vdo,'Male NOV','Male Day1');


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
    fullfile(figPath,'SexFiveDaySRP_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'SexFiveDaySRP_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh1,'on')
GroupDataBarPlotter('OutputStatsTable',fh1,'Table',...
    fullfile(figPath,'SexFiveDaySRP_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh1,'Indexed',...
    fullfile(figPath,'SexFiveDaySRP_Norm_Indexed.csv'));

%%

fh2 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh2,...
  {'Day1' 'FAM' 'NOV'});
GroupDataBarPlotter('newRow',fh2,...
  {'Male' 'Female'})
GroupDataBarPlotter('AutoFill',fh2)
GroupDataBarPlotter('SetPlotStyle',fh2,'Box')

GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'SexFAMvsNOV_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'SexFAMvsNOV_Indexed.csv'));
GroupDataBarPlotter('SetNormalize',fh2,'on')
GroupDataBarPlotter('OutputStatsTable',fh2,'Table',...
    fullfile(figPath,'SexFAMvsNOV_Norm_Table.csv'));
GroupDataBarPlotter('OutputStatsTable',fh2,'Indexed',...
    fullfile(figPath,'SexFAMvsNOV_Norm_Indexed.csv'));

%%
interleavedGrps = cell(1,2*length(days));
for iD = 1:length(days)
    interleavedGrps{2*iD-1} = femaleGrps{iD};
    interleavedGrps{2*iD} = maleGrps{iD};
end
interleavedGrps{end+1} = fNOV;
interleavedGrps{end+1} = mNOV;
fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',false);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5'),'-depsc');


fh = figure;
[vs,ah] = violinPlotGroupData(interleavedGrps{:},...
    'ClipRange',false,'Bandwidth','BestGuess','Normalize',true);
ah.YLim(1) = 0;
savePlotToFile(fh,fullfile(figPath,'Violin_MvsF_Day1to5_Norm'),'-depsc');


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
savePlotToFile(fh,fullfile(figPath,'Female_Day1to5_FAM'),'-depsc');

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
savePlotToFile(fh,fullfile(figPath,'Male_Day1to5_FAM'),'-depsc');

%% Plot group traces

[fFAM,tTr] = fFAMTr.getMeanTrace;
[fNOV,tTr] = fNOVTr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,fFAM,1e3*tTr,fNOV,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Female")
legend('FAM','NOV');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Female_FAMvsNOV'),'-depsc');

[mFAM,tTr] = mFAMTr.getMeanTrace;
[mNOV,tTr] = mNOVTr.getMeanTrace;
fh = figure;
hold on
plot(1e3*tTr,mFAM,1e3*tTr,mNOV,'linewidth',2);
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
title("Male")
legend('FAM','NOV');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Male_FAMvsNOV'),'-depsc');



