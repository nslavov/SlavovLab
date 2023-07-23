function makemap_grr(fig, filename, Title, JSaddress)
%MAKEMAP Creates a clickable imagemap.
%    MAKEMAP(FIG,FILENAME) creates two files FILENAME.html and FILENAME.png
%    which are clickable imagemaps of the figure FIG.  FIG defaults to gcf and
%    FILENAME defaults to "map".
%
%    Empty text objects mark the hotspots on the imagemap.  Set their 'tag' to
%    be 'click' and their UserData to a structure with two fields, "url" and
%    "description".  These fields specify the target of the click and the "alt"
%    text of the link respectively.  Newer browsers render the "alt" text as a
%    tooltip.
%
%
%    Example:
%
%    % Create some random data.
%    x = rand(10,1);
%    y = rand(10,1);
%    plot(x,y,'.');
%
%    % Create the text labels to use as markers for where to put the hot zones.
%    for i = 1:length(x)
%        ud.url = 'http://www.matthewsim.com/';
%        ud.description = sprintf('point #%.0f%s%2.2f,%2.2f',i,char(10),x(i),y(i));
%        text(x(i),y(i),'','tag','click','UserData',ud)
%    end
%
%    % Create the file.
%    makemap(gcf,'map');
% 
%    % Open the page.
%    web(['file:///' which('map.html')],'-browser')

% Matthew J. Simoneau
% Copyright 2003 The MathWorks, Inc. 

if (nargin < 1)
   fig = gcf;
end
if (nargin < 2)
   filename = 'map';
end
if nargin <3 || isempty(Title),
    Title = regexprep( filename, '_', ' ' ); 
end
if nargin < 4
   JSaddress  = '/Users/nslavov/bin/boxover2/';   
end

mapFile = fopen([filename '.html'],'w');
%// Imbeds the image in a paragraph and centers the paragraph
    fprintf(mapFile, '<head>' );

%--- Box Over ---//
if 1
    Styles = 'cssbody=[dvbdy1] cssheader=[dvhdr1]';
        
    fprintf(mapFile, '<LINK rel="stylesheet" href="http://www.princeton.edu/~nslavov/bin/boxover2/my.css" type="text/css">\n' );
    fprintf(mapFile, '<LINK rel="stylesheet" /Users/nslavov/bin/boxover2/my.css" type="text/css">\n' );
    fprintf(mapFile, '<LINK rel="shortcut icon" href="http://www.princeton.edu/~nslavov/index_files/icons/Starred.ico">\n' );
    fprintf(mapFile, '<SCRIPT SRC="http://www.princeton.edu/~nslavov/bin/boxover2/boxover.js"></SCRIPT>\n' );
    fprintf(mapFile, '<SCRIPT SRC="boxover.js"></SCRIPT>\n' );
    fprintf(mapFile, '<SCRIPT SRC="/Users/nslavov/bin/boxover2/boxover.js"></SCRIPT>\n' );  
    fprintf(mapFile, '<SCRIPT SRC="%sboxover.js"></SCRIPT>\n' , JSaddress );   
    fprintf(mapFile, '<title>  %s  </title>\n\n', Title ); 
end 
%--- Box Over ---//

fprintf(mapFile, '<style type="text/css"> .centered{ text-align:center; margin-top:0px; margin-bottom:0px; padding:0px;} </style>' ); 
fprintf(mapFile, '</head>' );

fprintf(mapFile,'<h1 style=text-align:center;> %s </h1>\n\n', Title);

if 1
    fprintf(mapFile, '<center>\n' ); 
    fprintf(mapFile, '<table class="centered" > <tr>\n' ); 
    fprintf(mapFile, '<td style="font-size : 18pt;"  ><b><i><a href="col/%s.html">\n',  filename );
    fprintf(mapFile, '<font color="FF00FF" >ESR Induced</font>\n' ); %  Oxydative Ribosomal
    fprintf(mapFile, '& <font color="#52F3FF">ESR Repressed Genes</font><a/></i></b>  </td>\n' ); % Reductive ChargingCell Cycle 
    fprintf(mapFile, '<td width="40"></td>\n' ); 
    fprintf(mapFile, '<td> <b><i>  Input a gene set from file: </i></b> <br>\n' ); 
    fprintf(mapFile, '<input type="file" name="datafile" size="15">\n' ); 
    fprintf(mapFile, '</p><p class="centered">\n' ); 
    fprintf(mapFile, '</form>\n' );  
    fprintf(mapFile, '</td><tr></table>\n' ); 
    fprintf(mapFile, '</center>\n' );        
end

fprintf(mapFile, '<p class="centered">' );
fprintf(mapFile,'<img src="%s.png" usemap="#one"/>\n\n',filename);
fprintf(mapFile,'<map name="one">\n');

figPos = get(fig,'Position');

axesList = findobj('type','axes');
for iAxes = 1:length(axesList)
    ax = axesList(iAxes);

    set(ax,'Units','Pixels')
    axPos = get(ax,'Position');

    clickList = flipud(findobj(ax,'tag','click'));
    for iClick = 1:length(clickList)
        click = clickList(iClick);
        set(click,'units','pixels')
        pos = get(click,'Position');
        ud = get(click,'UserData');
        %f = '    <area shape="circle" coords="%.0f,%.0f,3" href="%s"    alt="%s"/>\n'; % title --> alt  
        %f = ' <area shape="circle" coords="%.0f,%.0f,3"  href="%s" target="_blank"  title="%s"/>\n'; 
        f = ' <area shape="circle" coords="%.0f,%.0f,3"  href="%s" target="_blank"  title="%s %s "/>\n'; 
        fprintf( mapFile,  f, ...
            pos(1)+axPos(1)-1, ...
            figPos(4)-(axPos(2)+axPos(4))+(axPos(4)-pos(2))+2, ...
            ud.url, ...
            Styles, ...
            ud.description); 
    end
end

fprintf(mapFile,'</map>\n');
fprintf(mapFile,'</p>\n');
fclose(mapFile);

figure(fig)
g = getframe(fig);
imwrite(g.cdata,[filename '.png'])
%print( '-dpng', filename ) 

