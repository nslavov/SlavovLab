%%
cd C:\Users\nslavov\Code\matlab\gr-rate\grr_html\Scatters\col
DIR = '../GO_Terms'; 
load ../../../slavov_brauer_slopes_Rsq.mat
load ../GO_Terms/TFs.mat
%% Define Gene Sets 
Ind.set1 = strmatch( 'RP', Common_Annot(:,2) ); 
Ind.set2 = strmatch( 'SEC', Common_Annot(:,2) );
%% Define Gene Sets :: YMC 
Path = 'C:\Users\nslavov\data\ymc\GeneSet\';
ymc.ox.nm = read_annot(  [Path  'Sup_Cluster_Ox.tsv' ] ); %intersect( ymc.ox.nm(:,2), Common_Annot(:,1) )
ymc.ox.ind = ismember( Common_Annot(:,1), ymc.ox.nm(:,2) );

ymc.rc.nm = read_annot(  [Path  'Sup_Cluster_R_C.tsv' ] ); %intersect( ymc.ox.nm(:,2), Common_Annot(:,1) )
ymc.rc.ind = ismember( Common_Annot(:,1), ymc.rc.nm(:,2) );

Ind.set1 = find( ymc.ox.ind==1 );
Ind.set2 = find( ymc.rc.ind==1 );

%% Define Gene Sets :: ESR
Path = 'C:\Users\nslavov\data\Gasch_ESR\';
[esr.dat esr.nm] = xlsread( [ Path 'ESR_Genes.xlsx' ] ); 

ind1 = ismember( Common_Annot(:,1), esr.nm(esr.dat>0) );
ind2 = ismember( Common_Annot(:,2), esr.nm(esr.dat>0) );
Ind.set1 = unique( [find(ind1==1); find(ind2==1)] );  

ind1 = ismember( Common_Annot(:,1), esr.nm(esr.dat<0) );
ind2 = ismember( Common_Annot(:,2), esr.nm(esr.dat<0) );
Ind.set2 = unique( [find(ind1==1); find(ind2==1)] ); 
%%
Limit = { 'Ethanol', 'Nitrogen', 'Phosphate',...
          'Glucose', 'Nitrogen', 'Phosphate',...
          'Sulpher', 'Leu',       'Ura'         }; 

for I=1:9
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
%inn = find( rs(:,I)>Thresh_I |  rs(:,J)>Thresh_J  );
slopes = [sl(ind,I)  sl(ind,J) ];

Ind.s1 = intersect( Ind.set1, ind );
Ind.s2 = intersect( Ind.set2, ind );
%
%//Plot a scatter plot of the slopes 
diff = abs( slopes(:,1) - slopes(:,2) );        Thresh = 8; 

fig = figure;
plot( slopes(:,1), slopes(:,2), 'ko',...
    'markerface', 'k',...
    'markeredge', 'k',...
    'markersize', 6 ),  hold on

if ~isempty(Ind.s1)
color = [1 0 0.8];    
plot( sl(Ind.s1,I), sl(Ind.s1,J), 's',...
    'color', color, ...
    'markerface', color,...
    'markeredge', color,...
    'markersize', 6 );
end
if ~isempty(Ind.s2)
color = [0.2 0.8 1];    
plot( sl(Ind.s2,I), sl(Ind.s2,J), 'd',...
    'color', color, ...
    'markerface', color,...
    'markeredge', color,...
    'markersize', 6 );
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
    
    
    
    
    
    
    
    
    
    
