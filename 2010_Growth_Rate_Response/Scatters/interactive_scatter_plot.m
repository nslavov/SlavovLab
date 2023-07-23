%%
cd C:\Users\nslavov\Code\matlab\gr-rate\grr_html\Scatters\
DIR = 'GO_Terms'; 
%mkdir( 'DIR' );
%warning off
%%
% cd ../../Code/matlab/gr-rate/grr_html/Scatters/
%load /mlab/gr-rate/grr_html/Scatters/GO_Terms/TFs.mat
load ../../slavov_brauer_slopes_Rsq.mat
load GO_Terms/TFs.mat
%%
Limit = { 'Ethanol', 'Nitrogen', 'Phosphate',...
          'Glucose', 'Nitrogen', 'Phosphate',...
          'Sulpher', 'Leu',       'Ura'         }; 

for I=1:3 %9
    for J=(I+1):9

%I=4;
%J=1;
GO_Dir = sprintf( '%s/go_%d_%d', DIR, I, J ); 
%mkdir( GO_Dir );   
if I>3, CS_I = 'Glucose'; 
        Thresh_I = 0.8; 
else    CS_I = 'Ethanol';
        Thresh_I = 0.9;
end
if J>3, CS_J = 'Glucose'; 
        Thresh_J = 0.8; 
else    CS_J = 'Ethanol';
        Thresh_J = 0.9;
end

File_Name = sprintf( 'lims_%d_%d', I, J );
Title = sprintf( '%s Limitation in %s versus %s Limitation in %s',...
                 Limit{J}, CS_J, Limit{I}, CS_I  ); 
in = [I J];
ind = find( rs(:,I)>Thresh_I &  rs(:,J)>Thresh_J  ); numel( ind )
inn = find( rs(:,I)>Thresh_I |  rs(:,J)>Thresh_J  );
slopes = [sl(ind,I)  sl(ind,J) ];
%
%//Plot a scatter plot of the slopes 
diff = abs( slopes(:,1) - slopes(:,2) );        Thresh = 8; 

fig = figure;
plot( slopes(:,1), slopes(:,2), 'ko',...
    'markerface', 'k',...
    'markeredge', 'k',...
    'markersize', 6 ),  hold on

if 0
color = 0.6;    
plot( sl(inn,I), sl(inn,J), 'o',...
    'color', color*[1 1 1], ...
    'markerface', color*[1 1 1],...
    'markeredge', color*[1 1 1],...
    'markersize', 6 )
end
r = pear2( sl(inn,I), sl(inn,J) );

alpha = 1.5;
plot( alpha*[-20 20],        [0 0],     'y-.', 'linewidth', 2.5 )
plot( [0 0],          alpha*[-20 20],   'y-.', 'linewidth', 2.5 ),  
%plot( alpha*[-20 20], alpha*[-20 20],   'm', 'linewidth', 2 ),  
axis( alpha*[-20 20 -20 20] )
% GO terms Bottons
GO = 26;
x_GO = [GO -GO -GO  GO]; x_TF = x_GO * 1.1;
y_GO = [GO  GO -GO -GO]; y_TF = y_GO * 1.1;

plot( x_GO, y_GO, 'ro', 'markersize', 14 );
plot( x_GO, y_GO, 'rs', 'markersize', 10 );
plot( x_GO, y_GO, 'ro', 'markersize', 7 );
plot( x_GO, y_GO, 'r.' );
plot( x_TF, y_TF, 'go', 'markersize', 14 );
plot( x_TF, y_TF, 'gs', 'markersize', 10 );
plot( x_TF, y_TF, 'go', 'markersize', 7 );
plot( x_TF, y_TF, 'g.' );



set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
print( fig, '-dpng', [ 'thumbnails/fn_' File_Name ] );

