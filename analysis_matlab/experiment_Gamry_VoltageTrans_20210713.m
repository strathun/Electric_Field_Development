%% experiment_Gamry_VoltageTrans_20210713
% Just getting some pilot data for setting up voltage transient
% measurements. All data taken 20210713 using E11. 

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
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20210713_TDT22_InVitro_1xPBS_EIS');
[gamryStructure_VTrans] = ...
    extractVTransientData('..\rawData\Gamry\20210713_TDT22_InVitro_1xPBS_Transients');

%% Transients for 200 and 500 mV/mm EF strength
% Currents are based off averagre currents from 20210616 data
% 200 mV/mm
figure
subplot(2,1,1)
measPointer = 3;
plot( gamryStructure_VTrans(measPointer).time*1e3, ...
      gamryStructure_VTrans(measPointer).potential, 'LineWidth', 1.5)
ylabel('Voltage (V)')
title('Approx. 200 mV/mm Current')
subplot(2,1,2)
plot( gamryStructure_VTrans(measPointer).time*1e3, ...
      gamryStructure_VTrans(measPointer).current, 'LineWidth', 1.5)
ylabel('Current (A)')
xlabel('Time (ms)')

% 500 mV/mm
figure
subplot(2,1,1)
measPointer = 6;
plot( gamryStructure_VTrans(measPointer).time*1e3, ...
      gamryStructure_VTrans(measPointer).potential, 'LineWidth', 1.5)
ylabel('Voltage (V)')
title('Approx. 500 mV/mm Current')
subplot(2,1,2)
plot( gamryStructure_VTrans(measPointer).time*1e3, ...
      gamryStructure_VTrans(measPointer).current, 'LineWidth', 1.5)
ylabel('Current (A)')
xlabel('Time (ms)')


%% EIS Consistency
% Testing to see if any change in impedance from transient measurements
figure
colorArray = lines(2);
for ii = 1:2
    yyaxis left
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    ylabel('mag(Impedance) (Ohms)')
    yyaxis right
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, ...
            'Color', colorArray( ii, : ))
    hold on
    ylabel('Phase')
end
grid on
xlabel('Frequency (Hz)')
title('Impedance before (-) and after (--) current steps')
