function y = cell_mean( x )



[row col] = size( x );
N = size( x{1,1}, 1 );

y = zeros( N,  row ); 

for i=1:row
    
    temp = zeros(N,1);
    
    for j=1:col
        
       if isempty( x{i,j} ), j=j-1; break; end 
        
       temp = temp + x{i,j}(:,2);
       
    end
    
    y(:,i) = temp * (1/j); 
end 
