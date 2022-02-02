%% model_VoltageDist_EChemVEM
% Attempting to approximate voltage distributions using both an echem model
% of the diffuse layer and a simple monopole voltage distribution
% relationship. 

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

%%
z = 1;
n0 = 126e-3;              % Bulk concentration of ion (moles/Liter)
e_charge = 1.6022e-19;    % Charge on an electron (Coulombs)
phi = [];                 % voltage at position x (V)
phi_trode = 1;            % Electrode voltage (V)
K = 1.3806e-23;           % Boltzmann constant (m2*kg/s^2*K)
T = 298;                  % Temperature (K)
epsilon =  300;           % dielectric constant of solution (guessing)            
epsilon_0 = 8.85419e-12;  % permitivity of free space

x = 1e-5;
x = logspace(-9,-3);
kappa = sqrt( ( 2*(n0)*(z^2)*(e_charge^2) ) / ...
            ( epsilon * epsilon_0 * K * T ) );
kappa_2 = (3.29e7)*z*sqrt(n0);

kappa_inv = 1/kappa;
kappa_inv_2 = 1/kappa_2;

phi = atanh( exp(-kappa_2.*x) .* tanh(z.*e_charge.*phi_trode./4.*K.*T )).*4.*K.*T ./ ...
      ( z * e_charge );
  
phi_2 = phi_trode.*exp(-kappa_2.*x);

EF_ECHEM = diff(phi_2)./diff(x);   % Derivative to approx EF strength

plot(x, phi_2)
hold on

% For whatever reason, can't get the general forms of kappa and phi to
% calculate correctly, so using kappa_2 and phi_2 which are special cases
% from B and F (page 548). 


%% Point charge
k = 1/(4*pi*epsilon_0);
V_trode = 1;
Q = x(1)*V_trode/k;
r = x;

V = k.*Q./r;
EF_EM = diff(V)./diff(r);

% Attemping based off current and resistivity
sigma = 2.3;    % S/m
I = 4*pi*sigma*r(1);
V2 = (1/(sigma*4*pi)).*(I./r);

plot(r, V)
plot(r, V2)
xlim([1e-9 2e-8])
title('Voltage Distribution')
legend('Echem', 'EM', 'EM2')

figure
semilogx(x(2:end), -1*EF_ECHEM)
hold on
semilogx(x(2:end), -1*EF_EM)
title('Electric Fields')
legend('Echem', 'EM')

% Intersting.... The electromagnetics predicts faster decay
% Maybe even more intersting that there is such little difference between
% the decay from a point source in vacuum and from a point source in
% electrolyte. 