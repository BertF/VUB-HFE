function [ K, Delta ] = KDelta(S)
%KDELTA Calculates K and determinant of S matrix and matching networks
%   Detailed explanation goes here
Delta = det(S);
K = (1 - norm(S(1,1))^2 - norm(S(2,2))^2 + norm(Delta)^2) / ...
    (2*norm(S(1,2)*S(2,1)));
end

