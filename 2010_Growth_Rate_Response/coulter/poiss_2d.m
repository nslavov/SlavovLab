function [SSR Y_model g1 g2] = poiss_2d( Param )
global x Y


mu_1 = Param(1);
mu_2 = Param(2);
a = Param(3);
b = Param(4);

g1 = a*Poiss(x, mu_1);
g2 = b*Poiss(x, mu_2);

Y_model = g1 + g2;

SSR = sum( (Y - Y_model).^2 );


function y = Poiss(x, lam )

y = ( exp(-lam)*lam.^x./gamma(x) ).^10;

