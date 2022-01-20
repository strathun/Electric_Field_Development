%% experiment_WPITest_20211117
% Want to make sure all of the custom cut WPI electrode behave well. 

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
    extractCVData('..\rawData\Gamry\20211116_WPI01_03_InVitro_Gib1xPBS\CV');
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211116_WPI01_03_InVitro_Gib1xPBS\EIS');

%% CV quick
% E08
figure
colorArray = lines(7);
for ii = 3
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')
title('WPI1')
% E12
figure
colorArray = lines(9);
for ii = 4
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')
title('WPI2')
figure
colorArray = lines(5);
for ii = 5
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')
title('WPI3')

%% Impedance and phase before and after (E09 and E08). 
figure
colorArray = lines(8);
for ii = 1:3
    yyaxis left
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 1:3
    yyaxis right
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
legend('WPI1', 'WPI2', 'WPI3')

%% 
% Impedance and phase looks very consistent between electrodes. Good news!