%% experiment_RefComparison_20211028
% Preliminary comparison of the Pt and AgAgCl (pine) reference electrodes.
% Ultimate goal here is to get a nice CV with a known reference to use for
% the FEM model fitting. Note: this is also with Gibco PBS solution.
% NOTE: Had some issues with the AgAgCl electrode this day. Look at 1029
% version instead. 

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
    extractCVData('..\rawData\Gamry\20211028_TDT22_InVitro_Gib1xPBS\CV');
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211028_TDT22_InVitro_Gib1xPBS\EIS');

% %% Impedance and phase before and after each EF (E09 and E08). 
% pointerArray_pre_E09 = [11 13 15 17];
% pointerArray_post_E09 = [13 15 17 19];
% pointerArray_pre_E08 = [2 4 6 8];
% pointerArray_post_E08 = [4 6 8 10];
% numEFs = length(pointerArray_pre_E09);
% colorArray = lines(numEFs);
% % E09
% figure
% % Pre Imp
% for ii = 1:numEFs
%     jj = pointerArray_pre_E09(ii);
%     loglog( gamryStructure_EIS(jj).f, ...
%             gamryStructure_EIS(jj).Zmag, ...
%             'Color', colorArray( ii, : ))
%     hold on
% end
% % Post Imp
% for ii = 1:numEFs
%     kk = pointerArray_post_E09(ii);
%     loglog( gamryStructure_EIS(kk).f, ...
%             gamryStructure_EIS(kk).Zmag, ...
%             'o','Color', colorArray( ii, : ))
%     hold on
% end
% xlabel('Frequency (Hz)') 
% ylabel('mag(Impedance) (Ohm)')
% legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% title('EStim; (-) Before, (o) After')
% xlim([10 1e5])
% 
% figure
% % Pre Phase
% for ii = 1:numEFs
%     jj = pointerArray_pre_E09(ii);
%     loglog( gamryStructure_EIS(jj).f, ...
%             gamryStructure_EIS(jj).Phase, ...
%             'Color', colorArray( ii, : ))
%     hold on
% end
% % Post Phase
% for ii = 1:numEFs
%     kk = pointerArray_post_E09(ii);
%     loglog( gamryStructure_EIS(kk).f, ...
%             gamryStructure_EIS(kk).Phase, ...
%             'o','Color', colorArray( ii, : ))
%     hold on
% end
% xlabel('Frequency (Hz)') 
% ylabel('Phase')
% legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% title('EStim; (-) Before, (o) After')
% xlim([10 1e5])
% 
% % E08
% figure
% % Pre Imp
% for ii = 1:numEFs
%     jj = pointerArray_pre_E08(ii);
%     loglog( gamryStructure_EIS(jj).f, ...
%             gamryStructure_EIS(jj).Zmag, ...
%             'Color', colorArray( ii, : ))
%     hold on
% end
% % Post Imp
% for ii = 1:numEFs
%     kk = pointerArray_post_E08(ii);
%     loglog( gamryStructure_EIS(kk).f, ...
%             gamryStructure_EIS(kk).Zmag, ...
%             'o','Color', colorArray( ii, : ))
%     hold on
% end
% xlabel('Frequency (Hz)') 
% ylabel('mag(Impedance) (Ohm)')
% legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% title('Control; (-) Before, (o) After')
% xlim([10 1e5])
% 
% figure
% % Pre Phase
% for ii = 1:numEFs
%     jj = pointerArray_pre_E08(ii);
%     loglog( gamryStructure_EIS(jj).f, ...
%             gamryStructure_EIS(jj).Phase, ...
%             'Color', colorArray( ii, : ))
%     hold on
% end
% % Post Phase
% for ii = 1:numEFs
%     kk = pointerArray_post_E08(ii);
%     loglog( gamryStructure_EIS(kk).f, ...
%             gamryStructure_EIS(kk).Phase, ...
%             'o','Color', colorArray( ii, : ))
%     hold on
% end
% xlabel('Frequency (Hz)') 
% ylabel('Phase')
% legend('200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% title('Control; (-) Before, (o) After')
% xlim([10 1e5])
%% CV quick
figure
for ii = 1:3
    scatter( gamryStructure_CV(1).potential{ii}, ...
             gamryStructure_CV(1).current{ii}, [], '.')
    hold on
end
for ii = 1:3
    scatter( gamryStructure_CV(2).potential{ii}, ...
             gamryStructure_CV(2).current{ii}, [], '.')
    hold on
end
% %% CV before and after (E09 and E08)
% % Showing scan 3 of 3 for each plot. 
% figure
% 
% pointerArray_E09 = [6 7 8 9 10];
% pointerArray_E08 = [1 2 3 4 5];
% numScans = length(pointerArray_E08);
% colorArray = lines(numScans);
% %E09
% for ii = 1:numScans
% jj = pointerArray_E09(ii);
% % E09
% scatter( gamryStructure(jj).potential{3}, ...
%          gamryStructure(jj).current{3}, [], colorArray( ii, : ), '.')
%      hold on
% end
% legend('Pre', '200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% xlabel('Potential (V)')
% ylabel('Current (A)')
% title('Estim')
% xlim([-0.8 1])
% 
% %E08
% figure
% for ii = 1:numScans
% kk = pointerArray_E08(ii);
% % E08
% scatter( gamryStructure(kk).potential{3}, ...
%          gamryStructure(kk).current{3}, [], colorArray( ii, : ), '.')
%      hold on
% end
% legend('Pre', '200mV/mm', '5mV/mm', '50mV/mm', '500mV/mm')
% xlabel('Potential (V)')
% ylabel('Current (A)')
% title('EControl')
% xlim([-0.8 1])

