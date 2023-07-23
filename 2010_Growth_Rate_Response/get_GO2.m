%%
addpath data.mat
if ~exist( 'go', 'var' )
	load data.mat/gene_association.mat
	%load data.mat/go_slim_mapping
	load data.mat/slavov_brauer_dat_commonRef.mat
end
%% Plot His Lys, Eth, Brauer. All Limitations in a single Distribution
close all
clear h hh HDI hz 
DIR = ['slavov_brauer2'  filesep];
DIR_dist ='Distributions_of_Slopes/';

DIR_PCL_sl = 'slopes_PCL/';
DIR_mat_sl = 'slopes_Clustergramts/';

DIR_PCL_dat = 'exData_PCL/';
DIR_mat_dat = 'exData_Clustergramts/';


mkdir( DIR );
mkdir( [ DIR DIR_dist] );
mkdir( [ DIR DIR_PCL_sl] );
mkdir( [ DIR DIR_mat_sl] );
mkdir( [ DIR DIR_PCL_dat] );
mkdir( [ DIR DIR_mat_dat] );

l = -17 : 2 : 17;  
ll = l;
ll(1) = -99;
ll(end) = 99;


DAT{1} = cm.sl(:,1:3);
freq_bg.eth = histc( DAT{1}, ll );
freq_bg.eth = freq_bg.eth * (1/sum( freq_bg.eth(:,1) ) );
BG{2} = freq_bg.eth;

DAT{2} = cm.sl(:,4:6);
freq_bg.glu = histc(  DAT{2} , ll );
freq_bg.glu = freq_bg.glu * (1/sum( freq_bg.glu(:,1) ) );
BG{1} = freq_bg.glu;


FR = cell(2,1);

for k=1:(numel( go.Terms )-1)
    ind = strmatch( go.Terms{k},  go.term, 'exact' );
    ind = go.inds.commonRef_eth_br(ind);
    ind = ind( ind>0 );
	if numel(ind)<5, continue, end 
    
    Dat{1} = cm.sl( ind ,1:3);
    Freq = histc( Dat{1}, ll );
    freq.eth = Freq * (1/sum( Freq(:,1) ));      
    FR{1} = freq.eth;
    
    Dat{2} =cm.sl( ind ,4:6);
    Freq = histc(  Dat{2}, ll );
    freq.glu = Freq * (1/sum( Freq(:,1) ));
    FR{2} = freq.glu; 
% ======================================================= 
    Title = { 'Carbon Source', 'Nitrogen', 'Phosphate' };
    COLOR = { 'r', 'b', 'g' }; hi=1; hdi=1;
    for i=1:2
      for j=1:3 
          subplot( 2, 3, 3*(i-1)+j ); 
          plot( l, BG{i}(:,j), ['k' '-'], 'linewidth', 3 ), hold on
          plot( l, FR{i}(:,j), [COLOR{j} '-'], 'linewidth', 5 )
          
          MAX = max( max( BG{i}(:,j)), max( FR{i}(:,j)) );
          
          set( gcf, 'Position',  [66       268      1159      528] );
          set( gca, 'FontSize', 10, 'FontWeight', 'Bold' );
          
          set(gca, 'Xtick', [-14  -10 : 5 : 10 14]  ); %[-17  -15 : 5 : 15 17]
          set(gca, 'XtickLabel', [-14  -10 : 5 : 10 14]  ); %[-99 -15 : 5 : 15 99]
          
          xlim( 17*[-1 1] );
          ylim( [0 1.1*MAX] );
          
          HDI(hdi) = text( -16, 0, '/' ); hdi=hdi+1;
          HDI(hdi) = text(  16, 0, '/' ); hdi=hdi+1;
          
          %ChiSq =  nansum( (BG{i}(:,j)-FR{i}(:,j)).^2 ./BG{i}(:,j)  );
          %chi2stat
          %[Hypo p_val] = ttest2( DAT{i}(:,j), Dat{i}(:,j) );
          
          p_val = ranksum( DAT{i}(:,j), Dat{i}(:,j) );
          if p_val==0, p_val = 1e-20; end
          PVAL = sprintf( 'p<10^{%d}', ceil( log10(p_val) ) );
          
          h(hi) = text( -16, MAX, PVAL ); hi=hi+1;
          if i==1,
              title( Title{j}, 'Color',  COLOR{j},   'FontSize', 24, 'FontWeight', 'Bold'  );           %hi=hi+1;
              if j==1, h_CarbonSource(1) = ylabel( 'Ethanol CS' );  end  %hi=hi+1;
          else
              h(hi) = xlabel( 'Slopes' ); hi=hi+1;
              if j==1, h_CarbonSource(2) = ylabel( 'Glucose CS' );  end  %hi=hi+1;
          end         
      end
    end
    set( h_CarbonSource,...
           'FontSize',               24 ,...
           'FontWeight',        'Bold' ,...
           'Color',                  'm'      ); 
    
    sett( h, 20 );
    set( HDI, 'FontSize', 22, 'FontWeight', 'Bold' ); 
