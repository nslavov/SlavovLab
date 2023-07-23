function  Annot = getFun( x, Name_Type )


if nargin==1, Name_Type=1; end

persistent sgd_annot

if numel( sgd_annot ) < 1e3 %  ~exist( 'sgd_annot', 'var' )
    load sgd_annot
end 


ind = strmatch( x,  sgd_annot(:, Name_Type ) );

if ~isempty(ind)
    Annot = sgd_annot( ind, : );
else
    Annot = cell(1,4);
end


%%
% for i=1:size(sgd_annot,1),
%     
%     if isempty( sgd_annot{i,1} )
%         
%          sgd_annot(i,1) = sgd_annot(i,2);
%     end
% end
        