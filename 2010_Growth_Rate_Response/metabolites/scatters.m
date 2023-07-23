%%
Limit = { 'Ethanol', 'Nitrogen', 'Phosphate',...
          'Glucose', 'Nitrogen', 'Phosphate',...
          'Sulpher', 'Lue',       'Ura'         };

I=1;
J=3;

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
Title = sprintf( '%s Limitation versus %s Limitation',...
                 Limit{J}, Limit{I} );

ind = find( r_ex(:,I)>0.5 &  r_ex(:,J)>0.5  ); numel( ind )

fig = figure;
plot( s_ex(ind,I), s_ex(ind,J), 'ko',...
                                'markerface', 'k',...
                                'markeredge', 'k',...
                                'markersize', 6 ),  hold on

alpha = 1.5;
plot( alpha*[-20 20],        [0 0],     'y-.', 'linewidth', 2.5 )
plot( [0 0],          alpha*[-20 20],   'y-.', 'linewidth', 2.5 ),  
%plot( alpha*[-20 20], alpha*[-20 20],   'm', 'linewidth', 2 ),  
axis( alpha*[-20 20 -20 20] )

clear h
h(1) = xlabel( [ Limit{I}  ' Limitation in ' CS_I] );   %'Slopes in '  
h(2) = ylabel( [ Limit{J}  ' Limitation in ' CS_J] );   %'Slopes in ' 
%h(3) = title ( 'Slopes' );              
set(h, 'FontSize', 18);                                


set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 550 550] );
set( fig, 'color',      [1 1 1] );
set( fig, 'position',   [365 85 721 710] )
set( fig, 'PaperSize',  10*[1 1], 'PaperPositionMode', 'auto' );





for i = 1:length(ind)
    k = ind(i);
    ud.url = sprintf( '%s%s.html',...
     'http://www.princeton.edu/~nslavov/meta/',  metab{k,1});
    ud.description = sprintf('header=[%s] body=[Slopes: %2.2f, %2.2f]',...
                             metab{k,1},...
                             s_ex(k,I),...
                             s_ex(k,J)  );        
                                          
    text(  s_ex(k,I), s_ex(k,J),'',   'tag','click',    'UserData', ud );
end

makemap(fig, File_Name, Title);
%pause( 1 )
close all


web( [ File_Name '.html' ] ,'-browser')


%%
%pdf( File_Name, [8 8] )
