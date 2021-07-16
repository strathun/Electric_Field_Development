%% experiment_EFRejuvenation_Gamry_2021615
% Trying to determine what caused the rejuvenation of the electrode after
% the last EF experiment. Interestingly, this time there seemed to be very
% little effect on the E09 electrode, even though the exact same experiment
% was performed. To test the consistency of all of this, I tried applying
% an EF across and second electrode (E16). 
% Recovery_1 = diH20 rinse (then back into same PBS)
% Recovery_2 = diH20 rinse and new PBS (10 minute soak B4 measuring)
% Recovery_3 = 1 hour soak in the same PBS from Recovery_2
% Recovery_4 = One day later with regular drying/cleaning/rinsing, etc. 
close all 
clearvars 

% Sets relative filepaths from this script
currentFile = mfilename( 'fullpath' );
cd(fileparts(currentFile));
addpath(genpath('../matlab'));
addpath(genpath('../rawData'));
addpath(genpath('../output'));
parts = strsplit(currentFile, {'\', '\'});
outputDir = ['../output/' parts{end}];
[~, ~] = mkdir(outputDir);

%% Extract impedance data
[gamryStructure_CV] = ...
    extractCVData('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_CV');
[gamryStructure_CV_recovery1] = ...
    extractCVData('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_CV_recovery1');
[gamryStructure_CV_recovery2] = ...
    extractCVData('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_CV_recovery2');
[gamryStructure_CV_recovery3] = ...
    extractCVData('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_CV_recovery3');
[gamryStructure_CV_recovery4] = ...
    extractCVData('..\rawData\Gamry\20210616_TDT22_InVitro_1xPBS_CV_recovery4');
% [gamryStructure_EF] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20210521_TDT22_InVitro_1xPBS_EF');
[gamryStructure_EIS_pre] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EIS_pre');
[gamryStructure_EIS_post] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EIS_post');
[gamryStructure_EIS_recovery1] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EIS_recovery1');
[gamryStructure_EIS_recovery2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EIS_recovery2');
[gamryStructure_EIS_recovery3] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EIS_recovery3');
[gamryStructure_EIS_recovery4] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210616_TDT22_InVitro_1xPBS_EIS_recovery4');

%% Plot of stim/current
% Come back to this one. Will need to make a new function. Just open in
% ECHEM analyst for now. 

%% Impedance and phase before and after (E09 and E08). 
figure
colorArray = lines(2);
pointerArray_pre = [4, 2]; %E09, E08
pointerArray_post = [6, 2]; %E09, E08
for ii = 1:2
    jj = pointerArray_pre(ii);
    kk = pointerArray_post(ii);
    yyaxis left
    loglog( gamryStructure_EIS_pre(jj).f, ...
            gamryStructure_EIS_pre(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    loglog( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_pre(jj).f, ...
            gamryStructure_EIS_pre(jj).Phase, ...
            '--','Color', colorArray( ii, : ))
    hold on
    semilogx( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('EStim')
xlim([10 1e5])
title('Impedance and Phase changes before and after 200mV/mm Stim - E09')

%% CV before and after (E09 and E08)
% Showing scan 3 of 3 for each plot. 
figure
colorArray = lines(3);
pointerArray_E09 = [4 5];
pointerArray_E08 = [1 2];
for ii = 1:2
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E09
scatter( gamryStructure_CV(jj).potential{3}, ...
         gamryStructure_CV(jj).current{3}, [], '.')
     hold on
% E08
scatter( gamryStructure_CV(kk).potential{3}, ...
         gamryStructure_CV(kk).current{3}, [], '.')
end
legend('EStim - pre', 'EControl - pre', 'Estim - post', 'EControl - post')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV pre and post stim - E09')
xlim([-0.8 1])
%% Impedance and phase before and after (E16 and E08). 
% Repeated the 200mV/mm EF witha second electrode to see if it reacted the
% way E09 did during the first experiment. 
figure
colorArray = lines(2);
pointerArray_pre = [6, 2]; %E16, E08
pointerArray_post = [8, 4]; %E16, E08
for ii = 1:2
    jj = pointerArray_pre(ii);
    kk = pointerArray_post(ii);
    yyaxis left
    loglog( gamryStructure_EIS_pre(jj).f, ...
            gamryStructure_EIS_pre(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    loglog( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_pre(jj).f, ...
            gamryStructure_EIS_pre(jj).Phase, ...
            '--','Color', colorArray( ii, : ))
    hold on
    semilogx( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    
end
xlabel('Frequency (Hz)') 
ylabel('Phase')
legend('EStim')
xlim([10 1e5])
title('Impedance and Phase changes before and after 200mV/mm Stim - E16')
%% CV before and after (E16 and E08)
% Showing scan 3 of 3 for each plot. 
figure
colorArray = lines(3);
pointerArray_E09 = [6 7]; %Actually E16
pointerArray_E08 = [2 3];
for ii = 1:2
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E16
scatter( gamryStructure_CV(jj).potential{3}, ...
         gamryStructure_CV(jj).current{3}, [], '.')
     hold on
% E08
scatter( gamryStructure_CV(kk).potential{3}, ...
         gamryStructure_CV(kk).current{3}, [], '.')
end
legend('EStim - pre', 'EControl - pre', 'Estim - post', 'EControl - post')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV pre and post stim - E16')
xlim([-0.8 1])

%% Visualizing (CV) Recovery Progression for E16 (stim)
figure
% E16 b4 stim
scatter( gamryStructure_CV(6).potential{3}, ...
         gamryStructure_CV(6).current{3}, [], '.')
     hold on
% E16 after stim
scatter( gamryStructure_CV(7).potential{3}, ...
         gamryStructure_CV(7).current{3}, [], '.')
% E16 Recovery 1
scatter( gamryStructure_CV_recovery1(2).potential{3}, ...
         gamryStructure_CV_recovery1(2).current{3}, [], '.')
% E16 Recovery 2
scatter( gamryStructure_CV_recovery2(2).potential{3}, ...
         gamryStructure_CV_recovery2(2).current{3}, [], '.')
% E16 Recovery 3
scatter( gamryStructure_CV_recovery3(2).potential{3}, ...
         gamryStructure_CV_recovery3(2).current{3}, [], '.')
% E16 Recovery 3
scatter( gamryStructure_CV_recovery4(2).potential{3}, ...
         gamryStructure_CV_recovery4(2).current{3}, [], '.')
legend('B4 Stim', 'Post Stim', 'diH20', 'Fresh PBS', '1hr Soak')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV progression for stimulated electrode')
xlim([-0.8 1])
%% Visualizing (CV)Progression for E08 (control)
figure
% E16 b4 stim
scatter( gamryStructure_CV(2).potential{3}, ...
         gamryStructure_CV(2).current{3}, [], '.')
     hold on
% E16 after stim
scatter( gamryStructure_CV(3).potential{3}, ...
         gamryStructure_CV(3).current{3}, [], '.')
% E16 Recovery 1
scatter( gamryStructure_CV_recovery1(1).potential{3}, ...
         gamryStructure_CV_recovery1(1).current{3}, [], '.')
% E16 Recovery 2
scatter( gamryStructure_CV_recovery2(1).potential{3}, ...
         gamryStructure_CV_recovery2(1).current{3}, [], '.')
% E16 Recovery 3
scatter( gamryStructure_CV_recovery3(1).potential{3}, ...
         gamryStructure_CV_recovery3(1).current{3}, [], '.')
% E08 Recovery 4
scatter( gamryStructure_CV_recovery4(1).potential{3}, ...
         gamryStructure_CV_recovery4(1).current{3}, [], '.')
legend('B4 Stim', 'Post Stim', 'diH20', 'Fresh PBS', '1hr Soak')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV progression for control electrode')
xlim([-0.8 1])
%%
% Exact same trend happening with the unstimulated electrode... Maybe
% somethings happening with the counter electrode? If this is the case,
% this will likely be mitigated with the larger surface area counter
% electrode. 

%% Quick test to see if CV has any effect on impedance
% Trying to avoid having to do two EIS measurements each time. 
% Here, I'm plotting the EIS measurements from before and after CV
% measurements I made each time
numTests = 4;
colorArray = lines(numTests);
for ii = 1:numTests
    figure
    jj = ii + 1;
    kk = ii + 2;
    yyaxis left
    loglog( gamryStructure_EIS_post(jj).f, ...
            gamryStructure_EIS_post(jj).Zmag)
    hold on
    loglog( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Zmag)
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_post(jj).f, ...
            gamryStructure_EIS_post(jj).Phase)
    hold on
    semilogx( gamryStructure_EIS_post(kk).f, ...
            gamryStructure_EIS_post(kk).Phase)
    ylabel('Phase')
    xlabel('Frequency (Hz)') 
    legend('Pre CV', 'Post CV')
    xlim([10 1e5])
    title('Impedance before and after CV')
end


%%
% Does seem like there is some effect from the CV in at least one case of
% the sample above. I will keep taking EIS, CV, EIS measurements just to
% have this record. This is something worth exploring in the future
% (hopefully not by me...). 