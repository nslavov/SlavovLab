function y = is_normalize( data_text, Sample_Number)


metab = data_text.textdata(2:end,1);
data = data_text.data;

if nargin<3,
    Sample_Number=3;
end
%%
START = 1 + 2*Sample_Number + 1;

ind = find( data(:,1) == 1 );

metab = metab(ind,:);
data = data(ind,:);

is_in=[];
in=[];
for i=1:numel(metab)
    if  findstr( metab{i}, 'C13' ); 
        is_in=[is_in i]; 
        fprintf( '%s\n', metab{i}); 
    else
        in=[in i];
    end   
end  
%%
y.is_all = data(is_in, START:end);
y.is = sum( y.is_all, 1);
y.is =  y.is * ( numel(y.is)/sum(y.is) );

y.data = data(in, START:end);
y.meta = metab(in,:);
y.data_is_nor = zeros( size( y.data ) );

for i=1:size( y.data, 2 )
    
    y.data_is_nor(:,i) = y.data(:,i) * (1/y.is(i)); 
    
end
    

