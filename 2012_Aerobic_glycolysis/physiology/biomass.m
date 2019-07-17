%% Plot Number of Cells per mL
cell_count=[
15264        10289       9100.5       7777.9        957.62       796.8
18322        21256       10219        3155.3        966.2        948.55]*1e3;

Marker = { 'linewidth', 4, 'MarkerSize', 12, 'MarkerFaceColor' };

gr = 0.05 : 0.05 : 0.3;

cell_count = cell_count * 1e-6;

set( gcf, 'Position', [217   337   822   464] )
set( gca, 'Position', [0.11  0.13 0.85 0.85] )
plot( gr, cell_count(1,:), 'ks-.', Marker{:}, 'k' ); hold on 
plot( gr, cell_count(2,:), 'rs-.', Marker{:}, 'r' );

xlim( [0.04 .31] );
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

clear h
h(1) = xlabel( 'Growth Rate, $h^{-1}$' ); % , '   
h(2) = ylabel( 'Cells per $n L$' );   
hh = legend( 'His Limitation',...
             'Lys Limitation',...
             'Location', 'NorthEast'  );
sett( hh, 26 );                     
sett(h, 24);   
%%
set( hh, 'box', 'off' ); 
panels( 'D', 38 );
%%
pdf( 'C:\Users\nslavov\Documents\auxo\figs\Number_of_Cells', [8.5 5], 1 );
%png( 'Number_of_Cells', [8 5], 1 );





%% Plot Number of Biomass
biomass=[
4.9629e+06   8.9226e+06   1.5325e+07   1.9399e+07   1.3819e+06   1.2348e+06    
7.6422e+06   2.1365e+07   2.6708e+07   7.1675e+06   1.9784e+06   1.9257e+06];

dil = 1e3 ./ [2 5 10 10 10 10]; % Dilution factor for each Growth Rate
biomass(1,:) = biomass(1,:) .* dil  * (1e-15*1e6);
biomass(2,:) = biomass(2,:) .* dil  * (1e-15*1e6);
%%
Marker = { 'linewidth', 4, 'MarkerSize', 8, 'MarkerFaceColor' };

gr = 0.05 : 0.05 : 0.3;
%fig
plot( gr, biomass(1,:), 'ko-', Marker{:}, 'k' ); hold on 
plot( gr, biomass(2,:), 'rs-.', Marker{:}, 'r' );

xlim( [0.04 .31] );
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

clear h
h(1) = xlabel( 'Growth Rate, h^{-1}' ); % , '   
h(2) = ylabel( 'cellular volume,  \muL/mL' );   
hh = legend( 'Histidine Limitation',...
             'Lysine Limitation',...
             'Location', 'NorthEast'  );
%sett( hh, 16 );
set(hh, 'fontsize', 20, 'FontWeight', 'bold');
set( hh, 'box', 'off' );           
%sett(h, 20);           
set(h, 'fontsize', 20, 'FontWeight', 'bold');
%%
pdf( 'Number_of_Cells', [8 5], 1 );















