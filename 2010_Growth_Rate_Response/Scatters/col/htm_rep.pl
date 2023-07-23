

$x = 'http://www.princeton.edu/~nslavov/';
#$y = 'http://www.mit.edu/~nslavov/';
$y = 'http://alum.mit.edu/www/nslavov/';


$File_Num=0;     
$Skipped_Files = 0; 
foreach my $file (glob("*.html")){ 	++$File_Num;
	
	undef @Lines;
	open IN,  $file;
	while(<IN>){
	
	$_ =~ s/$x/$y/g;
	push @Lines, $_
	}
	close( IN );
	open OUT,  ">$file";
	foreach ( @Lines ){
	
		print OUT "$_";
	
	}
	close( OUT );
}

