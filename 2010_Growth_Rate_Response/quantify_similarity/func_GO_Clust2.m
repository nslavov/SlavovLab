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
funSlopes = zeros( 91,  3+1+3  +1+3); %  +1+3
p_vals = zeros( size( funSlopes) );

for k=1:91
    ind = strmatch( go.Terms(k),  go.term );
    ind = go.inds.commonRef_eth_br(ind);
    ind = ind( ind>0 );
    
    for j=1:3
        
        %Fold_Change = sum(  ( cm.dat(ind,  (1:3)+3*(j-1)  ) - ...
        %                                    cm.dat(ind,  (1:3)+6*(j-1)+9  )  ), 2  );
        
             
       funSlopes(k,j)   = mean( cm.sl(ind,j) ); 
       funSlopes(k,j+4) = mean( cm.sl(ind,j+3) );
       
       funSlopes(k,j+8) = mean(  cm.foldChange( ind, j )  );
       
       if 1
           p_vals(k,j) = ranksum(  cm.sl(ind,j),  cm.sl( : ,j) );
           p_vals(k,j+4) = ranksum(  cm.sl(ind,j+3),  cm.sl( : ,j+3) );
           
           p_vals(k,j+8) = ranksum(  cm.foldChange( ind, j ),  cm.foldChange( :, j )  ); 
       end
             
    end
     
end
%%
CLU = clu( funSlopes .* (p_vals<1e-3), 2 ); rg(4);  colormap( redbluecmap );
%%  Only Groups of Stat Significant Changes 
funSlopesS = funSlopes .* (p_vals<1e-3);
indS = find( sum(abs(funSlopesS),2)>0 ); 
funSlopesS = funSlopesS( indS, : );
CLU = clu( funSlopesS, 3 ); rg(4);  colormap( redbluecmap )
%%
%hh = colorbar;
%set( hh, 'Location', 'WestOutside' )
%set( hh, 'Location', 'NorthOutside' );

set(gca, 'Ytick', [] );
set(gca, 'Xtick', [1:3 5:7 9:11] );
set(gca, 'XtickLabel', {'Eth', 'N', 'P', 'Glu', 'N', 'P',  'E/G', 'N', 'P'}  );
set(gca, 'FontSize', 24, 'FontWeight', 'Bold' );

h(1) = xlabel( 'Conditions' );
h(2) = ylabel( 'Functional Groups \& GO Terms' );
sett(h, 34);
set( gcf, 'Position', [ 232         50          780         770] )
set( gca, 'Position', [0.1         0.11        0.78        0.8] )

hh = gtext( { 'Slopes in Ethanol'; 'Slopes in Glu'; 'Mean Fold Change' } );
set( hh,  'FontSize',               14 ,...
              'FontWeight',        'Bold' ,...
              'Color',                  [1 0.2 0.2]      ); 
%%

File_Name = { 'funSlopesFldChng_Glu_Eth_mean', 'funSlopes_Glu_Eth_median' };
pdf( File_Name{1},   [9 9], 1 );

%% Writes a PCL File 

File_Name_pcl = [ File_Name{1}  '.pcl' ];
%File_Name_pcl = 'funSlopes_Glu_Eth_median.pcl';
Fid = fopen(  File_Name_pcl, 'w'  ); 


fprintf(Fid, 'YORF\tNAME\tGWEIGHT\tSlope::ETH::Ethanol\tSlope::ETH::Nitrogen\tSlope::ETH::Phosphate\t  \t'   );
fprintf(Fid,                      'Slope::GLU::Glucose\tSlope::GLU::Nitrogen\tSlope::GLU::Phosphate\t \t'  );
fprintf(Fid,                      'FoldChange::Ethanol\tFoldChange::Nitrogen\tFoldChange::Phosphate\n' );
fprintf(Fid, 'EWEIGHT\t \t\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n' );
for i=1:numel(CLU)  
   ii = CLU(i);
   iii = indS(ii); 
   GO = regexprep( go.Terms{iii}, ':', '_' ); 
   fprintf(Fid, '%s\t%s\t%d', GO, go.Descriptions{iii},  1 );
   fprintf(Fid, '\t%1.2f',    funSlopesS(ii,:) );
   fprintf(Fid, '\n' ); 
        
end
fclose( Fid );
%system( [ 'start '  File_Name_pcl ] );
%%
File_Name_pcl = 'All_Eth_Glu_GRR_Clustered.pcl';

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
File_Name = { 'slopesFldChng_Glu_Eth'  };
File_Name_pcl = [ File_Name{1}  '.pcl' ];
%File_Name_pcl = 'funSlopes_Glu_Eth_median.pcl';
Fid = fopen(  File_Name_pcl, 'w'  ); 


fprintf(Fid, 'YORF\tNAME\tGWEIGHT\tSlope::ETH::Ethanol\tSlope::ETH::Nitrogen\tSlope::ETH::Phosphate\t  \t'   );
fprintf(Fid,                      'Slope::GLU::Glucose\tSlope::GLU::Nitrogen\tSlope::GLU::Phosphate\t \t'  );
fprintf(Fid,                      'FoldChange::Ethanol\tFoldChange::Nitrogen\tFoldChange::Phosphate\n' );
fprintf(Fid, 'EWEIGHT\t \t\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n' );

fldChng = zeros( size( cm.sl, 1 ) ,3);

for i=1:size( cm.sl, 1 )  
    
   for j=1:3 
       fldChng(i,j) =  sum(  ( cm.dat(i,  (1:3)+3*(j-1)  ) - ...
                                         cm.dat(i,  (1:3)+6*(j-1)+9  )  )  );
   end
    
    

   fprintf(Fid, '%s\t%s\t%d', cm.annot{i,2}, cm.annot{i,1}  ,  1 );
   fprintf(Fid, '\t%1.2f',    [cm.sl(i, 1:3 ), 0 cm.sl(i, 5:7 )  0  fldChng(i,:) ] );
   fprintf(Fid, '\n' ); 
        
end
fclose( Fid );
system( [ 'start '  File_Name_pcl ] );







































%%





