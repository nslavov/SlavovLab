open( OUT,   '>cell_sizes.html' );

$text = <<TEXT;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title> Nikolai Slavov : Lewis-Sigler Institute for Integrative Genomics : Princeton</title>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<SCRIPT SRC="http://www.princeton.edu/~nslavov/bin/boxover2/boxover.js"></SCRIPT>
<LINK rel="stylesheet" href="http://www.princeton.edu/~nslavov/bin/boxover2/my.css" type="text/css">

<link rel="shortcut icon" href="http://www.princeton.edu/~nslavov/index_files/icons/Starred.ico">
<link rel="stylesheet" type="text/css" href="http://princeton.edu/~nslavov/bin/nslavov_index_.css"  >
<link rel="stylesheet" type="text/css" href="main.css"  >
</head>
<body>
<table class="Global" cellpadding="0" cellspacing="0" border="0">
<!-- ============ Logo ============== -->
<tr><td height="30" colspan="2"><div class="Header_Text"> <a href="cell_sizes.html"> Cell Size & Budding</a></div></td></tr>\
<tr><td height="150" colspan="2">
<!-- ============ Header Image ============== -->
<table class="Header_Image" cellspacing="0" border="0"><tr>
<td> <img  src="growth_rate_response.png"  width="100%" align="left"  > </td>
<!-- or add to the style sheet:	     background: url('Niteorig-5.jpg') no-repeat; -->
</tr></table>
</td></tr>
<!-- ============ COLUMNS SECTION ============== -->
<tr>
<!-- ============ Menu Column ============== -->
<td class="MenuColTD" align="center">
<!-- ============ Site Menu ============== -->
<div class="Menu">
<a href="http://genomics.princeton.edu/~nslavov/research.htm">Research Home</a>
<a href="transcripts.html">GRR Home</a>
<a href="Experimental_Design.html">Experimental Design</a>
<a href="physiology.html">Physiology </a> 
<a href="cell_sizes.html">Cell Sizes & Budding </a>  
<a href="transcripts.html">Transcripts </a>
<a href="metabolites.html">Metabolites </a>
<a href="cell_division/index.html">Cell Division </a> 
<a href="http://princeton.edu/~nslavov/meta/ATP.html" target="_blank">Linking Metabolites and Transcripts</a>
<a href="nets.html" target="_blank">Bio Nets</a>
<br>
<a href="../About_Me.htm">Contact</a>
<br><br>
 <APPLET
      code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"
      archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"
      width="200"
      height="40"
      alt="Your browser understands the &lt;APPLET&gt; tag but isn't
      running the applet, for some reason."
>
      Your browser is completely ignoring the &lt;APPLET&gt; tag!
     <param name="cdtFile" value="ethanol_grr.cdt">
     <param name="cdtName" value="GRR in Ethanol">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET>
</div>
</td>
<!-- ============ Content Column ============== -->
<td class="Content">
<!-- ============ Page Heading ============== -->
<h1 class="HeadingStyle">Cells Sizes</h1>
Distributions of cell sizes were measured 3 times a day for each limitation and growth rate using a Coulter counter. On the reproducibility plots below (figure 1) each measurement is
plotted in red and the mean of all measurements for a condition in black. At the highest growth rates (0.14), the cell count per unit volume was small, and thus the distributions are more noisy. 
The distribution of cell sizes for each condition (limitation and growth rate) was modeled as a mixture of two 
<a href="http://en.wikipedia.org/wiki/Generalized_normal_distribution"  target="_blank" 
 Title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Normal distributions  was inadequate to explain the data because of the skew] body=[
 This is a family of continuous probability distributions in which the shape parameter can be used to introduce skew.
 When the shape parameter is zero, the normal distribution results. Positive values of the shape parameter yield left-skewed distributions bounded to the right, 
 and negative values of the shape parameter yield right-skewed distributions bounded to the left. Only when the shape parameter is zero is the density function 
 for this distribution positive over the whole real line: in this case the distribution is a normal distribution, otherwise the distributions are shifted and possibly reversed log-normal distributions.]">
 <i>generalized</i> Gaussian distributions</a>
 with the idea that the distribution with smaller mean corresponds to unbudded cells and the distribution with larger mean corresponds to budded cells.
 The decomposed distributions are plotted below (figure 2 and 4) together with the fraction of budded cells inferred  from the distributions
