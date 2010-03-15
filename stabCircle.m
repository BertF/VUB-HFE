function [ C, R ] = stabCircle(S,port)
%STABCIRCLE Calculates the center C and radius R of the stability circle
%   [C, R] = stabCircle(S,port):
%     C: center
%     R: radius
%     S: S parameters of amplifier
%     port: 'in' or 'source' for input stability
%           'out' or 'load' for output stability
[K,Delta] = KDelta(S);
S11 = S(1,1);
S12 = S(1,2);
S21 = S(2,1);
S22 = S(2,2);
if strcmpi(port,'in') || strcmpi(port,'source')
    C=(S11-Delta*S22')'/(norm(S11)^2-norm(Delta)^2); 
    R=norm((S12*S21)/(norm(S11)^2-norm(Delta)^2));
elseif strcmpi(port,'out') || strcmpi(port,'load')
    C=(S22-Delta*S11')'/(norm(S22)^2-norm(Delta)^2); 
    R=norm((S12*S21)/(norm(S22)^2-norm(Delta)^2));
else
    error('Wrong port');
end;