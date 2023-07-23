%%
pump = [ 1/32  1/16   1/12   1/8 ];
grr  = [ .029  .058   .074   .112];

[a b] = linFit( pump(:), grr(:) );


%%
% assuming the intercept b equals zero, the pump setting giving a dilution
% rate 0.05 is:


frac = 0.05/a;

expected_dilution_rate  = a * (1/18) * ( 320/310 )