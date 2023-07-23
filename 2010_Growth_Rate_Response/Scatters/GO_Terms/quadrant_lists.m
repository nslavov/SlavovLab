%%
load /mlab/gr-rate/slavov_brauer_slopes_Rsq.mat
%%
SL = 1;
RS = 0.5;
TF = cell( 9, 9 );
for i=1:9
    for j=i+1:9
        
        fprintf( 'Iter: %d :: %d\n', i, j );
        
        Dir = sprintf( 'go_%d_%d/', i, j );
        
        
        in{1} = find (  sl(:,i)>= SL & sl(:,j)>= SL & rs(:,i)>=RS &  rs(:,j)>=RS   );
        in{2} = find (  sl(:,i)<=-SL & sl(:,j)>= SL & rs(:,i)>=RS &  rs(:,j)>=RS   );
        in{3} = find (  sl(:,i)<=-SL & sl(:,j)<=-SL & rs(:,i)>=RS &  rs(:,j)>=RS   );
        in{4} = find (  sl(:,i)>= SL & sl(:,j)<=-SL & rs(:,i)>=RS &  rs(:,j)>=RS   );
        
        
        for k=1:4
            Ynames = Common_Annot(in{k},1);        
            Snames = Common_Annot(in{k},2);
            
            Y_File = [ Dir num2str(k) '_Y.txt' ];
            S_File = [ Dir num2str(k) '_S.txt' ];
            
            %delete Y_File
            %delete S_File
            
            fid = fopen( Y_File, 'w' );
                fprintf( fid, '%s\n', Ynames{:} );
            fclose(fid);
            
            fid = fopen( S_File, 'w' );
                fprintf( fid, '%s\n', Snames{:} );
            fclose(fid);
            
            TF{i,j}{k} = perl( '/perl/GR/TF_targets.pl', Y_File );
        end
        
    end
end


save( 'TFs', 'TF' );