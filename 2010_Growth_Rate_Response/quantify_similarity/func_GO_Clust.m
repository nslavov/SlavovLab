%%
% Each GO terms is represented by a row
% Columns corresponds to limitation conditions
% Colorcoded based on Slopes 
% The matrix is clustered 
%%
load C:\Users\nslavov\Code\matlab\his_lys_grr\brauer_eth_his_lys.mat
load C:\Users\nslavov\data\SGD\go_slim_mapping
%%
funSlopes = zeros( 91, 7 );

for k=1:91
    ind = strmatch( go.Terms(k),  go.term );
    ind = go.inds.hisLys_eth_br(ind);
    ind = ind( ind>0 );
    
    for j=1:3
        
       funSlopes(k,j)   = mean( s.brauer(ind,j) ); 
       funSlopes(k,j+4) = mean( s.ethan(ind,j) );
       
       %funSlopes(k,j)   = median( s.brauer(ind,j) ); 
       %funSlopes(k,j+4) = median( s.ethan(ind,j) );       
    end
     
end

CLU = clu( funSlopes, 3 ); rg(6);
%%
%hh = colorbar;
%set( hh, 'Location', 'WestOutside' )
%set( hh, 'Location', 'NorthOutside' );

set(gca, 'Ytick', [] );
set(gca, 'Xtick', [1:3 5:7] );
set(gca, 'XtickLabel', {'Glu', 'N', 'P', 'Eth', 'N', 'P'}  );
set(gca, 'FontSize', 22, 'FontWeight', 'Bold' );

h(1) = xlabel( 'Conditions' );
h(2) = ylabel( 'Functional Groups \& GO Terms' );
sett(h, 24);

gtext( { 'Glucose'; 'Ethanol' }, 'interpreter',   'latex', 'FontSize', 24 ); 
%%
set( gcf, 'Position', [ 232         79          780         745] )
set( gca, 'Position', [0.1         0.11        0.78        0.8] )

File_Name = { 'funSlopes_Glu_Eth_mean', 'funSlopes_Glu_Eth_median' };
pdf( File_Name{1}, [9 8.5] );

%% Writes a PCL File 

File_Name_pcl = 'funSlopes_Glu_Eth_mean.pcl';
%File_Name_pcl = 'funSlopes_Glu_Eth_median.pcl';
Fid = fopen(  File_Name_pcl, 'w'  ); 


fprintf(Fid, 'YORF\tNAME\tGWEIGHT\tGLU::Glucose\tGLU::Nitrogen\tGLU::Phosphate\t \t' );
fprintf(Fid,                      'ETH::Ethanol\tETH::Nitrogen\tETH::Phosphate\n' );
fprintf(Fid, 'EWEIGHT\t \t\t1\t1\t1\t1\t1\t1\t1\n' );
for i=1:91  
   ii = CLU(i);
   fprintf(Fid, '%s\t%s\t%d', go.Terms{ii}, go.Descriptions{ii},  1 );
   fprintf(Fid, '\t%1.2f',    funSlopes(ii,:) );
   fprintf(Fid, '\n' ); 
        
end
fclose( Fid );











%%





