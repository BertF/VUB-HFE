function texportMatch(match)
file = 'verslag/res/matchtable.inc.tex';
  fid = fopen(file,'w');
  
  fprintf(fid,'\\begin{tabular}{|cc|r|r|c|} \n');
  fprintf(fid,'\\hline \\multicolumn{2}{|c|}{\\textbf{Grootheid}} & \\textbf{Ingang} & \\textbf{Uitgang} & \\\\ \n');
  fprintf(fid,'\\hline %s & %s & $%1.3f %+1.3f j$ & $%1.3f %+1.3f j$ & %s \\\\ \n', ...
               '$\Gamma_1$', '\color{blue}{$\star$}', ...
               real(match.in.Gamma1), imag(match.in.Gamma1), ...
               real(match.out.Gamma1), imag(match.out.Gamma1), ...
               '');
  fprintf(fid,'\\hline %s & %s & $%1.3f %+1.3f j$ & $%1.3f %+1.3f j$ & %s \\\\ \n', ...
               '$\Gamma_2$', '\color{green}{$\star$}', ...
               real(match.in.Gamma2), imag(match.in.Gamma2), ...
               real(match.out.Gamma2), imag(match.out.Gamma2), ...
               '');
  fprintf(fid,'%s & %s & $%1.3f %+1.3f j$ & $%1.3f %+1.3f j$ & %s \\\\ \n', ...
               '$Y_2$', '\color{green}{$\star$}', ...
               real(match.in.Y2), imag(match.in.Y2), ...
               real(match.out.Y2), imag(match.out.Y2), ...
               'S');
  fprintf(fid,'\\hline %s & %s & $%1.3f %+1.3f j$ & $%1.3f %+1.3f j$ & %s \\\\ \n', ...
               '$\Gamma_3$', '\color{cyan}{$\star$}', ...
               real(match.in.Gamma3), imag(match.in.Gamma3), ...
               real(match.out.Gamma3), imag(match.out.Gamma3), ...
               '');
  fprintf(fid,'%s & %s & $%+1.3f j$ & $%+1.3f j$ & %s \\\\ \n', ...
               '$Y_3$', '\color{cyan}{$\star$}', ...
               imag(match.in.Y3), ...
               imag(match.out.Y3), ...
               'S');
  fprintf(fid,'\\hline %s & %s & $%1.3f %+1.3f j$ & $%1.3f %+1.3f j$ & %s \\\\ \n', ...
               '$\Gamma_4$', '\color{magenta}{$\star$}', ...
               real(match.in.Gamma4), imag(match.in.Gamma4), ...
               real(match.out.Gamma4), imag(match.out.Gamma4), ...
               '');
  fprintf(fid,'%s & %s & $%+1.3f j$ & $%+1.3f j$ & %s \\\\ \n', ...
               '$Y_4$', '\color{magenta}{$\star$}', ...
               imag(match.in.Y4), ...
               imag(match.out.Y4), ...
               'S');
  fprintf(fid,'\\hline %s & %s & %1.3f & %1.3f & %s \\\\ \n', ...
               '$E_1$', '\color{blue}{\textbf{--}}', ...
               match.in.ang1deg, ...
               match.out.ang1deg, ...
               '$^{\circ}$');
  fprintf(fid,'\\hline %s & %s & %1.3f & %1.3f & %s \\\\ \n', ...
               '$E_2$', '\color{magenta}{\textbf{--}}', ...
               match.in.ang2deg, ...
               match.out.ang2deg, ...
               '$^{\circ}$');
  fprintf(fid,'\\hline %s & %s & %s & %s & %s \\\\ \n', ...
               'T', '$\star$', ...
               match.in.stubterm, ...
               match.out.stubterm, ...
               '');
  fprintf(fid,'\\hline \\end{tabular} \n');
  
  fclose(fid);
  
  