% ======================================================= 
    filename = regexprep(  go.Terms{k}, ':', '_' );
    
    
    pdf( sprintf( '%s%s%s', DIR,  DIR_dist, filename), [14 8] ); 
    sett( h, 14 );
    png( sprintf( '%s%s%s', DIR, DIR_dist, filename), [11 6] ); 
    pause( 1 ); 
    close all
% =======================================================    
    % Prints a Clustergram of SLOPES & FOLD CHANGES and Writes a PCL File 
    
    Slopes = [ cm.sl(ind,1:3) zeros(numel(ind),1),...
                     cm.sl(ind,4:6) zeros(numel(ind),1),...
                     cm.foldChange( ind, :) ];
   exData = [ cm.dat(ind,1:9) zeros(numel(ind),1),...
                     cm.dat(ind, [10:12  16:18  22:24 ] )    ];             
    
    %Slopes( isnan(Slopes) ) = 0;       
    CLU = clu( [Slopes exData], 3 );  close all
    
    imagesc( Slopes( CLU, : ) ); colorbar
    colormap( redbluecmap );    set( gca, 'Clim', 15*[-1 1] );
    ind = ind(CLU); 
    
    set( gcf, 'Position', [50    50   800   500] );
    set(gca, 'Position', [0.13   0.14      0.69       0.76] )
    set(gca, 'Ytick', [] );
    set(gca, 'Xtick', [1:3 5:7 9:11] );
    set(gca, 'XtickLabel', {'Eth', 'N', 'P',    'Glu', 'N', 'P',      'E/G', 'N', 'P'}  );
    set(gca, 'FontSize', 20, 'FontWeight', 'Bold' );
    
    hz(1) = text( 0.53, -6.5*(numel(ind)/207), 'Slopes in Ethanol' );
    hz(2) = text( 4.53, -6.5*(numel(ind)/207), 'Slopes in Glucose' );
    hz(3) = text( 8.53, -6.5*(numel(ind)/207), 'Mean Fold Change' );
    set( hz,   'FontSize',               14 ,...
                  'FontWeight',        'Bold' ,...
                  'Color',                  'm'      ); 

    hh(1) = xlabel( 'Conditions' );
    hh(2) = ylabel( 'Genes' );
    %hh(3) = title( go.Descriptions{k} ); 
    sett(hh, 20 );
    File_Name_sl.mat = sprintf( '%s%s%s', DIR, DIR_mat_sl, filename );
    %pdf( File_Name_mat, [8 6.5], 1 );
    png( File_Name_sl.mat , [8 6.5]  );
    pause(1);
    %keyboard
    close all;
 %   
    File_Name_sl.pcl = sprintf( '%s%s%s.pcl', DIR, DIR_PCL_sl, filename );
    Fid = fopen(  File_Name_sl.pcl, 'w'  ); 
    fprintf(Fid, 'YORF\tNAME\tGWEIGHT\tSlope::ETH::Ethanol\tSlope::ETH::Nitrogen\tSlope::ETH::Phosphate\t \t' );
    fprintf(Fid,                      'Slope::GLU::Glucose\tSlope:GLU::Nitrogen\tSlope::GLU::Phosphate\t \t' );
    fprintf(Fid,                      'FoldChange:CarbonSource\tFoldChange::Nitrogen\tFoldChange::Phosphate\n' );
    fprintf(Fid, 'EWEIGHT\t \t\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n' );
    for i=1:numel(ind)  
       ii = ind(i);
       Description = getFun( cm.annot{ii,2}, 1 );
       fprintf(Fid, '%s\t%s :: %s\t%d', cm.annot{ii,2}, cm.annot{ii,1},  Description{1,3},  1 );
       fprintf(Fid, '\t%1.2f',    Slopes(CLU(i),:) );
       fprintf(Fid, '\n' ); 

    end
    fclose( Fid );
   % system( [ 'start '  File_Name_sl.pcl ] );
