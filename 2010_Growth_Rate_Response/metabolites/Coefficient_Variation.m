%%
load ethanol_metab.mat
%%
load raw_data
%%
Marker = { 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5 }; 
subplot(1,2,1)
for i=1:9
    k = 3*(i-1)+2;
    
    x = log2( dat(:,k) );
    y = log2( dat(:,k+1) );
    
    a = ( x' * y ) / ( x' * x )
    
plot(  a*x, y, Marker{:} ), hold on


% Mean = 0.5*(a*x+y);
% CV = abs(a*x - y)./Mean;
% plot(  Mean, CV, '.' ), hold on 
end
xlim([2 18] )
ylim([2 18] )

set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );
h(1) = xlabel( 'Day 2' );    
h(2) = ylabel( 'Day 3' );   
hh = title( 'Log_2 Raw Level' );
%sett( h, 16 );                                
set(h, 'fontsize', 18, 'FontWeight', 'bold');
set(hh, 'fontsize', 16, 'FontWeight', 'bold');
%


subplot(1,2,2)
for i=1:9
    k = 3*(i-1)+2;
    
    x = log( dat_ref(:,k) );
    y = log( dat_ref(:,k+1) );
    
    a = ( x' * y ) / ( x' * x )
    
plot(  a*x, y, Marker{:} ), hold on


% Mean = 0.5*(a*x+y);
% CV = abs(a*x - y)./Mean;
% plot(  Mean, CV, '.' ), hold on 
end
xlim([-5 5] )
ylim([-5 5] )


set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );
h(1) = xlabel( 'Day 2' );    
h(2) = ylabel( 'Day 3' );   
hh = title( 'Log_2 Fold Change' );
%sett( h, 16 );                                
set(h, 'fontsize', 18, 'FontWeight', 'bold');
set(hh, 'fontsize', 16, 'FontWeight', 'bold');



%%
pdf( 'reproducibility', [9 5] );















