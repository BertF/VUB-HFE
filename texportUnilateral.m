function [] = texportUnilateral(U,lower,upper,file)
fid = fopen(file,'w');

fprintf(fid,'\\[\n');
fprintf(fid,'\t%s \\approx','U');
fprintf(fid,'\t%3.5f',U);
fprintf(fid,'\n\\]\n');

fprintf(fid,'\\[\n');
fprintf(fid,'-0.8 dB < %3.5f < \\frac{G_T}{G_{TU}} < %3.5f < 0.8 dB',lower,upper);
fprintf(fid,'\n\\]\n');

fprintf(fid,'\\[\n');
fprintf(fid,'-0.8 dB < %3.3f dB< \\frac{G_T}{G_{TU}} < %3.3f dB< 0.8 dB',db(lower,'power'),db(upper,'power'));
fprintf(fid,'\n\\]\n');


fclose(fid);