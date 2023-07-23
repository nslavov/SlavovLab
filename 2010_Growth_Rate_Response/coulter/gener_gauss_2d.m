function [SSR Y_model g1 g2] = gener_gauss_2d( Param )
global par x Y


Etha_1 = Param(1);
Etha_2 = Param(2);
par.Alpha_1 = Param(3);
par.Alpha_2 = Param(4);

par.Kapa_1 = Param(5);
par.Kapa_2 = Param(6);

a = Param(7);
b = Param(8);

par.ind_1 = find( x > (Etha_1+par.Alpha_1/par.Kapa_1) );
par.x_1 =  x( par.ind_1 );


par.ind_2 = find( x > (Etha_2+par.Alpha_2/par.Kapa_2) );
par.x_2 =  x( par.ind_2 );

  

g1 = a*gener_gauss_2(par.x_1, par.Mu, par.Variance, par.Alpha_1, par.Kapa_1,  Etha_1 );
g2 = b*gener_gauss_2(par.x_2, par.Mu, par.Variance, par.Alpha_2, par.Kapa_2,  Etha_2 );

Y_model = zeros( size( Y ) );
Y_model(par.ind_1) = g1;
Y_model(par.ind_2) = Y_model(par.ind_2) + g2;


SSR = sum( (Y - Y_model).^2 );





function y = gener_gauss_2(x, Mean, Variance, Alpha, Kapa, Etha )

% if Kapa ~= 0
%     x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );
% else
%     x2 = (1/Alpha)*(x-Etha);
% end
x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );

y = (2*pi*Variance)^-0.5  * exp( -(0.5/Variance)*( x2 - Mean).^2 ) ./...
    ( Alpha - Kapa*(x - Etha) );