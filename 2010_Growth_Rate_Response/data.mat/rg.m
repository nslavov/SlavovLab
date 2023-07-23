function rg(Lim)


colormap( redgreencmap );

colorbar

if nargin < 1 
                %Lim = input( 'Please, Pass Me a Limit:  ' );
  return
end

switch numel(Lim)        
    case 1, set( gca, 'CLim', [-Lim Lim] );

    case 2, set( gca, 'CLim', [Lim(1) Lim(2)] );
end          