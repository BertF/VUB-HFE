function [ C, R ] = gainCircle(S,g,port,K)
%GAINCIRCLE Calculates the center C and radius R of the stability circle
%   [C, R] = stabCircle(S,port):
%     C: center
%     R: radius
%     g: normalized gain
%     S: S parameters of amplifier
%     port: 'in' or 'source' for input stability
%           'out' or 'load' for output stability
S11 = S(1,1);
S22 = S(2,2);
S12 = S(1,2);
S21 = S(2,1);
if nargin<4
    if strcmpi(port,'in') || strcmpi(port,'source')
        Sp = S11;
    elseif strcmpi(port,'out') || strcmpi(port,'load')
        Sp = S22;
    else
        error('Wrong port');
        return
    end;

    C = g*S11'/(1-(1*g)*norm(S11)^2);
    R = sqrt(1-g) * ( 1 - norm(Sp)^ 2) / ( 1 - (1-g) * norm(S22)^2);
else
    Gp = g;
    Delta = det(S);
    R= sqrt(norm(S12*S21)^2-2*K*norm(S12*S21).*(norm(S21)^2./Gp)+(norm(S21)^2./Gp).^2)./(norm(S22)^2-norm(Delta)^2+norm(S21)^2./Gp)
    C=(S22.'-S11.*Delta.')./(norm(S22)^2-norm(Delta)^2+norm(S21)^2./Gp)
end;