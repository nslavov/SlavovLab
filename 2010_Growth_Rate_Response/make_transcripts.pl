open( OUT,   '>transcripts.html' );

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
<tr><td height="30" colspan="2"><div class="Header_Text"> <a href="index.html"> Transcriptional Growth Rate Response</a></div></td></tr>\
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
<a href="http://princeton.edu/~nslavov/meta/ATP.html" target="_blank">Linking Metabolites and Transcripts</a> <br> 
<a href="nets.html" target="_blank">Bio Nets</a>
<a href="http://genomics.princeton.edu/~nslavov/grr_html/Quantify_GRR_by_Function.html" target="_blank">GRR by Function</a> 
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
     <param name="cdtName" value="Transcripts">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET>
<!--
 <APPLET
      code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"
      archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"
      width="200"
      height="40"
      alt="Your browser understands the &lt;APPLET&gt; tag but isn't
      running the applet, for some reason."
>
      Your browser is completely ignoring the &lt;APPLET&gt; tag!
     <param name="cdtFile" value="ethanol_grr_met.pcl">
     <param name="cdtName" value="Metabolites">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET>
-->
 <APPLET
      code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"
      archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"
      width="200"
      height="40"
      alt="Your browser understands the &lt;APPLET&gt; tag but isn't
      running the applet, for some reason."
>
      Your browser is completely ignoring the &lt;APPLET&gt; tag!
     <param name="cdtFile" value="jtv/eth_glu.cdt">
     <param name="cdtName" value="Eth & Glu">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET>
 <APPLET
      code="edu/stanford/genetics/treeview/applet/ButtonApplet.class"
      archive="TreeView-1.1.3-applet/TreeViewApplet.jar,TreeView-1.1.3-applet/nanoxml-2.2.2.jar,TreeView-1.1.3-applet/plugins/Dendrogram.jar"
      width="200"
      height="40"
      alt="Your browser understands the &lt;APPLET&gt; tag but isn't
      running the applet, for some reason."
>
      Your browser is completely ignoring the &lt;APPLET&gt; tag!
     <param name="cdtFile" value="jtv/allSlopesFldChng.cdt">
     <param name="cdtName" value="Slopes">
     <param name="plugins" value="edu.stanford.genetics.treeview.plugin.dendroview.DendrogramFactory">
</APPLET>
</div>
</td>
<!-- ============ Content Column ============== -->
<td class="Content">
<!-- ============ Page Heading ============== -->
<h1 class="HeadingStyle">Reference Conversion. Reproducibility</h1>
	 <table>
	 <tr><td>
     <a href="Images/corr_1_2.pdf" target="_blank">
         <img src="Images/corr_1_2.png"
         style="width: 90px; height: 90px;" > </img>
     </a>
	 <td>
     <a href="Images/corr_1_3.pdf" target="_blank">
         <img src="Images/corr_2_3.png"
         style="width: 90px; height: 90px;" > </img>
     </a>
	 <td>
     <a href="Images/corr_1_4.pdf" target="_blank">
         <img src="Images/corr_2_3.png"
         style="width: 90px; height: 90px;" > </img>
     </a>
	 <td>
     <a href="Images/corr_2_3.pdf" target="_blank">
         <img src="Images/corr_2_3.png"
         style="width: 90px; height: 90px;" > </img>
     </a>
	 <td>
     <a href="Images/corr_3_4.pdf" target="_blank">
         <img src="Images/corr_2_3.png"
         style="width: 90px; height: 90px;" > </img>
     </a>	 
	 </tr>
	 </table>
	 
<h1 class="HeadingStyle">Scatter Plots of GRR Exponents/Slopes</h1>
Below is an array of interactive scatter plots. Each plot corresponds to a set of conditions defined by the carbon sources (CS) and the limiting  nutrients (Lim) indicated on the top and left.
For each set of conditions (plot), the genes whose expression levels are explained well by an exponential <a href="model.html" Title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Model Description] body=[ 
The model explains the measured levels of gene expresion as an exponential function of the growth rate plus a gene specific constant. The exponents (slopes in semi-log space) capture the change in gene epression
with growth rate.]">model</a> are depicted as black circles.
In the corner of each quadrant there are two links characterizing the set of genes whose exponents reside in the quadrant, set A:  
<ol>
	<li> Red: significantly enriched GO terms for gene set A; 
	<li> Green: transcription factors (TFs) likely  to regulate genes from set A as determined by the significance of the overlap between  gene set A and ChIP-on-chip determined TF targets.
</ol>
<tr>
<td colspan="2"  width="100%" > <br><br>
<h1 class="HeadingStyle"  align="center"> Natural Limitations on Glucose and Ethanol Carbon Source</h1>
TEXT

print OUT "$text\n";

$td = 'width="95%" align="center"';
$td_label = 'style="text-align:center; vertical-align:middle"  width="80"    ';

print OUT "<table ><tr> <td></td>\n";

@CS = (   '0',  'Eth',   'Eth',   'Eth',  'Glu',   'Glu',  'Glu',   'Glu',   'Glu',  'Glu'  );
@Lim = (   '0',  'Eth', 'N', 'Phos',  	 'Glu', 'N', 'Phos',  'Sul', 'Leu',    'Ura'  ) ;  


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
	 
	 $thum =  '<image src="Scatters/thumbnails/fn_lims_'  .  $i . '_'  .  $j   .  '.png"'   .   $td  .  '>'; 
	 $link = '"Scatters/lims_'  . $i  .  '_'  .  $j . '.html"'  .  'target="_blank"';
	 
	 printf OUT "<td width=\"130\"  >  <a href=$link  >  $thum  </a>   </td> \n",  		$link, 	  $td;
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
		print OUT "<td  > </td>\n";
	}
   	for( $j=$i+1; $j<=9; ++$j){
	 #printf OUT "<td  %s  background=\"thumbnails/fn_lims_%d_%d.png\" > %d </td> \n",  $td, $i, $j, $j;
	 
	 $thum =  '<image src="Scatters/thumbnails/fn_lims_'  .  $i . '_'  .  $j   .  '.png"'   .   $td  .  '>'; 
	 $link = '"Scatters/lims_'  . $i  .  '_'  .  $j . '.html"'  .  'target="_blank"';
	 
	 printf OUT "<td  >  <a href=$link  >  $thum  </a>   </td> \n",  		$link, 	  $td;
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

