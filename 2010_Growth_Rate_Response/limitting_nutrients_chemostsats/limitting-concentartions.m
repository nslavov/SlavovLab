%% Final biomass as a finction of the ethanol concentartion

concent = 10 * (1:6); % in mM [Ethanol]
biomass = [500	990	1510	2020	2500	2960];

%plot( concent, biomass, 'ko' )
[a b] = linFit(  concent(:), biomass(:) );

xlim([ 5 65] );
ylim([ 400 3500] );
clear h
h(1) = ylabel( 'Final Biomass, ODE 600nm' );
h(2) = xlabel( 'Ethanol Concentartion, mM' );
sett(h)
set( gca, 'Position', [0.15 0.11 0.80 0.82] );
set( gcf, 'PaperSize', [7 5], 'paperPositionMode', 'auto' );

%%
print -dpdf Ethanol_Limitation
open Ethanol_Limitation.pdf 
%% Nitrogen Limitation 

concent = 50 * (1:5); % in mg/L [ (NH4)2SO4 ]
biomass = [645	1170	1670	2160	2600];

[a b] = linFit(  concent(:), biomass(:) );

xlim([ 40 260] );
ylim([ 550 3000] );


clear h
h(1) = ylabel( 'Final Biomass, ODE 600nm' );
h(2) = xlabel( '$[(NH_4)_2SO_4]$, mg/L' );
sett(h)
set( gca, 'Position', [0.15 0.11 0.80 0.82] );
set( gcf, 'PaperSize', [7 5], 'paperPositionMode', 'auto' );
concentration.N = 2 * concent / 132; % [N] uM
%%
pdf Nitrogen_Limitation



%% Phosphate Limitation 

concent = 10 * (1:5); % in mg/L [ KH_2PO_4 ]
biomass = [635	1160	1600	1980	2420];

[a b] = linFit(  concent(:), biomass(:) );

xlim([   5   55] );
ylim([ 550 3000] );


clear h
h(1) = ylabel( 'Final Biomass, ODE 600nm' );
h(2) = xlabel( '$[KH_2PO_4]$, mg/L' );
sett(h)
set( gca, 'Position', [0.15 0.11 0.80 0.82] );
set( gcf, 'PaperSize', [7 5], 'paperPositionMode', 'auto' );
concentration.P = concent / 136;
%%
pdf Phosphate_Limitation






