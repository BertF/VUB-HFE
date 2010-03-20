 function scConCirc(r,LinCol,hide)
 %scConCirc: draws concentric circles about the origin
%
%  SYNOPSIS:
%     Draws circle about origin in desired color.
%
%     See also scDraw, scInv, scMove, scMatchCirc  
%     
%  SYNTAX:
%     scConCirc(r,color, [hide])
%
%  INPUT ARGUMENTS:
%     r      : radius of the circle
%     LinCol : desired color of the arc, optional, default = 'm', magenta
%     hide   : optional to hide the legend entries
%
%  OUTPUT ARGUMENT:
%     none
%
%
%  EXAMPLE:
%         The Command sequence 
%         scDraw;
%         scConCirc(0.4);
%         will draw a blank smith chart and draw a circle having center at the
%         smith chart center [1 0] and a radius 0.4. This may be thought of as
%         the locus of all the points having a reflection factor 0.4.
%
%     Mohammad Ashfaq - (31-05-2000)
%     Mohammad Ashfaq - (13-04-2006) Modified (example included)
%     Egon Geerardyn  - (20-03-2010) Added hide
%
 
 if nargin < 2
    LinCol = 'm';
 end
 if nargin < 3
    hide = 0;
 end;
 

 x = linspace(-r,r,200);
 h1 = plot(x, sqrt(r^2-x.^2),LinCol); 
 h2 = plot(x,-sqrt(r^2-x.^2),LinCol);
 if hide
     set(get(get(h1,'Annotation'),'LegendInformation'),...
         'IconDisplayStyle','off'); % Exclude line from legend
     set(get(get(h2,'Annotation'),'LegendInformation'),...
         'IconDisplayStyle','off'); % Exclude line from legends
 end;