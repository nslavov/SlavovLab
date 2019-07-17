%% Glucose concentartion:
%
% 500 \mu l -- solution 1
% 10  \mu l -- sample ( 10 x diluted, 100 \mu l + 900 \mu l )
% 10  \mu l -- suspension 2 
% 990 \mu l -- water
Glu = [399 414 442 441 462 477 ...
       371 425 430 437 468 483 ];
b = 1.510 * 1e3 / ( 6.8 * 1e-2 * 1e3 );  % 6.3 180 
c = b * 10 * Glu*1e-3;   

fprintf( '%1.2f mM\n', c )
fprintf( '\n' );


%% Plots Glucose Concentartion 

Marker = { 'linewidth', 3, 'MarkerSize', 10, 'MarkerFaceColor' };

gr = 0.05 : 0.05 : 0.3;

set( gcf, 'Position', [217   337   822   464] )
set( gca, 'Position', [0.11  0.13 0.85 0.85] )

plot( gr, c(1:6), 'ko-', Marker{:}, 'k' ); hold on 
plot( gr, c(7:12), 'ro-', Marker{:}, 'r' );


xlim( [0.04 .31] );
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'FontWeight', 'Bold', 'FontSize', 16 );

h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( 'Residual [Glucose], mM' );   % 
hh = legend(   'His Limitation',...
               'Lys Limitation',...
               'Location', 'NorthWest'  );
sett( hh, 26 );                     
sett(h, 24);           
%set(h, 'fontsize', 16, 'FontWeight', 'bold');
%%
set( hh, 'box', 'off' ); 
panels( 'A', 38 );
%%
pdf( 'Glucose_Concentartion', [8.5 5], 1 );


















