function l = ray(start,stop,length)
if nargin < 3
    length = 1.2;
end;
l(1) = start;
l(2) = stop/norm(stop)*length;
