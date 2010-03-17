function [ C, R ] = gainCircle(S,g,port)
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