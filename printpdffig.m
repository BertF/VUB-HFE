%
% printpdffig
%  fhand: figure handle (e.g. gcf)
%  figuresize: [W H] vector expressed
%  file: filename of the destination
function printpdffig(fhand,figuresize,file)
set(fhand,'PaperUnits','inches');
set(fhand,'PaperSize',figuresize);
set(fhand,'PaperPosition',[0 0 figuresize]);
print(fhand,'-dpdf',file);