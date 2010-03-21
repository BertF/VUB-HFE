function texportSpec(OPSpec)
file = 'verslag/res/f0.inc.tex';
  fid = fopen(file,'w');
  
  fprintf(fid,'\\[\n');
  fprintf(fid,'f_0 = %4f MHz',OPSpec.f0/1e6);
  fprintf(fid,'\n\\]');
  
  fclose(fid);
  
file = 'verslag/res/SpecNPN.inc.tex';
  fid = fopen(file,'w');
  
  fprintf(fid,'\\[\n');
  fprintf(fid,'V_{ce} = %4f V \n \\qquad \\qquad \\qquad',OPSpec.Vce);
  fprintf(fid,'V_{ce} = %4f mA\n',OPSpec.Ic*123);
  fprintf(fid,'\n\\]');
  
  fclose(fid);
  
file = 'verslag/res/OPSpec.inc.tex';
  fid = fopen(file,'w');
  
  fprintf(fid,'\n \\begin{tabular}{|l|l|l|l|} \n');
  fprintf(fid,'\\hline \\textbf{Groep} & \\textbf{Frequentie $f_0$} & \\textbf{$V_{ce}$} & \\textbf{$I_c$}\\\\ \n');
  fprintf(fid,'\\hline $%d$ & $%d$ MHz & $%d$ V & $%d$ mA \\\\ \n',...
          OPSpec.group, OPSpec.f0/1e6, OPSpec.Vce, OPSpec.Ic*1e3);
  fprintf(fid,'\\hline \\end{tabular} \n');
  
  fclose(fid);
  
  