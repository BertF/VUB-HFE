function [B1, B2, C1, C2] = BBCC(S)
Delta = det(S);
S11 = S(1,1);
S22 = S(2,2);
    
B1=1+norm(S11)^2-norm(S22)^2-norm(Delta)^2;
B2=1+norm(S22)^2-norm(S11)^2-norm(Delta)^2;
C1=S11-Delta*S22';
C2=S22-Delta*S11';
