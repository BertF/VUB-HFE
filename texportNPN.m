function texportNPN(NPN)
file = 'verslag/res/NPN-S.inc.tex';
  fid = fopen(file,'w');
  
  fprintf(fid,'\\[\n');
  fprintf(fid,'S = \\left[ \\begin{array}{cc} \n');
  fprintf(fid,'S_{11} & S_{12} \\\\ \n S_{21} & S_{22} \\\\ \n');
  fprintf(fid,'\\end{array} \\right] \n');
  fprintf(fid,' \\approx \\left[ \\begin{array}{cc} \n');
  fprintf(fid,'%1.3f %+1.3f j & %1.3f %+1.3f j \\\\ \n',real(NPN.S11),imag(NPN.S11),real(NPN.S12),imag(NPN.S12));
  fprintf(fid,'%1.3f %+1.3f j & %1.3f %+1.3f j \\\\ \n',real(NPN.S21),imag(NPN.S21),real(NPN.S22),imag(NPN.S22));
  fprintf(fid,'\\end{array} \\right] \\label{eq:S}');
  fprintf(fid,'\n\\]');
  
  fclose(fid);