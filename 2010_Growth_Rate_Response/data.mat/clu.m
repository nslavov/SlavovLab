function [inds r] = clu ( x, TYPE )



if nargin < 2,                      TYPE =  'corr';    end   

switch TYPE
    case { 'corr', 1},              Type =  'correlation';         TYPE = 'corr';

    case { 'euc',  2},              Type =  'euclidean distance';  TYPE = 'euc';
        
    case { 'cos',  3},              Type =  'Unnormalized Correlation';  TYPE = 'cosine';
end

fprintf( 'I will use %s as a similarity measure ... \n' ,  Type );
%%


dist_n          =   pdist( x,             TYPE       );  

Clust_Tree_n    =   linkage( dist_n,     'average'   );

%fig
[ H T inds ]    =   dendrogram (Clust_Tree_n, 0);        clear  H T Clust_Tree_n;


[row clm] = size( x );

if    row == clm,        r = x( inds, inds );
else                     r = x( inds,  :   );   
end 
%%

imagesc( r );                colormap( redgreencmap ); colorbar 
 
% Lim = input( 'Please, Pass Me a Limit (the default is [-1 1]):  ' );
% 
% if isempty(Lim), Lim = 1; end 
% 
% 
% set( gca, 'CLim', [-Lim Lim] );













