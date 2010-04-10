function texportRollet(K,Delta,file)
 fid = fopen(file,'w');
  fprintf(fid,'\\[\n');
  fprintf(fid,'K \\approx %1.3f \\qquad \\qquad \n', K);
  fprintf(fid,'|\\Delta| \\approx |%1.3f %+1.3fj| \\approx %1.3f \n', ...
              real(Delta), imag(Delta), abs(Delta));
  fprintf(fid,'\\]\n');
 fclose(fid);