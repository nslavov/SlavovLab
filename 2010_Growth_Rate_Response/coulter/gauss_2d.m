function [SSR Y_model g1 g2] = gauss_2d( Param )
global x Y


mu_1 = Param(1);
mu_2 = Param(2);
var_1 = Param(3);
var_2 = Param(4);
a = Param(5);
b = Param(6);

g1 = a*(2*pi*var_1)^-0.5  * exp( -(0.5/var_1)*( x - mu_1).^2 );
g2 = b*(2*pi*var_2)^-0.5  * exp( -(0.5/var_2)*( x - mu_2).^2 );
%g2 = b*gener_gauss_2(x, mu_2, var_2,   Param(7),  Param(8), Param(9) );

Y_model = g1 + g2;

SSR = sum( (Y - Y_model).^2 );


function y = gener_gauss_2(x, Mean, Variance, Alpha, Kapa, Etha )

if Kapa ~= 0
    x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );
else
    x2 = (1/Alpha)*(x-Etha);
end

y = (2*pi*Variance)^-0.5  * exp( -(0.5/Variance)*( x2 - Mean).^2 ) ./...
    ( Alpha - Kapa*(x - Etha) );


