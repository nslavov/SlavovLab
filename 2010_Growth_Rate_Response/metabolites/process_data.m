%%
path = '/data/grr-2/metabolites/chris/';
n = importdata( [path 'neg.dat' ] );
p = importdata( [path 'pos.dat' ] );

neg = is_normalize( n );
pos = is_normalize( p );
%%
pp( pos.is_all(8,:), pos.is_all(9,:), '.' )
%%


dat = [neg.data_is_nor; pos.data_is_nor];

metab = [neg.meta
         pos.meta ];
%%     
is = reshape( pos.is, [3,11] );
pp(  is, '.-' )
%%
k = 2;
pp( log(ref_1(:,k)), log(ref_2(:,k-1)), '.' );
%%
k = 2;
pp( log(dat(:,k)), log(dat(:,k+1)), '.' ), hold on
%plot( log(dat(:,k)), log(dat(:,k+3*5)), 'r.' )
%%
k = 1;
pp( log(dat_ref(:,k)), log(dat_ref(:,k+2)), '.' ), hold on
plot( log(dat_ref(:,k)), log(dat_ref(:,k+12)), 'r.' )
%%
biomass=[
17.59	12.49	13.19	16.65	12.28	12.85	18.01	3.17	2.04	43.08	46.70
19.75	13.18	4.72	18.95	14.28	11.17	25.62	6.24	9.97	47.62	50.90
19.78	13.47	7.06	19.44	12.67	13.35	27.21	8.68	17.00	46.93	51.08];
i_biomass = 1./ biomass(:)'; 
for i=1:size(dat,2)
    dat(:,i) = dat(:,i) * i_biomass(i); 
end
%%
ref_1  = dat(:,28:30);
ref_2  = dat(:,31:33);
ref = 0.5*(ref_1 + ref_2);

dat_ref = zeros( size(dat) );
x = zeros( size(dat,1), 9 );
cv = zeros( size(dat,1), 9 );
cv = zeros( size(dat,1), 9 );
for i=1:9,
    
     dat_ref(:,(1:3)+3*(i-1)) = dat(:,(1:3)+3*(i-1)) ./ ref ;
     
     x(:,i) = median( dat_ref(:,(1:3)+3*(i-1)),   2);
     
     cv(:,i) = std( dat(:,(2:3)+3*(i-1)), [],   2) ./ ...
               mean( dat(:,(2:3)+3*(i-1)),  2);      
end
hist( cv(:) )
%%
y = nor_mean(log2(x(:,1:9)),2);
CLU = clu( y, 3 ); rg(4)
%%
met = metab(CLU);
for i=1:numel(met)
    fprintf( '%d\t%s\n', i, met{i} );
end
%% Write a pcl File

DATA = log2( x(CLU,:) );

fid = fopen( [path 'ethanol_grr_met.pcl' ], 'w' );

fprintf(fid, 'NAME\tNAME\tGWEIGHT' );
fprintf(fid, '\t%s', 'e1', 'e2', 'e3', ' ',...
                     'n1', 'n2', 'n3', ' ',...
                     'p1', 'p2', 'p3' );
fprintf(fid, '\n' );                 
fprintf(fid, 'EWEIGHT\t\t' );
fprintf(fid, '\t%d', ones(9+2,1) );
fprintf(fid, '\n' );

for i=1:numel(met) 

    fprintf(fid, '%s\t%s\t%d\t', met{i}, met{i}, 1 );
    
    fprintf(fid, '%1.2f\t',  DATA(i,1:3) );
    fprintf(fid, '\t' );
    fprintf(fid, '%1.2f\t',  DATA(i,4:6) );
    fprintf(fid, '\t%1.2f',  DATA(i,7:9) );
    fprintf(fid, '\n' );

end
fclose(fid);
%%



































