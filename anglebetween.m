function [ ang ] = anglebetween(A,B,O)
%ANGLEBETWEEN Angle between points A and B with respect to center O
%   Detailed explanation goes here
if nargin < 3
    O = 0;
end;
a = A - O;
b = B - O;
angA = angle(a);
angB = angle(b);
if angA < 0
    angA = angA + 2*pi;
end;
if angB < 0
    angB = angB + 2*pi;
end;
ang = angA - angB;