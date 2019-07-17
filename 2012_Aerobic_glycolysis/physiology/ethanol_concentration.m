%% Ethanol concentartion:
%
% 500 \mu l -- solution 2
% 10  \mu l -- sample ( 10 x diluted, 100 \mu l + 900 \mu l )
%  5  \mu l -- suspension 3 
% 990 \mu l -- water
Eth = [150 139  82  61 32/2 30/2 ...
       244 159 139 128 28/2 25/2 ];
b = 1.505 * 1e3 / ( 6.3 * 1e-2 * 2* 1e3 );  %46.07 
c = b * 10 * Eth*1e-3;   

fprintf( '%1.2f mM\n', c )
fprintf( '\n' );


%% Plots Ethanol Concentartion 

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
h(2) = ylabel( '[Ethanol], mM' );   
hh = legend(   'His Limitation',...
               'Lys Limitation',...
               'Location', 'NorthEast'  );
sett( hh, 26 );           
          
sett(h, 24);   
%%
set( hh, 'box', 'off' ); 
panels( 'B', 38 );
%%
pdf( 'Ethanol_Concentartion', [8.5 5], 1 );
%png( 'Ethanol_Concentartion', [9 5], 1 );

    











%% Ethanol concentartion in the Victor's samples:
%
% 500 \mu l -- solution 2
% 10  \mu l -- sample ( 10 x diluted, 100 \mu l + 900 \mu l )
%  5  \mu l -- suspension 3 
% 990 \mu l -- water
Eth = [299      200 135 103 ...  % Leu limited chemostats (1, ,3,4,5)
       339  238 199 134  75  ];  % Ura limited chemostats (1,2,3,4,5)
b = 1.505 * 1e3 / ( 6.3 * 1e-2 * 2* 1e3 );  %46.07 
c = b * 10 * Eth*1e-3;   

fprintf( '%1.2f mM\n', c )
fprintf( '\n' );


%% Plots Ethanol Concentartion 

Marker = { 'linewidth', 3, 'MarkerSize', 10, 'MarkerFaceColor' };


gr1 = [0.05, 	   0.16, 0.22, 0.30];
gr2 = [0.05, 0.11, 0.16, 0.22, 0.30];

set( gcf, 'Position', [217   337   822   464] )
set( gca, 'Position', [0.11  0.13 0.85 0.85] )

plot( gr1, c(1:4), 'ko-', Marker{:}, 'k' ); hold on 
plot( gr2, c(5:9), 'ro-', Marker{:}, 'r' );


xlim( [0.04 .31] );
set( gca, 'Xtick', gr2,  'XtickLabel', gr2 );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( '[Ethanol], mM' );   
hh = legend(   'Leu Limitation',...
               'Ura Limitation',...
               'Location', 'NorthEast'  );
sett( hh, 26 );                     
sett(h, 24);   
%%
set( hh, 'box', 'off' ); 
panels( 'C', 38 );
%%
pdf( 'Ethanol_Concentartion_Leu_Ura', [8.5 5], 1 );

