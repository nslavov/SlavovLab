%%
DIR = 'grr-3/hist/';
Dir = dir( DIR );

for i=1:length(Dir)
    
    if strcmp( Dir(i).name(1), '.' ) ||...
       strcmp( Dir(i).name(1), 'd' ), continue; end
    
    k = strfind( Dir(i).name, '-' );
    
    if ~isempty(k)
        J = 2;
        J = str2double( Dir(i).name(k+1:end) )+1;
        I = str2double( Dir(i).name(1:k-1) );
    else
        J = 1;
        I = str2double( Dir(i).name );
    end 
    
    
    x = dlmread( [DIR Dir(i).name ] );

    dat{ I,J } = x;
end

save ( [DIR 'dat'], 'dat' ); 
%%
for i=1:11
    
    figure
    
    plot( dat{i,1}(:,1), dat{i,1}(:,2), 'g', 'linewidth', 2);  hold on     
    plot( dat{i,2}(:,1), dat{i,2}(:,2), 'r', 'linewidth', 2);
    
    xlim( [2 6] ); 
    
end 

%%

for i=1:3
    
    %figure
    
    x = 0.5 * dat{i,1}(:,1) + dat{i,1}(:,2);  %x = x * (1/sum(x)); 
    
    plot( dat{i,1}(:,1), x,  'linewidth', 2);  hold all     
   
    xlim( [2 5] ); 
    
end


%%

for i=7:9
    
    %figure
    
    x = 0.5 * dat{i,1}(:,1) + dat{i,1}(:,2);  x = x * (1/sum(x)); 
    
    plot( dat{i,1}(:,1), x,  'linewidth', 2);  hold all     
   
    xlim( [2 5] ); 
    
end

%%
ONES = ones(length(dat{1,1}(:,1)));
ln = { 'linewidth', 2 };

for i=1:3
    
    x = 0.5 * dat{i,1}(:,1) + dat{i,1}(:,2);  x = x * (1/sum(x));
    
    plot3( dat{i,1}(:,1), i*ONES, x, ln{:} ); hold on
end 
xlim( [2 5] );



%%
d = zeros( length( dat{1,1}(:,1) ), 11 );

for i=1:11
    
    d(:,i) = 0.5 * ( dat{i,1}(:,2) +  dat{i,2}(:,2) );
    
    d(:,i) = d(:,i) * (1/sum( d(:,i) )); 
    
end 
%%
im( d(1:80,:) ), rg



%%
volumes = [
    12 12 40     12 12 30    11 11 30   13 13
    13 13 30     13 13 30    13 13 30   13 13 
    13 13 30     13 13 30    13 13 30   13 13 ];
%%
for i=1:3
    
    load( [ 'grr-' num2str(i) '/hist/dat.mat' ] ); 
    
    y = cell_mean( dat );
    
    y = y( 1:100, 1:11 )';
    
    cell_count(i,:) = sum( y, 2 );
    
    biomass(i,:) = ( y * dat{1,1}(1:100 ,1).^3 )'  * (4*pi/6);
    
    sampled_biomass(i,:) = volumes(i,:) .* biomass(i,:);
end 
%%    
sampled_biomass = 1e-6 * sampled_biomass    
    
    
    
%% Reproducibility Plots
DIR = 'grr-3/';
Img_Dir = [ DIR filesep 'hist_img' ];
load( [DIR 'hist/dat'] );
mkdir( Img_Dir );
Limit = { 'Ethanol', 'Nitrogen', 'Phosphate' };


Mean = zeros( size( dat{1,1}(:,2) ), 9 );
for I=1:9
fig = figure;
for i=1:size(dat,2)
    if isempty( dat{I,i} ), i=i-1; continue; end 
    plot( dat{I,i}(:,1), dat{I,i}(:,2), 'r-' ); hold all    
    Mean(:,I) = Mean(:,I) + dat{I,i}(:,2);
end
Mean(:,I) = Mean(:,I) * (1/i);

plot( dat{I,i}(:,1), Mean(:,I), 'k', 'linewidth', 2 );

xlim( [2 6] )

