dat = log2(x);
k=1;
%%
dat = reshape( dat(randperm(numel(dat))), size(dat) );
k=2;
%%
gr = [0.05  0.05  0.05   0.025  
      0.1   0.1   0.1    0.059
      0.14  0.14  0.14   0.086 ]; 
  
[sz clm] = size(dat); clm = 3; %clm/3;
sl_ex  = zeros(2,sz); 
sl_pl  = zeros(2,sz);
sl_ln  = zeros(2,sz);
        

r_ex = zeros(sz,clm);
r_pl = zeros(sz,clm);
r_ln = zeros(sz,clm); 
s_ex = zeros(sz,clm);
s_pl = zeros(sz,clm);
s_ln = zeros(sz,clm);

A  =  ones(3,2);      
B  =  ones(3,2);       
 

for Set = 1:clm
    
    A(:,1) = gr(:,Set);         inv_AtA = inv( A' * A );
    B(:,1) = log2( gr(:,Set) ); inv_BtB = inv( B' * B );  
    
    inds = 3*(Set-1)+(1:3); 

    for i=1:sz

        Y =  dat(i,inds)';
        Yl = 2.^Y; 

        sl_ex(:,i) =  inv_AtA * ( A' * Y ); 
        sl_pl(:,i) =  inv_BtB * ( B' * Y );
        sl_ln(:,i) =  inv_AtA * ( A' * Yl );

        Y_var   =   sum( (Y-mean(Y)  ).^2 ); 
        Yl_var  =   sum( (Yl-mean(Yl)  ).^2 );
        r_ex(i,Set) = max(0, 1-sum( (Y-A*sl_ex(:,i)).^2 )/Y_var  );                % R^2 :: coefficient of determination
        r_pl(i,Set) = max(0, 1-sum( (Y-B*sl_pl(:,i)).^2 )/Y_var  ); 
        r_ln(i,Set) = max(0, 1-sum( (Yl-A*sl_ln(:,i)).^2 )/Yl_var);

    end
    s_ex(:,Set) = sl_ex(1,:)';  
    s_pl(:,Set) = sl_pl(1,:)';
    s_ln(:,Set) = sl_ln(1,:)';
    %freq = histc( [r_sq R_sq], l );     
end    
%
rs(:,k) = r_ex(:);
%%
l = linspace( 0, 1, 25 );
freq(:,k) = histc( r_ex(:), l );
%
%bar( l, freq  )
%xlim( [0 1] );

%%
%rs_sort = ( sort( freq ) );

pp( l, cumsum( freq )  );
%%
plot( sort( rs(:,1), 'ascend' ), 'r', 'linewidth', 3.5 ), hold on
plot( sort( rs(:,2), 'ascend' ), 'k', 'linewidth', 3.5 )

set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );

h(1) = xlabel( 'Rank Order' );   
h(2) = ylabel( 'Goodness of Fit, $R^2$' );   
hh = legend( 'Data',  'Randomized Data', 2 );

sett( hh, 16 );           
set( hh, 'box', 'off' );           
sett(h, 20);           
%set(h, 'fontsize', 20, 'FontWeight', 'bold');
%%
pdf( 'Rsq', [8 5], 1 );


















