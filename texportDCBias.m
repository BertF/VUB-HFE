function texportDCBias(OPSpec,NPN,file)
  fid = fopen(file,'w');
  
  fprintf(fid,'\\[\n');
  fprintf(fid,'R_{B} \\approx %3.2f \\Omega \\\\ \n',OPSpec.Rb);
  fprintf(fid,'R_{B1} \\approx %3.2f \\Omega \\\\ \n',OPSpec.Rb1);
  fprintf(fid,'R_{B2} \\approx %3.2f \\Omega \\\\ \n',OPSpec.Rb2);
  fprintf(fid,'R_{C} \\approx %3.2f \\Omega \\\\ \n',OPSpec.Rc);
  fprintf(fid,'\\]');
  
  fclose(fid);