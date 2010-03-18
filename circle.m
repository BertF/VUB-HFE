function [ circ ] = circle(C,R,steps)
%CIRCLE Complex points on a circle with center C, radius R in steps
%   Returns points on a circle in the complex plane with
%   [circ] = circle(C,R,steps)
th = linspace(0,2*pi,steps);
circ = C + R * exp(1i*th);