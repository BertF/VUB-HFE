function [ ang ] = anglebetween(A,B,O,dir)
%ANGLEBETWEEN Angle between points A and B with respect to center O
%   Detailed explanation goes here
if nargin < 3
    O = 0;
    dir = 1;
end;
if nargin < 4
    dir = 1;
end;
a = A - O;
b = B - O;
angA = angle(a);
angB = angle(b);
if angA < pi && angB < angA
    ang = angA - angB;
elseif angA < pi && angB >= angA
    ang = 2*pi + (angA-angB);
elseif angA < 0 && angB > angA
    ang = 2*pi -(angA - angB);
elseif angA < 0 && angB <= angA
    ang = angA - angB;
end;
if dir < 0
    ang = 2*pi - ang;
end;