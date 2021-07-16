%% experiment_EFeffects_Gamry_20210521
% Preliminary experiment to get a basic idea of the effects (if any) of 
% applying a DC EF in the range of what we're thinking for the EF
% experiments. All data here was taken on TDT22 in the new 1xPBS on
% 20210521. Electrode E09 received DC stimulation for 1 hour. 
% Follow-up data added from 20210601 to evaluate electrode recovery

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
    extractCVData('..\rawData\Gamry\20210521_TDT22_InVitro_1xPBS_CV');
[gamryStructure_CV_recovery] = ...
    extractCVData('..\rawData\Gamry\20210601_TDT22_InVitro_1xPBS_CV');
% [gamryStructure_EF] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20210521_TDT22_InVitro_1xPBS_EF');
[gamryStructure_EIS_r1] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210521_TDT22_InVitro_1xPBS_EIS_r1');
[gamryStructure_EIS_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210521_TDT22_InVitro_1xPBS_EIS_r2');
[gamryStructure_EIS_recovery] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210601_TDT22_InVitro_1xPBS_EIS');

%% Plot of stim/current
% Come back to this one. Will need to make a new function. Just open in
% ECHEM analyst for now. 

%% Impedance and phase before and after (E09 and E08). 
figure
colorArray = lines(2);
pointerArray_r1 = [8, 6]; %E09, E08
pointerArray_r2 = [6, 5]; %E09, E08
for ii = 1:2
    jj = pointerArray_r1(ii);
    kk = pointerArray_r2(ii);
    yyaxis left
    loglog( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    loglog( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Phase, ...
            '--','Color', colorArray( ii, : ))
    hold on
    semilogx( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('EStim')
%% Impedance and phase before and after (E01, 02, 04, 07, 13, 16)
figure
colorArray = lines(6);
pointerArray_r1 = [1, 2, 3, 4, 9, 10]; %(E01, 02, 04, 07, 13, 16)
pointerArray_r2 = [1, 2, 3, 4, 7, 08]; %(E01, 02, 04, 07, 13, 16)
for ii = 1:6
    jj = pointerArray_r1(ii);
    kk = pointerArray_r2(ii);
    yyaxis left
    loglog( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    loglog( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Phase, ...
            '--','Color', colorArray( ii, : ))
    hold on
    semilogx( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('EStim')
xlim([10 100000])
%%
% Interesting, looks like the shift upwards in phase at low frequencies is
% an array wide phenomena, not just with electrodes that underwent CV.
% Think about changes in the solution, or the counter electrode that could
% be causing this.
%% CV before and after (E09 and E08)
% Showing scan 3 of 3 for each plot. 
figure
colorArray = lines(3);
pointerArray_E09 = [6 7];
pointerArray_E08 = [4 5];
for ii = 1:2
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E09
scatter( gamryStructure_CV(jj).potential{3}, ...
         gamryStructure_CV(jj).current{3}, [], colorArray( 1, : ), '.')
     hold on
% E08
scatter( gamryStructure_CV(kk).potential{3}, ...
         gamryStructure_CV(kk).current{3}, [], colorArray( 2, : ), '.')
end
legend('EStim', 'EControl')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV pre and post stim')
%%
% Interesting. Looks like maybe the reaction in one direction was depleted
% and the other direction was magnified. May be able to undo this by
% reversing polarity for a bit? 

%% Visualizing Recover (CV)
figure
colorArray = lines(3);
pointerArray_E09 = [6 7];
pointerArray_E08 = [4 5];
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E09
scatter( gamryStructure_CV(6).potential{3}, ...
         gamryStructure_CV(6).current{3}, [], colorArray( 1, : ), '.')
     hold on
% E08
scatter( gamryStructure_CV(4).potential{3}, ...
         gamryStructure_CV(4).current{3}, [], colorArray( 2, : ), '.')
     
scatter( gamryStructure_CV_recovery(1).potential{3}, ...
         gamryStructure_CV_recovery(1).current{3}, [], colorArray( 2, : ), 'o')
scatter( gamryStructure_CV_recovery(3).potential{3}, ...
         gamryStructure_CV_recovery(3).current{3}, [], colorArray( 1, : ), 'o')
legend('EStim', 'EControl')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV pre stim and recover (Stim and Control)')

%% Impedance and phase recovery. 
figure
colorArray = lines(2);
pointerArray_r1 = [8, 6]; %E09, E08
pointerArray_r2 = [6, 5]; %E09, E08
for ii = 1:2
    jj = pointerArray_r1(ii);
    kk = pointerArray_r2(ii);
    yyaxis left
    loglog( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    loglog( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS_r1(jj).f, ...
            gamryStructure_EIS_r1(jj).Phase, ...
            '--','Color', colorArray( ii, : ))
    hold on
    semilogx( gamryStructure_EIS_r2(kk).f, ...
            gamryStructure_EIS_r2(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
yyaxis left
    semilogx( gamryStructure_EIS_recovery(5).f, ...
            gamryStructure_EIS_recovery(5).Zmag, ...
            '*','Color', colorArray( 1, : ))
    semilogx( gamryStructure_EIS_recovery(1).f, ...
            gamryStructure_EIS_recovery(1).Zmag, ...
            '*','Color', colorArray( 2, : ))
yyaxis right
    semilogx( gamryStructure_EIS_recovery(5).f, ...
            gamryStructure_EIS_recovery(5).Phase, ...
            '*','Color', colorArray( 1, : ))
    semilogx( gamryStructure_EIS_recovery(1).f, ...
            gamryStructure_EIS_recovery(1).Phase, ...
            '*','Color', colorArray( 2, : ))
xlim([10 100000])
xlabel('Frequency (Hz)') 
legend('EStim')
title('EIS Progression')
%%
% Looks like the stimulated electrode has as much variability from its
% original measurements as the unstimulated electrode. Maybe either new
% solution, soaking or sitting out of solution is all it takes to recover
% any damage from the DC current. Will need to investigate further, but
% this is promising. 

%% Visualizing changes from soaking (CV)
figure
colorArray = lines(3);
pointerArray_E09 = [6 7];
pointerArray_E08 = [4 5];
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E09
scatter( gamryStructure_CV_recovery(2).potential{3}, ...
         gamryStructure_CV_recovery(2).current{3}, [], 'o')
     hold on
% E08
scatter( gamryStructure_CV_recovery(3).potential{3}, ...
         gamryStructure_CV_recovery(3).current{3}, [], 'o')
legend('Time 0', '1 hour')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV EStim electrode recovery')

%%
% Relatively minor change from soak alone. This means that the recovery was
% not a result of the soaking. 

%% Visualizing (CV)Progression for E09 (stim)
figure
colorArray = lines(3);
pointerArray_E09 = [6 7];
pointerArray_E08 = [4 5];
jj = pointerArray_E09(ii);
kk = pointerArray_E08(ii);
% E09 b4 stim
scatter( gamryStructure_CV(6).potential{3}, ...
         gamryStructure_CV(6).current{3}, [], '.')
     hold on
% E09 after stim
scatter( gamryStructure_CV(7).potential{3}, ...
         gamryStructure_CV(7).current{3}, [], '.')
% E09 day 02
scatter( gamryStructure_CV_recovery(3).potential{3}, ...
         gamryStructure_CV_recovery(3).current{3}, [], '.')
legend('B4 Stim', 'Post Stim', 'Recovery')
xlabel('Potential (V)')
ylabel('Current (A)')
title('CV progression for stimulated electrode')