clear h
h(1) = xlabel( [ Limit{I}  ' Limitation in ' CS_I] );   %'Slopes in '  
h(2) = ylabel( [ Limit{J}  ' Limitation in ' CS_J] );   %'Slopes in ' 
h(3) = title ( sprintf( 'Correlation: $%+1.2f$', r ) );              
sett(h);                                



set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 550 550] );
set( fig, 'color',      [1 1 1] );
set( fig, 'position',   [365 85 721 710] )
set( fig, 'PaperSize',  10*[1 1], 'PaperPositionMode', 'auto' );  

sgd1 = 'http://db.yeastgenome.org/cgi-bin/search/quickSearch.pl?query=';
sgd2 = '&submit=Search';

%File_Name = 'Scatter_map_ESR';  %YMC_All  _Nielson'; 
%delete(  [ File_Name '.html' ] )
%delete(  [ File_Name '.png'  ] )

for i = 1:length(slopes)
    k = ind(i);
    ud.url = sprintf( '%s%s%s', sgd1, Common_Annot{k,2}, sgd2 ) ;
    ud.description = sprintf('header=[%s] body=[Slopes: %2.2f, %2.2f]',...
                             Common_Annot{k,2},...
                             slopes(i,1),...
                             slopes(i,2)  );        
                                          
    text( slopes(i,1), slopes(i,2),'',   'tag','click',    'UserData', ud )
end
for i=1:4
    ud.url = sprintf( '%s/%i/%d_S_%s', GO_Dir, i, i, 'results.html' ) ;
    ud.description = sprintf('header=[%s] body=[%s %d]',...
                             'GO Term Enrichment',...
                             'Quadrant: ',  i  );       
   text( x_GO(i), y_GO(i),'',   'tag','click',    'UserData', ud )
   
   tf = regexprep( TF{I,J}{i},...
   '\nTF	TARG	MY_SET	OVERLAP	P-VAL	TF_REG	TF_DESCRIPTION\n\n', '' );
   tf = regexprep( tf, '\n', '<br><br>\n' );
   ud.url = sprintf( '%s/%d_Y.TFs.dat', GO_Dir, i );
   ud.description = sprintf('header=[%s] body=[%s]',...
                             'TFs with significant Overlap',...
                              tf  );       
   text( x_TF(i), y_TF(i),'',   'tag','click',    'UserData', ud )
end
    makemap_grr(fig, File_Name, Title);
    %pause( 1 )
    close all
    end
end
    %web( [ File_Name '.html' ] ,'-browser')
%%
    
    
    
    
    
    
    
    
    
    
    
    
    
%%
%// Import Data
cd C:\Users\nslavov\DATA\1_PUMA\ArraySet_5_Phosph_Limit
[all_slopes annot] = xlsread( 'C:\Users\nslavov\DATA\1_PUMA\ArraySet_5_Phosph_Limit\inds_b.Genes.dat.glu_slopes_R_sq.xlsx' );
%[ymc_data ymc_annot] = xlsread( 'C:\Users\nslavov\DATA\YMC\YMC3.xlsx' ); 

ymc_type = dlmread( 'inds_bYMC_Clust.dat' );
ymc_type_all = dlmread( '4YMC_Clust.dat' );    
%%
k = 0; 
inds = zeros(1, 4 ); 
for i=1:4, ind{i} = find( ymc_type == i ); inds(i) = ind{i}(1);  end 
INDS = [ inds 1:length(all_slopes) ];
%INDS = [ inds([1 3]) ind{1}' ind{3}' ]; %ind{3}'
figure(2)
COLOR = [ 1 0 0; 0 1 0; 0 0 1; 0 0 0 ];  k = 0;
SIZE  = [ 6 6 6 5];
MARKER= { 'd', 's', 'o', '+' };
LEGEND= { 'YMC: R-B',...   % 1
          'YMC: R-C',...   % 2 
          'YMC: Oxy',...   % 3
          'YMC: None'   }; % 4
       
