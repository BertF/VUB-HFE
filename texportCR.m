function texportCR(C,R,nC,nR,file)
%TEXPORT Export C and R to tex file
fid = fopen(file,'w');

fprintf(fid,'\\[\n');
fprintf(fid,'\t%s =',nC);
fprintf(fid,'\t%6.2f + j %6.2f',real(C), imag(C));
fprintf(fid,'\\qquad \\qquad \\qquad');
fprintf(fid,'\t%s =',nR);
fprintf(fid,'\t%6.2f',R);
fprintf(fid,'\n\\]\n');

fclose(fid);