%% =======================================================    
    % Prints a Clustergram of GENE EXPRESSION LEVELS and Writes a PCL File
    
    
    %exData( isnan(exData) ) = 0;       
    %CLU = clu( exData, 3 ); rg(3);  
    %ind = ind(CLU); 
    imagesc( exData( CLU, : ) ); rg(3);
    
    set( gcf, 'Position', [50    50   800   500] );
    set(gca, 'Position', [0.13   0.14      0.69       0.76] )
    set(gca, 'Ytick', [] );
    set(gca, 'Xtick', [ 2: 3 : 9    12 : 3 : 19 ] );
    set(gca, 'XtickLabel', {'Eth', 'N', 'P',    'Glu', 'N', 'P',     }  );
    set(gca, 'FontSize', 20, 'FontWeight', 'Bold' );
    
    clear hz
    hz(1) = text( 1.5, -6.5*(numel(ind)/207), 'Expression in Ethanol' );
    hz(2) = text( 11.5, -6.5*(numel(ind)/207), 'Expression in Glucose' );
    set( hz,   'FontSize',               14 ,...
                  'FontWeight',        'Bold' ,...
                  'Color',                   'm'      ); 

    hh(1) = xlabel( 'Conditions' );
    hh(2) = ylabel( 'Genes' );
    %hh(3) = title( go.Descriptions{k} ); 
    sett(hh, 20 );
    File_Name_dat.mat = sprintf( '%s%s%s', DIR, DIR_mat_dat, filename );
    %pdf( File_Name_mat, [8 6.5], 1 );
    png( File_Name_dat.mat, [8 6.5]  );
    pause(1);
    close all;
    
    
    File_Name_dat.pcl = sprintf( '%s%s%s.pcl', DIR, DIR_PCL_dat, filename );
    Fid = fopen(  File_Name_dat.pcl, 'w'  ); 
    fprintf(Fid, 'YORF\tNAME\tGWEIGHT' );
    fprintf(Fid,             '\tETH::Ethanol:%1.2f',  [0.05 0.10, 0.14] );
    fprintf(Fid,             '\tETH::Nitrogen:%1.2f',  [0.05 0.10, 0.14] );
    fprintf(Fid,             '\tETH::Phosphate:%1.2f',  [0.05 0.10, 0.14] );
    
    fprintf(Fid,             '\tSeparator' );
    
    fprintf(Fid,             '\tGLU::Glucose:%1.2f',          0.05 :0.05 : 0.15 );
    fprintf(Fid,             '\tGLU::Nitrogen:%1.2f',        0.05 :0.05 : 0.15 );
    fprintf(Fid,             '\tGLU::Phosphate:%1.2f',     0.05 :0.05 : 0.15 );

    fprintf(Fid, '\n' );

    fprintf(Fid, 'EWEIGHT\t \t' );
    fprintf(Fid, '\t%d',  ones(1, 9+1+9) );
    fprintf(Fid, '\n' );
    for i=1:numel(ind)  
       ii = ind(i);
       Description = getFun( cm.annot{ii,2}, 1 );
       fprintf(Fid, '%s\t%s :: %s\t%d', cm.annot{ii,2}, cm.annot{ii,1},  Description{1,3}, 1 );
       fprintf(Fid, '\t%1.2f',    exData(CLU(i),:) );
       fprintf(Fid, '\n' ); 

    end
    fclose( Fid );    
