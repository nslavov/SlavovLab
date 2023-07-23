open( OUT,   '>index.html' );

$text = <<TEXT;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title> Nikolai Slavov : Lewis-Sigler Institute for Integrative Genomics : Princeton</title>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="http://princeton.edu/~nslavov/bin/nslavov_index_.css"  >
<link rel="stylesheet" type="text/css" href="main.css"  >
</head>
<body>
<table class="Global" cellpadding="0" cellspacing="0" border="0">
<!-- ============ Logo ============== -->
<tr><td height="30" colspan="2"><div class="Header_Text"> <a href="About_Me.htm"> Growth Rate Response</a></div></td></tr>\
<tr><td height="150" colspan="2">
<!-- ============ Header Image ============== -->
<table class="Header_Image" cellspacing="0" border="0"><tr>
<td width="100%" align="left"  background="http://princeton.edu/~nslavov/index_files/Niteorig-5.jpg" > </td>
<!-- or add to the style sheet:	     background: url('Niteorig-5.jpg') no-repeat; -->
</tr></table>
</td></tr>
<!-- ============ COLUMNS SECTION ============== -->
<tr>
<!-- ============ Menu Column ============== -->
<td class="MenuColTD" align="center">
<!-- ============ Site Menu ============== -->
<div class="Menu">
<a href="index.htm">Home</a>
<a href="http://genomics.princeton.edu/~nslavov/research.htm">Research Home</a>
<a href="About_Me.htm">Experimental Design</a>
<a href="photos.htm">Physiology </a>
<a href="index.htm">GRR Slopes </a>
<a href="Links.htm">Linking Metabolites and Transcripts</a>
<br>
<a href="About_Me.htm">Contact</a>
<!--
 <APPLET
      code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"
      archive="/treeview/TreeView-1.1.0-applet/TreeViewApplet.jar,/treeview/TreeView-1.1.0-applet/nanoxml-2.2.2.jar,/treeview/TreeView-1.1.0-applet/plugins/Dendrogram.jar"
      width="200"
      height="40"
      alt="Your browser understands the &lt;APPLET&gt; tag but isn't
      running the applet, for some reason."
>
      Your browser is completely ignoring the &lt;APPLET&gt; tag!
     <param name="cdtFile" value="http://growthrate.princeton.edu/data/dilution_rate_00_raw.cdt">
     <param name="cdtName" value="Dilution Rate (raw)">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET
-->
</div>
</td>
<!-- ============ Content Column ============== -->
<td class="Content">
<!-- ============ Page Heading ============== -->
<h1 class="HeadingStyle">Scatter Plots</h1>
blah blah
</td><tr>
<td colspan="2"  width="100%" > <br><br>
<h1 class="HeadingStyle"  align="center"> Natural Limitations on Glucose and Ethanol Carbon Source</h1>
TEXT

print OUT "$text\n";

$td = 'width="100%" align="center"';
$td_label = 'style="text-align:center; vertical-align:middle"  width="80"    ';

print OUT "<table><tr> <td></td>\n";

@CS = (   '0',  'Eth',   'Eth',   'Eth',  'Glu',   'Glu',  'Glu',   'Glu',   'Glu',  'Glu'  );
@Lim = (   '0',  'Eth', 'N', 'Phos',  	 'Glu', 'N', 'Phos',  'Sul', 'Lue',    'Ura'  ) ;  


for( $i=2; $i<=6; ++$i){
	printf OUT "<td  %s>  <br> CS:  <b>%s </b> <br> Lim: <i>%s</i></td>\n",  $td_label,  $CS[$i],   $Lim[$i];
}

for( $i=1; $i<=6; ++$i){

	 print OUT "<tr >\n";
	 
	 if ( $i < 6 ){
	printf OUT "<td  %s>  CS:  <b>%s </b> <br> Lim: <i>%s</i></td>\n",  $td_label,  $CS[$i],   $Lim[$i];
	}
	for( $j=2; $j<=$i; ++$j){
		print OUT "<td> </td>\n";
	}
   	for( $j=$i+1; $j<=6; ++$j){
	 #printf OUT "<td  %s  background=\"thumbnails/fn_lims_%d_%d.png\" > %d </td> \n",  $td, $i, $j, $j;
	 
	 $thum =  '<image src="thumbnails/fn_lims_'  .  $i . '_'  .  $j   .  '.png"'   .   $td  .  '>'; 
	 $link = '"lims_'  . $i  .  '_'  .  $j . '.html"'  .  'target="_blank"';
	 
	 printf OUT "<td >  <a href=$link  >  $thum  </a>   </td> \n",  		$link, 	  $td;
	}
	
}

print OUT "</table> <br><br>\n";
print OUT "<h1 class=\"HeadingStyle\"  align=\"center\" >All Limitations</h1>\n";
print OUT "<table><tr> <td></td>\n";


for( $i=2; $i<=9; ++$i){
	printf OUT "<td  %s>  <br> CS:  <b>%s </b> <br> Lim: <i>%s</i></td>\n",  $td_label,  $CS[$i],   $Lim[$i];
}

for( $i=1; $i<=9; ++$i){

	 print OUT "<tr >\n";
	 
	 if ( $i < 9 ){
	printf OUT "<td  %s>  CS:  <b>%s </b> <br> Lim: <i>%s</i></td>\n",  $td_label,  $CS[$i],   $Lim[$i];
	}
	for( $j=2; $j<=$i; ++$j){
		print OUT "<td> </td>\n";
	}
   	for( $j=$i+1; $j<=9; ++$j){
	 #printf OUT "<td  %s  background=\"thumbnails/fn_lims_%d_%d.png\" > %d </td> \n",  $td, $i, $j, $j;
	 
	 $thum =  '<image src="thumbnails/fn_lims_'  .  $i . '_'  .  $j   .  '.png"'   .   $td  .  '>'; 
	 $link = '"lims_'  . $i  .  '_'  .  $j . '.html"'  .  'target="_blank"';
	 
	 printf OUT "<td >  <a href=$link  >  $thum  </a>   </td> \n",  		$link, 	  $td;
	}
	
}





$text = <<TEXT;
</td></tr></table> 
<!-- ============ Footer ============== -->
<tr><td colspan="2" class="Footer">
<div class="FooterWrap">
<div class="Copyright">Copyright &copy; <a href="About_Me.htm"> Nikolai Slavov  </a></div>
</div>
</td></tr></table>
</body>
</html>
TEXT
print OUT "$text\n";



$text = <<TEXT;
<table class="Header_Image" cellspacing="0" border="0"><tr>
<td width="100%" align="left"  background="http://princeton.edu/~nslavov/index_files/Niteorig-5.jpg" > </td>
<!-- or add to the style sheet:	     background: url('Niteorig-5.jpg') no-repeat; -->
</tr></table>
</td></tr>
<tr>
<!-- ============ Menu Column ============== -->
<td class="MenuColTD" align="center">
<!-- ============ Site Menu ============== -->
<div class="Menu">
<a href="http://genomics.princeton.edu/~nslavov/research.htm">Research</a>
<a href="http://genomics.princeton.edu/~nslavov/Links.htm">Links</a>
</div>
</td>
<!-- ============ Content Column ============== -->
<td class="Content">
<!-- ============ Page Heading ============== -->
<h1 class="HeadingStyle">Scatter Plots</h1>
TEXT

