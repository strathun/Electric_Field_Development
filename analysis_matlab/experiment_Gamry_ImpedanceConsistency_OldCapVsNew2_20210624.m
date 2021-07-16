%% experiment_Gamry_ImpedanceConsistency_OldCapVsNew2_20210624
% Wanted to test to see if there are any differences between the two vial
% caps we use. Might account for some of the differences in the new TDTs we've
% seen.

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
    extractImpedanceDataGlobal('..\rawData\Gamry\20210624_TDT22_InVitro_1xPBS_CapTest');

%% Impedance and phase 

% E01
figure
% Impedance
for ii = 1:6
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('mag(Impedance)')
title('E01')

figure
% Phase
for ii = 1:6
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('Phase')
title('E01')

% E08
figure
% Impedance
for ii = 7:12
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('mag(Impedance)')
title('E08')

figure
% Phase
for ii = 7:12
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('Phase')
title('E08')

% E11
figure
% Impedance
for ii = 13:18
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('mag(Impedance)')
title('E11')

figure
% Phase
for ii = 13:18
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('Phase')
title('E11')

% E14
figure
% Impedance
for ii = 19:24
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('mag(Impedance)')
title('E14')

figure
% Phase
for ii = 19:24
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, 'LineWidth', 1.5 )
    hold on
end
legend('New Cap 1', 'New Cap 2', 'Old Cap 1', 'Old Cap 2', 'New Cap 3', 'Old Cap 3')
xlim([10 100000])
xlabel('Frequency')
ylabel('Phase')
title('E14')