of cell sizes.  
</td><tr>
<td colspan="2"  width="100%" > <br><br>
<h1 class="HeadingStyle"  align="center"> Reproducibility </h1>
TEXT

print OUT "$text\n";

$td =  'width="220" align="center"';
$td_label = 'style="text-align:center; vertical-align:middle"  width="10"    ';

@Lim = (   ' ',   'Ethanol', 'Nitrogen',  'Phosphate',   );
@GR = (   '0',  '0.05', '0.10', '0.14'  ) ;  

print OUT "<table  width=\"100%\"  ><tr> <td></td>\n";

for( $i=1; $i<=3; ++$i){
	printf OUT "<td  %s>  <b> %s </b> </td>\n",   $td,    $GR[$i];
}

for( $i=1; $i<=3; ++$i){

	 print OUT "<tr >\n";
	 printf OUT "<td  %s> <b>%s</b> </td>\n",    $td_label ,  $Lim[$i];
	 
   	for( $j=1; $j<=3; ++$j){
	 ++$k;
	 $thum =  '<image src="coulter/grr-3/hist_img/cc_'  .  $k   .  '.png"'   .   $td  .  '>'; 
	 $link = '"coulter/grr-3/hist_img/cc_'  .  $k   .  '.pdf"'  .  'target="_blank"';
	 
	 print  OUT "<td width=\"230\"  >  <a href=$link  >  $thum  </a>   </td> \n"; 		#$link, 	  $td;
	}
	
}

print OUT "</table> <br><br>\n";
print OUT "<h1 class=\"HeadingStyle\"  align=\"center\" >Budded Fraction</h1>\n";  	$k=0;
print OUT "<table><tr> <td></td>\n";


for( $i=1; $i<=3; ++$i){
	printf OUT "<td  %s>  <b> %s </b> </td>\n",   $td,    $GR[$i];
}

for( $i=1; $i<=3; ++$i){

	 print OUT "<tr >\n";
	 printf OUT "<td  %s> <b>%s</b> </td>\n",    $td_label ,  $Lim[$i];
	 
   	for( $j=1; $j<=3; ++$j){
	 ++$k;
	 $thum =  '<image src="coulter/grr-3/hist_img_decomp_gener/cc_'  .  $k   .  '.png"'   .   $td  .  '>'; 
	 $link = '"coulter/grr-3/hist_img_decomp_gener/cc_'  .  $k   .  '.pdf"'  .  'target="_blank"';
	 
	 print  OUT "<td width=\"230\"  >  <a href=$link  >  $thum  </a>   </td> \n"; 		#$link, 	  $td;
	}
	
}
print OUT "</tr></table>   <br>  ";
print OUT "<h1 class=\"HeadingStyle\"  align=\"center\" >Correspondence  between manual and automated budding fraction</h1>\n"; 

$text = <<TEXT;
<table >
 <tr>
 <td width="50"> </td>
 <td class="width:100%"   align="center">  
     <a href="coulter/grr-3/hist_img_decomp_gener/Manual_vs_CoulterCounter.pdf" target="_blank">
         <img src="coulter/grr-3/hist_img_decomp_gener/Manual_vs_CoulterCounter.png"
         width="660px" ALIGN=MIDDLE> </img>
     </a>
 </td>
 </tr>
 </table >
TEXT
print  OUT  "$text \n";




print OUT "<h1 class=\"HeadingStyle\"  align=\"center\" >Better Fit</h1>\n";  	$k=0;
print OUT "<table><tr> <td></td>\n";


for( $i=1; $i<=3; ++$i){
	printf OUT "<td  %s>  <b> %s </b> </td>\n",   $td,    $GR[$i];
}

for( $i=1; $i<=3; ++$i){

	 print OUT "<tr >\n";
	 printf OUT "<td  %s> <b>%s</b> </td>\n",    $td_label ,  $Lim[$i];
	 
   	for( $j=1; $j<=3; ++$j){
	 ++$k;
	 $thum =  '<image src="coulter/grr-3/hist_img_decomp_gener_2/cc_'  .  $k   .  '.png"'   .   $td  .  '>'; 
	 $link = '"coulter/grr-3/hist_img_decomp_gener_2/cc_'  .  $k   .  '.pdf"'  .  'target="_blank"';
	 
	 print  OUT "<td width=\"230\"  >  <a href=$link  >  $thum  </a>   </td> \n"; 		#$link, 	  $td;
	}
	
}
print OUT "</tr></table>";






$text = <<TEXT; 
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

