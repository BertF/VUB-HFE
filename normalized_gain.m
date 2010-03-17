 function [gS gL] = normalized_gain(match,S)
 
Ts=match.Ts;
Tl=match.Tl;
 
S11 = S(1,1);
S22 = S(2,2);
 
gS=((1-norm(Ts)^2)*(1-norm(S11)^2))/(norm(1-S11*Ts)^2);
gL=((1-norm(Tl)^2)*(1-norm(S22)^2))/(norm(1-S22*Tl)^2);