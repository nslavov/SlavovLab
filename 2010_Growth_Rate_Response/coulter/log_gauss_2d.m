function [SSR Y_model g1 g2] = log_gauss_2d( Param )
global x Y


mu_1 = Param(1);
mu_2 = Param(2);
var_1 = Param(3);
var_2 = Param(4);
a = Param(5);
b = Param(6);

%g1 = a*normpdf(x, mu_1, var_1);
%g2 = b*normpdf(x, mu_2, var_2);

g1 = a*normpdf(log(x), log(mu_1), var_1);
g2 = b*normpdf(log(x), log(mu_2), var_2);

Y_model = g1 + g2;

SSR = sum( (Y - Y_model).^2 );