for i=INDS,  k=k+1; 
        
           Color = COLOR( ymc_type(i), : );
           Size  = SIZE ( ymc_type(i) );
           MarkerType = MARKER{ ymc_type(i) };     %  axis equal
           
           plot( all_slopes(i,1), all_slopes(i,2), MarkerType,...
           'markerface', Color, 'markeredge', Color, 'markersize', Size ), hold on
           
    if   k==4  
         h(1) = legend( LEGEND{:}, 2 );
    end 
end 

alpha = 1.2;
plot( alpha*[-20 20],        [0 0],     'y', 'linewidth', 2 )
plot( [0 0],          alpha*[-20 20],   'y', 'linewidth', 2 ),  
plot( alpha*[-20 20], alpha*[-20 20],   'm', 'linewidth', 2 ),  axis( alpha*[-20 20 -20 20] )

h(2) = xlabel( 'Slopes in Ethanol' );   set( gcf, 'color',      [1 1 1]          ); 
h(3) = ylabel( 'Slopes in Glucose' );   set( gca, 'Units',      'Pixels'         );
h(4) = title ( 'Slopes \& YMC' );       set( gca, 'position',   [80 80 550 550]  );
sett(h);                                set( gcf, 'position',   [365 85 721 710] )
%%
%%  PLOT for the 3 clusters 
clear h up dn;              up=0; dn=0;
%load Annot_GR_Genes_268
%[ESR.dat ESR.annot] = xlsread( 'C:\Users\nslavov\DATA\Gasch_ESR\ESR_Genes.xlsx' ); 
 load ESR_fig_3
for i=1:length(all_slopes)
    
%     ind_up = strmatch( annot{i+1,1},  Anot.up(:,1), 'exact' );
%     ind_dn = strmatch( annot{i+1,1},  Anot.down(:,1), 'exact' );
      
     ind_dn = [];
     ind_up = [];
     ind = strmatch( annot{i+1,1},  ESR.annot(:,1), 'exact' );
     if ~isempty(ind),           
         mean_expression = ESR.dat(ind);
         if mean_expression > 0
            ind_up = ind;
         elseif mean_expression < 0
             ind_dn = ind;
         end 
     end 

    if  ~isempty(ind_up),  Color = 'r';                                                             up=1+up;  in(up) = ind_up;                
        
          h(1) = plot( all_slopes(i,1), all_slopes(i,2), 'd', 'markerface', Color, 'markeredge', Color, 'markersize', 10 );  hold on
             
    elseif ~isempty(ind_dn),  Color = 'g';      dn=1+dn;  in(dn) = ind_dn;
        
          h(2) =  plot( all_slopes(i,1), all_slopes(i,2), 's', 'markerface', Color, 'markeredge', Color, 'markersize', 10 );  hold on
    else
             plot( all_slopes(i,1), all_slopes(i,2), 'o', 'markerface', 'k', 'markeredge', 'k', 'markersize', 3 ),  hold on
    end 
    
end 
    %h(1) = legend( h, 'Positive in Nielsen', 'Negative in Nielsen', 2 ); 
    h(1) = legend( h, 'Positive in ESR', 'Negative in ESR', 2 );

alpha = 1.2;
plot( alpha*[-20 20],        [0 0],     'y', 'linewidth', 2 )
plot( [0 0],          alpha*[-20 20],   'y', 'linewidth', 2 ),  
plot( alpha*[-20 20], alpha*[-20 20],   'm', 'linewidth', 2 ),  axis( alpha*[-20 20 -20 20] )

h(2) = xlabel( 'Slopes in Ethanol' );   set( gcf, 'color',      [1 1 1]          ); 
h(3) = ylabel( 'Slopes in Glucose' );   set( gca, 'Units',      'Pixels'         );
h(4) = title ( 'Slopes \& ESR' );       set( gca, 'position',   [80 80 550 550]  );
sett(h);                                set( gcf, 'position',   [365 85 721 710] )











