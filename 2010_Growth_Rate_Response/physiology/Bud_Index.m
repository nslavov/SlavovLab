%% Plot Number of Cells per mL
dat=[
86  131 77  93  139 101 140 113 150 
13   34 31  17  36   47  23  33  57 ];

c = dat(2,:) ./ sum( dat );
error_barr = c .* dat(1,:).^-0.5;
%%
Marker = { 'linewidth', 4, 'MarkerSize', 6, 'MarkerFaceColor' };

gr = [ 0.05 0.1 0.14 ];
%fig
errorbar( gr, c(1:3), error_barr(1:3), 'ko-', Marker{:}, 'k' ); hold on 
errorbar( gr, c(4:6), error_barr(4:6), 'ro-', Marker{:}, 'r' );
errorbar( gr, c(7:9), error_barr(7:9), 'go-', Marker{:}, 'g' );

xlim( [0.04 .15] );
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( 'Fraction of Budded Cells' );   
hh = legend( 'Ethanol Limitation',...
               'Nitrogen Limitation',...
               'Phosphate Limitation',...
               'Location', 'North'  );
sett( hh, 16 );           
set( hh, 'box', 'off' );           
sett(h, 20);           
%set(h, 'fontsize', 20, 'FontWeight', 'bold');
%%
pdf( 'Bud_Index', [9 5] );
png( 'Bud_Index', [9 5] );