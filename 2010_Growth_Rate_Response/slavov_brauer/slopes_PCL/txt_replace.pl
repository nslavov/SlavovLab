$x = 'http://genomics.princeton.edu/~nslavov/grr_html/brauer_eth/HEADER.html';
#$x = 'http://www.yeastgenome.org/cgi-bin/locus.fpl?locus=HEADER';
$y = 'http://www.yeastgenome.org/cgi-bin/locus.fpl?locus=HEADER';

$File_Num=0;     
$Skipped_Files = 0; 
foreach my $file (glob("*.jtv")){ 	++$File_Num;
	
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

