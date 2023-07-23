%%
DIR = 'GO_Terms';
load ../../slavov_brauer_slopes_Rsq.mat
load GO_Terms/TFs.mat
%%
Limit = { 'Ethanol', 'Nitrogen', 'Phosphate',...
          'Glucose', 'Nitrogen', 'Phosphate',...
          'Sulpher', 'Lue',       'Ura'         }; 

for I=5:7 %9
    for J=(I+1):9

%I=4;
%J=1;
GO_Dir = sprintf( '%s/go_%d_%d', DIR, I, J ); 
%mkdir( GO_Dir );   
if I>3, CS_I = 'Glucose'; 
        Thresh_I = 0.5; 
else    CS_I = 'Ethanol';
        Thresh_I = 0.9;
end
if J>3, CS_J = 'Glucose'; 
        Thresh_J = 0.5; 
else    CS_J = 'Ethanol';
        Thresh_J = 0.9;
end

File_Name = sprintf( 'lims_%d_%d', I, J );
Title = sprintf( '%s Limitation in %s versus %s Limitation in %s',...
                 Limit{J}, CS_J, Limit{I}, CS_I  ); 
in = [I J];
ind = find( rs(:,I)>Thresh_I &  rs(:,J)>Thresh_J  ); 
inn = find( rs(:,I)>Thresh_I |  rs(:,J)>Thresh_J  );
fprintf( 'Both: %d Only one: %d\n', numel( ind ), numel( inn ) );
slopes = [sl(ind,I)  sl(ind,J) ];
%
%//Plot a scatter plot of the slopes 
diff = abs( slopes(:,1) - slopes(:,2) );        Thresh = 8; 

fig = figure;

if 1
color = 0.6;    
plot( sl(inn,I), sl(inn,J), 'o',...
    'color', color*[1 1 1], ...
    'markerface', color*[1 1 1],...
    'markeredge', color*[1 1 1],...
    'markersize', 4 ), hold on
end


plot( slopes(:,1), slopes(:,2), 'ko',...
    'markerface', 'k',...
    'markeredge', 'k',...
    'markersize', 6 ),  hold on



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
pause(5)
    end
end