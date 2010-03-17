function [ GTmax ] = maxGain2(S,K)
%STABCIRCLE Calculates the maximum gain for bilateral case
%   [C, R] = stabCircle(S,port):
%     C: center
%     R: radius
%     S: S parameters of amplifier
%     port: 'in' or 'source' for input stability
%           'out' or 'load' for output stability
S21 = S(2,1);
S12 = S(1,2);

GTmax=(K - sqrt(K^2-1)) * norm(S21)/norm(S12);
