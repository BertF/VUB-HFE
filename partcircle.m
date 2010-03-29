function [ circ ] = partcircle(C,R1,theta,dir)
%CIRCLE Complex points on a circle with center C, radius R in steps
%   Returns points on a circle in the complex plane with
%   [circ] = circle(C,R,steps)
if nargin < 4
    steps = 100;
end;
R = norm(R1-C);
ang1 = anglebetween(C,R1,C);
th = abs(linspace(0,theta,steps) + ang1);
circ = C + R * exp(1i*th);