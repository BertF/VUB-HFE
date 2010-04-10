function [ circ ] = partcircle(C,R1,R2,dir,steps)
%CIRCLE Complex points on a circle with center C, radius R in steps
%   Returns points on a circle in the complex plane with
%   [circ] = partcircle(C,R1,R2,direction,[steps=100])
if nargin < 4
    dir = 1;
end;
if nargin < 5
    steps = 100;
end;
R = norm(R1-C);
ang1 = anglebetween(C+1,R1,C,dir);
theta = anglebetween(R1,R2,C,dir);
th = abs(linspace(0,theta,steps) + ang1);
circ = C + R * exp(1i*th);