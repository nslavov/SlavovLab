%%
% Each GO terms is represented by a row
% Columns corresponds to limitation conditions
% Colorcoded based on Slopes 
% The matrix is clustered 
%%
cd C:\Users\nslavov\Code\matlab\gr-rate\Quantify_similarity_in_GRR\
load C:\Users\nslavov\Code\matlab\gr-rate\slavov_brauer_dat_commonRef.mat
load C:\Users\nslavov\data\SGD\go_slim_mapping
%%
funSlopes = zeros( 91,  3+1+3  ); %  +1+3

for k=1:91
    ind = strmatch( go.Terms(k),  go.term );
    ind = go.inds.commonRef_eth_br(ind);
    ind = ind( ind>0 );
    
    for j=1:3
        
       eth = cm.dat(ind,  (1:3)+3*(j-1)  );
       glu = cm.dat(ind,  (1:3)+6*(j-1)+9  );
        
       r = pear2c( eth',  glu' );
       funSlopes(k,j)   = mean( r ); 
       
       funSlopes(k,j+4) = mean(  sum(  eth - glu,  2  ) );
       
     
    end
     
end
%%
CLU = clu( funSlopes, 3 ); rg(1);  colormap( redbluecmap )
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
set( gcf, 'Position', [ 232         79          780         745] )
set( gca, 'Position', [0.1         0.11        0.78        0.8] )

gtext( { 'Mean Correlation'; 'Mean Fold Change' }, 'interpreter',   'latex', 'FontSize', 20 ); 
%%

File_Name = { 'funCorr_FldChng_Glu_Eth_mean', 'funSlopes_Glu_Eth_mean', 'funSlopes_Glu_Eth_median' };
pdf( File_Name{1}, [9 8.5], 1 );

%% Writes a PCL File 

File_Name_pcl = [ File_Name{1} '.pcl' ];
%File_Name_pcl = 'funSlopes_Glu_Eth_median.pcl';
Fid = fopen(  File_Name_pcl, 'w'  ); 


fprintf(Fid, 'YORF\tNAME\tGWEIGHT\tGLU::Glucose\tGLU::Nitrogen\tGLU::Phosphate\t \t' );
fprintf(Fid,                      'ETH::Ethanol\tETH::Nitrogen\tETH::Phosphate\t  \t' );
fprintf(Fid,                      'DIFF::Ethanol\tDIFF::Nitrogen\tDIFF::Phosphate\n' );
fprintf(Fid, 'EWEIGHT\t \t\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n' );
for i=1:91  
   ii = CLU(i);
   GO = regexprep( go.Terms{ii}, ':', '_' ); 
   fprintf(Fid, '%s\t%s\t%d', GO, go.Descriptions{ii},  1 );
   fprintf(Fid, '\t%1.2f',    funSlopes(ii,:) );
   fprintf(Fid, '\n' ); 
        
end
fclose( Fid );
%%
File_Name_pcl = 'All_Eth_Glu_GRR.pcl';

Fid = fopen(  File_Name_pcl, 'w'  ); 


fprintf(Fid, 'YORF\tNAME\tGWEIGHT' );
fprintf(Fid,             '\tETH::Ethanol:%1.2f',  [0.05 0.10, 0.14] );
fprintf(Fid,             '\tETH::Nitrogen:%1.2f',  [0.05 0.10, 0.14] );
fprintf(Fid,             '\tETH::Phosphate:%1.2f',  [0.05 0.10, 0.14] );

fprintf(Fid,             '\tGLU::Glucose:%1.2f',          0.05 :0.05 : 0.3 );
fprintf(Fid,             '\tGLU::Nitrogen:%1.2f',        0.05 :0.05 : 0.3 );
fprintf(Fid,             '\tGLU::Phosphate:%1.2f',     0.05 :0.05 : 0.3 );
fprintf(Fid,             '\tGLU::Sulfur:%1.2f',     0.05 :0.05 : 0.3 );
fprintf(Fid,             '\tGLU::Leusine:%1.2f',          0.05 :0.05 : 0.3 );
fprintf(Fid,             '\tGLU::Uracile:%1.2f',        0.05 :0.05 : 0.3 );
fprintf(Fid, '\n' );

fprintf(Fid, 'EWEIGHT\t \t' );
fprintf(Fid, '\t%d',  ones(1, 45) );
fprintf(Fid, '\n' );

for i=1:size(cm.dat,1)  


   fprintf(Fid, '%s\t%s\t%d', cm.annot{i,2}, cm.annot{i,1},  1 );
   fprintf(Fid, '\t%1.2f',   cm.dat(i,:) );
   fprintf(Fid, '\n' ); 
        
end
fclose( Fid );
system( [ 'start '  File_Name_pcl ] );






































%%