% ==================================================================================

    % Write HTML
    File_Name_html = sprintf( '%s%s.html', DIR, filename );
    Fid = fopen(  File_Name_html, 'w'  );
    
    fprintf(Fid, '<head>\n' );
    fprintf(Fid, '<LINK rel="shortcut icon" href="http://www.princeton.edu/~nslavov/index_files/icons/Starred.ico">\n' );
    
    fprintf(Fid, '<LINK rel="stylesheet" href="http://www.princeton.edu/~nslavov/bin/boxover2/my350" type="text/css">\n' );   
    fprintf(Fid, '<SCRIPT SRC="http://www.princeton.edu/~nslavov/bin/boxover2/boxover.js"></SCRIPT>\n' );
    fprintf(Fid, '</head>\n' );
    
    fprintf(Fid, '<body>\n' );
    Title = go.Descriptions{k};
    Title(1) = ch_cap( Title(1) ); 
    fprintf(Fid,'<h1 style=text-align:center;> %s, %d Genes</h1>\n\n', Title, numel(ind));
    
    height2 = 'style="width: 900px;"';
    height = 'style="width: 450px;"';%height: 300px; width: 500px; 
    
    fprintf(Fid, '<table style="margin-left: auto; margin-right: auto;"><tr>\n' );
    fprintf(Fid, '<td colspan="2" > <a href="%s%s.pdf">',               DIR_dist, filename ); 
    fprintf(Fid, '<img src="%s%s.png" %s></img> </a>\n',   DIR_dist, filename,  height2 );
    fprintf(Fid, '<tr> <td colspan="2"> <img src="Legend2.png" %s></img>\n',  height2 ); 
    fprintf(Fid, '<tr>\n' );
                  fprintf(Fid, '<td style=text-align:center;>\n' );
         fprintf(Fid, '<APPLET\n' );
         fprintf(Fid, 'code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"\n' );
         fprintf(Fid, 'archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"\n' );
         fprintf(Fid, 'width="200" height="40"\n' );
         fprintf(Fid, ' alt="Your browser understands the &lt;APPLET&gt; tag but is not running the applet, for some reason." \n');
         fprintf(Fid, '>\n' );
         fprintf(Fid, 'Your browser is completely ignoring the &lt;APPLET&gt; tag!\n' );
         fprintf(Fid, '<param name="cdtFile" value="%s%s.pcl">\n',  DIR_PCL_sl, filename );
         fprintf(Fid, '<param name="cdtName" value="Slopes in JTV">\n' );
         fprintf(Fid, '<param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">\n' );
         fprintf(Fid, '</APPLET>\n' );
          fprintf(Fid, '<br>\n' );
          fprintf(Fid, '<a href="%s%s.png">',               DIR_mat_sl, filename ); 
          fprintf(Fid, '<img src="%s%s.png" %s></img> </a>\n',   DIR_mat_sl, filename, height );
                 fprintf(Fid, '<td style=text-align:center;>\n' );     
         fprintf(Fid, '<APPLET\n' );
         fprintf(Fid, 'code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"\n' );
         fprintf(Fid, 'archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"\n' );
         fprintf(Fid, 'width="200" height="40"\n' );
         fprintf(Fid, ' alt="Your browser understands the &lt;APPLET&gt; tag but is not running the applet, for some reason." \n');
         fprintf(Fid, '>\n' );
         fprintf(Fid, 'Your browser is completely ignoring the &lt;APPLET&gt; tag!\n' );
         fprintf(Fid, '<param name="cdtFile" value="%s%s.pcl">\n',  DIR_PCL_dat, filename );
         fprintf(Fid, '<param name="cdtName" value="Expresion in JTV">\n' );
         fprintf(Fid, '<param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">\n' );
         fprintf(Fid, '</APPLET>\n' );
         fprintf(Fid, '<br>\n' );
         fprintf(Fid, ' <a href="%s%s.png">',               DIR_mat_dat, filename ); 
         fprintf(Fid, '<img src="%s%s.png" %s></img> </a>\n',   DIR_mat_dat, filename, height );
    fprintf(Fid, '</tr></table>\n' );
    fclose( Fid );
    system( sprintf( 'cp  %s%sjtv.jtv    %s%s%s.jtv', DIR, DIR_PCL_sl,          DIR, DIR_PCL_sl,  filename )  ); 
%system( ['start ' File_Name_html] );     
end






%%
% % make Legend
%     Title = { 'All Genes', ... %'Background',...
%               'GO Term Carbon Source',...
%               'GO Term Nitrogen',...
%               'GO Term Phosphate' };
%     COLOR = { 'k', 'r', 'b', 'g' }; 
% for i=1:4
%     plot( 1,2, COLOR{i}, 'linewidth', 8 ), hold on
% end
% hleg = legend( Title, 'Location',     'North',...
%                       'Orientation',  'Horizontal' );
% 
% sett( hleg );
% 
% %%
% pdf( 'Legend', [18, 15], 1 )













