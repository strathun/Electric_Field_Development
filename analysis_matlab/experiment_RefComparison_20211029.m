%% experiment_RefComparison_20211029
% Preliminary comparison of the Pt and AgAgCl (pine) reference electrodes.
% Ultimate goal here is to get a nice CV with a known reference to use for
% the FEM model fitting. Note: this is also with Gibco PBS solution.

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
    extractCVData('..\rawData\Gamry\20211029_TDT22_InVitro_Gib1xPBS\CV');
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211029_TDT22_InVitro_Gib1xPBS\EIS');

%% CV quick
% E08
figure
colorArray = lines(7);
for ii = 6:7
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')
% E12
figure
colorArray = lines(9);
for ii = 8:9
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')

% Pt Electrode
% I think both r1 and r2 were actually both AgAgCl here. 
figure
colorArray = lines(2);
for ii = 1:2
    for jj = 1:3
        scatter( gamryStructure_CV(ii).potential{jj}, ...
                 gamryStructure_CV(ii).current{jj}, [],colorArray( ii, : ), '.')
        hold on
    end
end
legend('AgAgCl')

%%
% Looks like maybe the Pt electrode is about 50-100mV more positive than
% the AgAgCl? Pretty close really. This is pretty close to the ~112 mV
% deltaV between the Pt and AgAgCl electrodes. 
% See what happens when the Pt CV plots are shifted down by 112 mV. Do they
% match up?
% Real takeway is that I should repeat this with a good TDT electrode. 

%% Impedance and phase before and after (E09 and E08). 
figure
colorArray = lines(8);
for ii = 2:3
    yyaxis left
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('AgAgCl')
xlim([10 1e5])

figure
colorArray = lines(8);
for ii = 4:5
    yyaxis left
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('AgAgCl')
xlim([10 1e5])

figure
colorArray = lines(8);
for ii = 6:7
    yyaxis left
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
    ylabel('mag(Impedance) (Ohm)')
    yyaxis right
    semilogx( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
end
xlabel('Frequency (Hz)') 
legend('AgAgCl')
xlim([10 1e5])

%% 
% Looks very consistent between references, which is good. Would have been
% surprising if this varied by much. 