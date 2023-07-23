%%
% Get the Cell Cycle Genes from the Brower Data

brauwer_cell_cycle = ...
textread( '/gen/corrC/cell_division/28843_dump', '%s' ); 
%textread( '/gen/corrC/cell_division-1/29618_cell_cicle', '%s' );

% Get the indecies corresponding to the genes in my data

%Annot = annot( non_NaN_inds, : );

num = length( brauwer_cell_cycle );
Inds.cell_cycle = zeros( num, 1 );
    k=1;
for i=1:num
    
   in = strmatch( brauwer_cell_cycle(i) , Common_Annot(:,2), 'exact' );
   
   if ~isempty(in) && in > 0
     Inds.cell_cycle(k) = in; k=k+1;
   end
          
end, k=k-1;
Inds.cell_cycle = Inds.cell_cycle(1:k);
%%
%hist( s_ex( Inds.cell_cycle, : )  )
[vals inds] = sort( s_ex( Inds.cell_cycle, 1:3 ) );

Marker = { 'MarkerSize', 8, 'MarkerFaceColor' };

plot( vals(:,1), 'ko', Marker{:}, 'k' ); hold on
plot( vals(:,2), 'ro', Marker{:}, 'r' );
plot( vals(:,3), 'go', Marker{:}, 'g' );
%plot( vals, 'o', 'MarkerSize', 7 ); hold on

plot( [1 k], [0 0], 'k', 'linewidth', 2 );
ylim( [-55 20] );
h(1) = xlabel( 'Rank Order' );    
h(2) = ylabel( 'Slopes in Ethanol Carbon Source' );   
h(3) = legend( 'Ethanol Limitation',...
               'Nitrogen Limitation',...
               'Phosphate Limitation', 4 );              
set(h, 'fontsize', 16, 'FontWeight', 'bold');                                


set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 450 450] );
set( gcf, 'color',      [1 1 1]          );
set( gcf, 'position',   [365 85 621 610] )
set( gcf, 'PaperSize',  8*[1 1], 'PaperPositionMode', 'auto' );

%%
File_Name = 'Cell_Division';
sgd1 = 'http://db.yeastgenome.org/cgi-bin/search/quickSearch.pl?query=';
sgd2 = '&submit=Search';

%File_Name = 'Scatter_map_ESR';  %YMC_All  _Nielson'; 

delete(  [ File_Name '.html' ] )
delete(  [ File_Name '.png'  ] )
clear ud

for I=1:3
    for i = 1:k
        in = Inds.cell_cycle( inds(i,I) );
        ud.url = sprintf( '%s%s%s', sgd1, Annot{in,1}, sgd2 ) ;
        ud.description =...
          sprintf('header=[%s] body=[%s%2.2f <br> %s%2.2f <br> %s%2.2f]',...
          Annot{in,1},...
          'Ethanol: ', s_ex(in,1),...
          'Nitrogen: ', s_ex(in,2),... 
          'Phosphate: ', s_ex(in,3)   ); 

        text( i, vals(i,I),'',   'tag','click',    'UserData', ud )
    end
end
    makemap(gcf, File_Name);
    web( [ File_Name '.html' ] ,'-browser')








%% PLot the Distributions of Slopes
eth_sl = sl( Inds.cell_cycle, 1:3 ); 
pro_sl = sl( Inds.cell_cycle, 4:7 );
aux_sl = sl( Inds.cell_cycle, 8:9 );

l = -15: 1 : 10;

freq.eth = histc( eth_sl(:), l ) * (1/numel(eth_sl));
freq.pro = histc( pro_sl(:), l ) * (1/numel(pro_sl));
freq.aux = histc( aux_sl(:), l ) * (1/numel(aux_sl));

Marker = { 'MarkerSize', 8, 'MarkerFaceColor' };
Line = { 'LineWidth', 3.5 };
pp( l, freq.eth, 'ko-', Marker{:}, 'k', Line{:} ), hold on 
plot( l, freq.pro, 'rs-', Marker{:}, 'r', Line{:} )
plot( l, freq.aux, 'gs-', Marker{:}, 'g', Line{:} )
plot( [0 0], [0 .15], '-.k',  Line{:} )

set(gca, 'FontSize', 12, 'FontWeight', 'Bold' );
h(1) = xlabel( 'Slopes' );
h(2) = ylabel( 'Density' );
h(3) = legend( 'Ethanol Prototrophs',...
               'Glucose Prototrophs',...
               'Glucose Auxotrophs', 2 );
set( h(3), 'box', 'off' );
set( h, 'FontSize', 20, 'Fontweight', 'Bold' );
%%
pdf( 'Slopes', [10 6] );
%%
png( 'Slopes', [10 6] );


%%
CLU = clu( data(Inds.cell_cycle, 1:9), 2 ); rg(3.5)
%%
CLU = clu( data(Inds.cell_cycle, 10:45), 3 ); rg(3)
%% PLot the Distributions of Fold Changes 
eth_dat = data(Inds.cell_cycle, 1:9);
glu_pro = data(Inds.cell_cycle, 16:33); %10:45
glu_aux = data(Inds.cell_cycle, 34:45);

l =  -1.5: .1 : 1.5;

freq.eth = histc( eth_dat(:), l ) * (1/numel(eth_dat));
freq.pro = histc( glu_pro(:), l ) * (1/numel(glu_pro));
freq.aux = histc( glu_aux(:), l ) * (1/numel(glu_aux));
%%

Marker = { 'MarkerSize', 8, 'MarkerFaceColor' };
Line = { 'LineWidth', 3.5 };
pp( l, freq.eth, 'ko-', Marker{:}, 'k', Line{:} ), hold on 
plot( l, freq.pro, 'rs-', Marker{:}, 'r', Line{:} )
plot( l, freq.aux, 'gs-', Marker{:}, 'g', Line{:} )
plot( [0 0], [0 .15], '-.k',  Line{:} )


set(gca, 'FontSize', 12, 'FontWeight', 'Bold' );
h(1) = xlabel( 'Fold Change' );
h(2) = ylabel( 'Density' );
h(3) = legend( 'Ethanol Prototrophs',...
               'Glucose Prototrophs',...
               'Glucose Auxotrophs', 2 );
set( h(3), 'box', 'off' );
set( h, 'FontSize', 20, 'Fontweight', 'Bold' );
%%
pdf( 'Fold_Change', [10 6] );
%%
png( 'Fold_Change', [10 6] );














