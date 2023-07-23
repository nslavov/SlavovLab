Mu = 0;
Variance=.02;
Alpha=5;
Kapa=-4; 
Etha=3; 

if Kapa > 0
    x = -20:0.1: Etha+Alpha/Kapa;
elseif  Kapa == 0
    x = -10 : .1 : 10;
else
   x =  Etha+Alpha/Kapa : .01 : 10;
end
    

y = gener_gauss_2(x, Mu, Variance, Alpha, Kapa, Etha  );

pp( x, y, 'k.', x,y, 'r-' )
%%
Mu = 0;
Variance=.02;
Alpha=2;
Kapa=-4; 
Etha=2;

 
for i=1:10

Etha = 2+i*0.1;
x =  Etha+Alpha/Kapa : .01 : 10;
    
y = gener_gauss_2(x, Mu, Variance, Alpha, Kapa,  Etha );

plot( x,y, 'r-' ), hold on %  x, y, 'k.',
end
%%
Mean = 1;
Alpha = 2;
Variance = Alpha^2/2;
Beta = 9;
y = gener_gauss_1(x, Mean, Alpha, Beta );
yg = (2*pi*Variance)^-0.5  * exp( -(0.5/Variance)*( x - Mean).^2 );

pp( x, y, 'k' ), hold on
plot( x, yg, 'r.' ),
plot( x, normpdf(x, Mean, Variance^0.5), 'go', 'MarkerSize', 8 ),


%%
x = 0 : .1 : 6;
pp( x, lognpdf( x-2, 0, .31 ) )
%%
x = 0 : .1 : 6;
pp( x, normpdf( log(x)-.5, log(1), .31 )  )
%%
x = 0 : .1 : 16; lam=2;
y=exp(-lam)*lam.^x./gamma(x);
pp( x,  y.^10   ),  grid minor





































