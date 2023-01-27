% Define stimulus event codes used in Schecter et al.
abcdKeys = {'Abcd','aBcd','abCd','abcD'};
dcbaKeys = {'Dcba','dCba','dcBa','dcbA'};
seqStimDefs = containers.Map;
seqStimDefs(abcdKeys{1}) = 1;
seqStimDefs(abcdKeys{2}) = 2;
seqStimDefs(abcdKeys{3}) = 3;
seqStimDefs(abcdKeys{4}) = 4;
seqStimDefs(dcbaKeys{1}) = 11;
seqStimDefs(dcbaKeys{2}) = 12;
seqStimDefs(dcbaKeys{3}) = 13;
seqStimDefs(dcbaKeys{4}) = 14;

srpStimDefs = containers.Map;
srpStimDefs('Fam') = [1 2];
srpStimDefs('Nov') = [3 4];

acuityStimDef = containers.Map;
acuityStimDef('0.05') = [1 2];
acuityStimDef('0.1') = [3 4];
acuityStimDef('0.2') = [5 6];
acuityStimDef('0.3') = [7 8];
acuityStimDef('0.4') = [9 10];
acuityStimDef('0.5') = [11 12];
acuityStimDef('0.6') = [13 14];
acuityStimDef('0.7') = [15 16];
acuityStimDef('Noise') = 0;

% Make sure required code is in the path
addpath('./Support Code');
addpath('./Group Definitions');
