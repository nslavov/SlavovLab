#@All_Files = <"$ARGV[0]/*">;
#foreach ( @All_Files ) {

mkdir hist;
foreach my $file (glob("*=*")){ 

	open( IN, $file );
		@file_name = split /\./, $file;
	open( OUT, ">hist/$file_name[0]" );
	
	
	while( <IN> ){
		last if  $_  =~  m/^\[\#Bindiam\]/; 	
	}
	while( <IN> ){
		chomp;
		$_ =~  s/\r\n|\r|\n//g;
		last if  $_  =~  m/^\[Binunits\]/;	
		push @Bins, $_;  
	}
	$_ = <IN>; 
	$_ = <IN>;
					  $i=-1;
	while( <IN> ){  $i++;
		chomp;
		$_ =~  s/\r\n|\r|\n//g;
		last if  $_  =~  m/^\[end\]/;  
		print  OUT "$Bins[$i]\t$_\n";
	}
}
