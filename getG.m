function [ g  ] = getG( Z )
%GETZ Converts an impedance Z to reflection factor g
%   Also converts from admittance Y when working on a Z Smith Chart used as Y Smith
%   Chart
g = (1+Z)/(Z-1);
end

