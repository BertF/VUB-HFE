function [ Z ] = getZ( g )
%GETZ Converts a reflection factor g to impedance Z
%   Also converts to admittance Y for working on a Z Smith Chart used as Y Smith
%   Chart
Z = (1+g)./(1-g);
end

