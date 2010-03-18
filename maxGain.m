function [ GTmax ] = maxGain(S,Ts,Tl)
%STABCIRCLE Calculates the maximum gain for bilateral case
%   [C, R] = stabCircle(S,port):
%     C: center
%     R: radius
%     S: S parameters of amplifier
%     port: 'in' or 'source' for input stability
%           'out' or 'load' for output stability
S21 = S(2,1);
S22 = S(2,2);

sTs = numel(Ts);
sTl = numel(Tl);

Ts = repmat(Ts,sTl,1);
Tl = repmat(Tl(:),1,sTs);

GTmax=(abs(S21)^2*(1-abs(Tl).^2))./(((1-abs(Ts).^2))*(norm((1-S22.*Tl)).^2));
