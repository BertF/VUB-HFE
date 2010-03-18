function [U] = figure_of_merit(S)

S11 = S(1,1);
S12 = S(1,2);
S21 = S(2,1);
S22 = S(2,2);

U=(norm(S12)*norm(S21)*norm(S11)*norm(S22))/((1-norm(S11)^2)*(1-norm(S22)^2));