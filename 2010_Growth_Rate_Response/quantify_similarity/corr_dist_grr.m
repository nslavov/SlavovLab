%%
% Load Data
load ../slavov_brauer_slopes_Rsq.mat
%%
Corrs.pear = zeros( size( data, 1 ), 3 );
Corrs.spear = zeros( size( data, 1 ), 3 );
Corrs.all = zeros( size( data, 1 ), 1 );
IND = [10:12 16:18 22:24];

for i=1:size( data, 1 )

       Corrs.pear(i,1) = pearv( data(i,1:3), data(i,10:12) ); 
       Corrs.pear(i,2) = pearv( data(i,4:6), data(i,16:18) ); 
       Corrs.pear(i,3) = pearv( data(i,7:9), data(i,22:24) );
       
       Corrs.spear(i,1) = pearv( tiedrank(data(i,1:3)), tiedrank(data(i,10:12)) ); 
       Corrs.spear(i,2) = pearv( tiedrank(data(i,4:6)), tiedrank(data(i,16:18)) ); 
       Corrs.spear(i,3) = pearv( tiedrank(data(i,7:9)), tiedrank(data(i,22:24)) );
       
       Corrs.all(i,1) = pearv( data(i,1:9), data(i,IND) );
end
%%
Corrs.pear( isnan(Corrs.pear) ) = 0;
Corrs.annot = Common_Annot;
save( 'Corrs',  'Corrs', 'Corrs_rnd' );
%%
cd C:\Users\nslavov\Code\matlab\gr-rate\quantify_similarity_in_GRR\
load Corrs
%%
l = -1 : 0.05 : 1;
%fr = histc( [sum(Corrs.pear,2) sum(Corrs_rnd.pear,2)], l );
fr = histc( [Corrs.all  Corrs_rnd.all], l );

figure
plot( l, fr, 'linewidth', 3 ); 

set( gca, 'FontSize', 14, 'FontWeight', 'Bold' );

h(1) = xlabel( 'Correlations' );
h(2) = ylabel( 'Number of Genes' );
h(3) = title( 'GRR in Ethanol vs. GRR in Glucose' );
h(4) = legend( 'Carbon Source', 'Nitrogen', 'Phosphate' );
sett(h, 22); 

set(h(4), 'Location',    'North' );
set(h(4), 'box',         'off' );
%set(h(4), 'Orientation', 'Horizontal' ); 

%
set(gcf, 'position', [440   337   726   461] );
set(gca, 'position', [0.13  0.11  0.81  0.82] );
%%
File_Name = 'Corr_Dist';
pdf( File_Name, [8 5] );
system( ['start '  File_Name '.pdf' ] );
%%
pos = sum( Corrs.pear > 0.8 )
neg = sum( Corrs.pear < -0.8 )

%%
pear( Corrs.pear )
%%
pp( Corrs.pear(:,1), Corrs.pear(:,3), '.' )


