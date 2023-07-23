%% Ethanol concentartion:
%
% 500 \mu l -- solution 2
% 10  \mu l -- sample ( 10 x diluted, 100 \mu l + 900 \mu l )
%  5  \mu l -- suspension 3 
% 990 \mu l -- water
Eth = [112 151 195 ...
       533 637 724 ...
       477 666 675 ];
b = 1.505 * 1e3 / ( 6.3 * 1e-2 * 2* 1e3 );  %46.07 
c = b * 10 * Eth*1e-3;   

fprintf( '%1.2f mM\n', c )
fprintf( '\n' );


%% Plot Residual Ethanol Concentartion 

Marker = { 'linewidth', 3, 'MarkerSize', 10, 'MarkerFaceColor' };

gr = [ 0.05 0.1 0.14 ];

plot( gr, c(1:3), 'ko-', Marker{:}, 'k' ); hold on 
plot( gr, c(4:6), 'ro-', Marker{:}, 'r' );
plot( gr, c(7:9), 'go-', Marker{:}, 'g' );

xlim( [0.04 .15] );
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( 'Residual [Ethanol], mM' );   
hh = legend( 'Ethanol Limitation',...
               'Nitrogen Limitation',...
               'Phosphate Limitation',...
               'Location', 'East'  );
sett( hh, 16 );           
set( hh, 'box', 'off' );           
sett(h, 20);           
%set(h, 'fontsize', 16, 'FontWeight', 'bold');
%%
pdf( 'Residual_Ethanol_Concentartion', [9 5], 1 );
png( 'Residual_Ethanol_Concentartion', [9 5], 1 );

















