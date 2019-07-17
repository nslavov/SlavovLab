

$x = 'http://www.mit.edu/~nslavov/';
$x2 = 'http://web.mit.edu/nslavov/www/';
$y = 'https://alum.mit.edu/www/nslavov/';

$Xa = 'http://www.northeastern.edu';
$Ya = 'https://web.northeastern.edu';


$File_Num=0;     
$Skipped_Files = 0; 
foreach my $file (glob("*.htm*")){ 	++$File_Num;
	
	undef @Lines;
	open IN,  $file;
	while(<IN>){
	
	$_ =~ s/$x|$x2/$y/g;
	
	$_ =~ s/$Xa/$Ya/g;
	push @Lines, $_
	}
	close( IN );
	open OUT,  ">$file";
	foreach ( @Lines ){
	
		print OUT "$_";
	
	}
	close( OUT );
}

