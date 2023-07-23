%%
Img_Dir = [ DIR filesep 'hist_img_decomp_gener_2' ];
load( [DIR 'hist/dat'] );
mkdir( Img_Dir );
hat_Param = zeros( 9, 8 );
global par x Y
for  I=1:9
x = dat{I,1}(:,1);
Y = Mean(:,I); 


par.Mu = 0;
par.Variance=.02;
par.Alpha=2;
par.Kapa=-3; 
par.Etha=2;


Param = [2.7  3.5  2  1   -3.0  -3.0     200  200];
lb =    [2.3  3.2  2  0   -3.5  -3.5      40   10]; 
ub =    [3.2  4.0  3  2.5 -2.5  -2.5    1750  750];
% Param = [2.7  3.5  2  1        200  200];
% lb =    [2.3  3.1  2  0         40   10]; 
% ub =    [3.0  4.0  3  1.5     1750  750];

hat_Param(I,:) = fmincon(@gener_gauss_2d, Param, [],[],[],[], lb, ub );
disp( hat_Param(I,:) )

[SSR  Y_model Y1 Y2] = gener_gauss_2d( hat_Param(I,:) );
% 
Area(I,:) = [par.x_1' * Y1  par.x_2' * Y2];
fig = figure;
plot( x, Y, 'k', 'linewidth', 4 ), hold on
plot( x, Y_model, 'r--', 'linewidth', 3.5 );
plot( par.x_1, Y1, 'g-.', 'linewidth', 3.5 )
plot( par.x_2, Y2, 'm', 'linewidth', 2 )
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
pdf( [Img_Dir filesep 'cc_' num2str(I)], [8 8] )
pause ( 5 );
close all    
end    
%save([Img_Dir filesep 'hat_Param'], 'hat_Param', 'Mean' );    
%%
gr = [0.05 0.10 0.14]; 
bd_fr = hat_Param(:,6)./sum(hat_Param(:,5:6),2);
bd_fr = Area(:,2)./sum(Area(:,1:2),2);
bd_fr = hat_Param(:,8)./sum(hat_Param(:,7:8),2);

plot( gr, bd_fr(1:3), 'ko-',  'linewidth', 2  ), hold on
plot( gr, bd_fr(4:6), 'ro-',  'linewidth', 2  )
plot( gr, bd_fr(7:9), 'go-',  'linewidth', 2  )


%%
dat=[
86  131 77  93  139 101 140 113 150 
13   34 31  17  36   47  23  33  57 ];

c = dat(2,:) ./ sum( dat );
error_barr = c .* dat(1,:).^-0.5;

bd_fr = hat_Param(:,6)./sum(hat_Param(:,5:6),2);


%pp(c, bd_fr, '.' )
c=c(:);
ind = find(  abs( c - bd_fr)./c < .5 );

[a b] = linFit( c(ind), bd_fr(ind) );


xlim( [.1 .35] )
ylim( [.1 .25] )



%%
clear h
h(1) = xlabel( 'Budded Fraction, Manual' );     
h(2) = ylabel( 'Budded Fraction, Coulter Counter' );   
h(3) = legend( 'Data', 'Linear Fit', 2 ); 
set(h, 'FontSize', 18, 'FontWeight', 'Bold');
%sett(h);


fig=gcf;
set( gca, 'FontWeight', 'Bold', 'FontSize', 12 );
set( gca, 'Units',      'Pixels'         );
set( gca, 'position',   [80  80 550 550] );
set( fig, 'color',      [1 1 1] );
set( fig, 'position',   [365 85 721 710] )
set( fig, 'PaperSize',  10*[1 1], 'PaperPositionMode', 'auto' );
figure(fig);
%%
pdf( [Img_Dir filesep 'Manual_vs_CoulterCounter'], [8 7.5] );

































    
    