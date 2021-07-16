%% experiment_EFMultiple_Gamry_20210616
% Trying multiple EF strenghts (all to be used in experiments) for E09.
% Using these to create DC impedance plot across our range of interest. 

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
    extractCVData('..\rawData\Gamry\20210616_TDT22_InVitro_1xPBS_CV');
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210616_TDT22_InVitro_1xPBS_EIS');
[gamryStructure_EF] = ...
    extractEFData('..\rawData\Gamry\20210616_TDT22_InVitro_1xPBS_EF');
[gamryStructure_EF_Day1] = ...
    extractEFData('..\rawData\Gamry\20210615_TDT22_InVitro_1xPBS_EF');
%% Plot of stim/current
% Come back to this one. Will need to make a new function. Just open in
% ECHEM analyst for now. 

%% Impedance and phase before and after each EF (E09 and E08). 
pointerArray_pre_E09 = [11 13 15 17];
pointerArray_post_E09 = [13 15 17 19];
pointerArray_pre_E08 = [2 4 6 8];
pointerArray_post_E08 = [4 6 8 10];
numEFs = length(pointerArray_pre_E09);
colorArray = lines(numEFs);
% E09
figure
% Pre Imp
for ii = 1:numEFs
    jj = pointerArray_pre_E09(ii);
    loglog( gamryStructure_EIS(jj).f, ...
            gamryStructure_EIS(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
end
% Post Imp
for ii = 1:numEFs
    kk = pointerArray_post_E09(ii);
    loglog( gamryStructure_EIS(kk).f, ...
            gamryStructure_EIS(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    hold on
end
xlabel('Frequency (Hz)') 
ylabel('mag(Impedance) (Ohm)')
legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
title('EStim; (-) Before, (o) After')
xlim([10 1e5])

figure
% Pre Phase
for ii = 1:numEFs
    jj = pointerArray_pre_E09(ii);
    loglog( gamryStructure_EIS(jj).f, ...
            gamryStructure_EIS(jj).Phase, ...
            'Color', colorArray( ii, : ))
    hold on
end
% Post Phase
for ii = 1:numEFs
    kk = pointerArray_post_E09(ii);
    loglog( gamryStructure_EIS(kk).f, ...
            gamryStructure_EIS(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    hold on
end
xlabel('Frequency (Hz)') 
ylabel('Phase')
legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
title('EStim; (-) Before, (o) After')
xlim([10 1e5])

% E08
figure
% Pre Imp
for ii = 1:numEFs
    jj = pointerArray_pre_E08(ii);
    loglog( gamryStructure_EIS(jj).f, ...
            gamryStructure_EIS(jj).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
end
% Post Imp
for ii = 1:numEFs
    kk = pointerArray_post_E08(ii);
    loglog( gamryStructure_EIS(kk).f, ...
            gamryStructure_EIS(kk).Zmag, ...
            'o','Color', colorArray( ii, : ))
    hold on
end
xlabel('Frequency (Hz)') 
ylabel('mag(Impedance) (Ohm)')
legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
title('Control; (-) Before, (o) After')
xlim([10 1e5])

figure
% Pre Phase
for ii = 1:numEFs
    jj = pointerArray_pre_E08(ii);
    loglog( gamryStructure_EIS(jj).f, ...
            gamryStructure_EIS(jj).Phase, ...
            'Color', colorArray( ii, : ))
    hold on
end
% Post Phase
for ii = 1:numEFs
    kk = pointerArray_post_E08(ii);
    loglog( gamryStructure_EIS(kk).f, ...
            gamryStructure_EIS(kk).Phase, ...
            'o','Color', colorArray( ii, : ))
    hold on
end
xlabel('Frequency (Hz)') 
ylabel('Phase')
legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
title('Control; (-) Before, (o) After')
xlim([10 1e5])
%% CV before and after (E09 and E08)
% Showing scan 3 of 3 for each plot. 
figure

pointerArray_E09 = [6 7 8 9 10];
pointerArray_E08 = [1 2 3 4 5];
numScans = length(pointerArray_E08);
colorArray = lines(numScans);
%E09
for ii = 1:numScans
jj = pointerArray_E09(ii);
% E09
scatter( gamryStructure_CV(jj).potential{3}, ...
         gamryStructure_CV(jj).current{3}, [], colorArray( ii, : ), '.')
     hold on
end
legend('Pre', '200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
xlabel('Potential (V)')
ylabel('Current (A)')
title('Estim')
xlim([-0.8 1])

%E08
figure
for ii = 1:numScans
kk = pointerArray_E08(ii);
% E08
scatter( gamryStructure_CV(kk).potential{3}, ...
         gamryStructure_CV(kk).current{3}, [], colorArray( ii, : ), '.')
     hold on
end
legend('Pre', '200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
xlabel('Potential (V)')
ylabel('Current (A)')
title('EControl')
xlim([-0.8 1])

%% I-V Relationship
% Plot of I-V and R-V
% Take average of the total current over the duration of the measurement
EForder = [1 3 4 5];
for ii = 1:4
    jj = EForder(ii);
    currentArray(ii) = mean( gamryStructure_EF(jj).current );
    voltageArray(ii) = gamryStructure_EF(jj).potential(20);   % grabs one voltage, should all be the same. 20 is arbitrary
    resistanceArray(ii) = voltageArray(ii) / currentArray(ii);
end
figure
scatter(voltageArray, currentArray,200, '*')
xlabel('Voltage (V)')
ylabel('Current (A)')
grid on
figure
scatter(voltageArray, resistanceArray,200, '*')
xlabel('Voltage (V)')
ylabel('Resistance (Ohm)')
grid on

% Plotting all but 2.5
figure
scatter(voltageArray(1:3), currentArray(1:3),200, '*')
xlabel('Voltage (V)')
ylabel('Current (A)')
grid on
figure
scatter(voltageArray(1:3), resistanceArray(1:3),200, '*')
xlabel('Voltage (V)')
ylabel('Resistance (Ohm)')
grid on

% Plot all currents for fun
strengthArray = [200 5 5 50 500];
for ii = 1:5
    figure
    plot(gamryStructure_EF(ii).time, gamryStructure_EF(ii).current*(1e6))
    grid on
    xlabel('Time (s)')
    ylabel('Current (uA)')
    title("Current for " + strengthArray(ii) + " mV/mm EF Field Strength")
end
%% 
% Interesting, the I-V relationship is actually pretty linear and the
% resistance is pretty consistent other than the 2.5V. 

%% EF consistency across days
% Looking at the consistency of the current required for a given EF
% strength (200 mV/mm) for a single electrode across two days. 


figure
% Day 1
plot(gamryStructure_EF_Day1(1).time, gamryStructure_EF_Day1(1).current*(1e6))
hold on
% Day 2
plot(gamryStructure_EF(1).time, gamryStructure_EF(1).current*(1e6))
grid on
xlabel('Time (s)')
ylabel('Current (uA)')
title("Current for 200 mV/mm EF Field Strength across 2 sessions")
legend('Session 1', 'Session 2')
