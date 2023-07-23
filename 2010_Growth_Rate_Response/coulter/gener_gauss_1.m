function y = gener_gauss_1(x, Mean, Alpha, Beta )



y = (Beta/(2*Alpha*gamma(1/Beta)) )*...
    exp( -((1/Alpha)*abs( x - Mean)).^Beta );
