

$x = 'http://www.mit.edu/~nslavov/';
$x2 = 'http://web.mit.edu/nslavov/www/';
$y = 'http://alum.mit.edu/www/nslavov/';

$x = 'http://www.northeastern.edu';
$x2 = 'http://alum.mit.edu/www/';
$y = 'https://web.northeastern.edu';

$x = 'http://slavovlab.net/';
$y = 'https://slavovlab.net/';


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