if 0
switch mod( I, 3 )
    case 1, gr= '0.05'; 
    case 2, gr= '0.10';
    case 0, gr= '0.14';
end
tp = ceil(I/3);
File_Name = [Limit{ tp } '_' gr ];
Title = [Limit{ tp }...
    ' Limitation at Growth Rate ' gr '$h^{-1}$' ];

clear h
h(1) = xlabel( 'Cell Diameter, $\mu m$' );     
h(2) = ylabel( 'Number of Cells' );   
h(3) = title (  Title  );              
%set(h, 'FontSize', 18);
sett(h);


set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 550 550] );
set( fig, 'color',      [1 1 1] );
set( fig, 'position',   [365 85 721 710] )
set( fig, 'PaperSize',  10*[1 1], 'PaperPositionMode', 'auto' );
%figure(fig);
%
%pdf( [Img_Dir filesep File_Name], [8 8] )
close all
end
end
%%
%%
Img_Dir = [ DIR filesep 'hist_img_decomp' ];
load( [DIR 'hist/dat'] );
mkdir( Img_Dir );
hat_Param = zeros( 9, 6+0 );
global Y x
for  I=1:9
x = dat{I,1}(:,1);
Y = Mean(:,I);    

% Param = [2.5 3.0 0.02 0.01   500  500    ];
% lb =    [1.8 2.3 0.02 0.01    50   50    ]; 
% ub =    [3.0 4.1 0.80 0.80  2750 1750     ];

% gauss_2d  parameters
% Param = [2.5  3.5 0.01  0.01   200  200];
% lb =    [2.3  3.1 0.02  0.01    50   50]; 
% ub =    [3.0  4.5 0.12  0.12  2750  750];

% poiss_2d  parameters
Param = [2.5  3.5    200  200];
lb =    [2.2  3.1    50    50]; 
ub =    [3.0  4.5   2750  750];

hat_Param(I,:) = fmincon(@poiss_2d, Param, [],[],[],[], lb, ub );
disp( hat_Param(I,:) )

[SSR  Y_model Y1 Y2] = poiss_2d( hat_Param(I,:) );
% 
Area(I,:) = [x' * Y1  x' * Y2];
fig = figure;
plot( x, Y, 'k', 'linewidth', 2 ), hold on
plot( x, Y_model, 'r', 'linewidth', 2 );
plot( x, Y1, 'g', 'linewidth', 2 )
plot( x, Y2, 'm', 'linewidth', 2 )
xlim( [2 6] )
    
switch mod( I, 3 )
    case 1, gr= '0.05'; 
    case 2, gr= '0.10';
    case 0, gr= '0.14';
end
tp = ceil(I/3);
File_Name = [Limit{ tp } '_' gr ];
Title = [Limit{ tp }...
    ' Limitation at Growth Rate ' gr '$h^{-1}$' ];

clear h
h(1) = xlabel( 'Cell Diameter, $\mu m$' );     
h(2) = ylabel( 'Number of Cells' );   
h(3) = title (  Title  );
hh = legend( 'Data', 'Model', 'Unbudded', 'Budded' ); 
set(hh, 'FontSize', 18, 'FontWeight', 'Bold');
sett(h);



set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 550 550] );
set( fig, 'color',      [1 1 1] );
set( fig, 'position',   [365 85 721 710] )
set( fig, 'PaperSize',  10*[1 1], 'PaperPositionMode', 'auto' );
%figure(fig);
%
%pdf( [Img_Dir filesep File_Name], [8 8] )
pause ( 5 );
close all    
end    
%save([Img_Dir filesep 'hat_Param'], 'hat_Param', 'Mean' );    
%%
bd_fr = hat_Param(:,6)./sum(hat_Param(:,5:6),2);
gr = [0.05 0.10 0.14]; 
%bd_fr = Area(:,2)./sum(Area(:,1:2),2);

plot( gr, bd_fr(1:3), 'ko-',  'linewidth', 2  ), hold on
plot( gr, bd_fr(4:6), 'ro-',  'linewidth', 2  )
plot( gr, bd_fr(7:9), 'go-',  'linewidth', 2  )
    
    
    
    







