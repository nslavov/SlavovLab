function [SSR Y_model g1 g2] = gener_gauss_normal( Param )
global par x Y


Etha_1 = Param(1);
par.Mu_2 = Param(2);

par.Alpha_1 = Param(3);
par.Var_2 = Param(4);

a = Param(5);
b = Param(6);

par.ind_1 = find( x > (Etha_1+par.Alpha_1/par.Kapa) );
par.x_1 =  x( par.ind_1 );



g1 = a*gener_gauss_2(par.x_1, par.Mu, par.Variance, par.Alpha_1, par.Kapa,  Etha_1 );
g2 = b*normpdf(x, par.Mu_2, par.Var_2 );

Y_model = g2;
Y_model(par.ind_1) = Y_model(par.ind_1) + g1;


SSR = sum( (Y - Y_model).^2 );





% function y = gener_gauss_2(x, Mean, Variance, Alpha, Kapa, Etha )
% 
% % if Kapa ~= 0
% %     x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );
% % else
% %     x2 = (1/Alpha)*(x-Etha);
% % end
% x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );
% 
% y = (2*pi*Variance)^-0.5  * exp( -(0.5/Variance)*( x2 - Mean).^2 ) ./...
%     ( Alpha - Kapa*(x - Etha) );