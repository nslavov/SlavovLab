function y = gener_gauss_2(x, Mean, Variance, Alpha, Kapa, Etha )

if Kapa ~= 0
    x2 = (-1/Kapa)*log( 1- (Kapa/Alpha)*(x-Etha) );
else
    x2 = (1/Alpha)*(x-Etha);
end

y = (2*pi*Variance)^-0.5  * exp( -(0.5/Variance)*( x2 - Mean).^2 ) ./...
    ( Alpha - Kapa*(x - Etha) );
