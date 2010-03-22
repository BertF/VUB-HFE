function texportCR(Gp,C,R,file)
%TEXPORT Export multiple Cs and Rs to table tex file
fid = fopen(file,'w');
n = numel(C);

fprintf(fid,'\\begin{tabular}{|r|r|r|} \\hline \n');
fprintf(fid,'\\textbf{Versterking $G_p$} & \\textbf{Middelpunt $C$} & \\textbf{Straal $R$} \\\\ \\hline \n');

for i = 1:n
fprintf(fid,'$%6.3f$ \\mbox{dB} & ',db(Gp(i)));
fprintf(fid,'$%6.3f %+6.3f j$ & ',real(C(i)), imag(C(i)));
fprintf(fid,'%6.3f \\\\ \\hline \n',R(i));
end;
fprintf(fid,'\\end{tabular}');
fclose(fid);