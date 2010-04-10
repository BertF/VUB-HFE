function [si] = genSIprefix(order)
%% genSIprefix generates a structure containing SI prefixes
% when a parameter is given, this is the order of the prefixes used
%  e.g. genSIprefix(2) generates prefixes for units^2 (e.g. m^2)
if nargin < 1
    order = 1;
    eval = 'genSIprefix()';
else
    eval = ['genSIprefix(' num2str(order) ')'];
end;
si = struct('name','SI prefixes','order',order,'eval',eval);

%% decimal base
si.Y  = (1e024)^order; si.yotta = si.Y;
si.Z  = (1e021)^order; si.zetta = si.Z;
si.E  = (1e018)^order; si.exa   = si.E;
si.P  = (1e015)^order; si.peta  = si.P;
si.T  = (1e012)^order; si.tera  = si.T;
si.G  = (1e009)^order; si.giga  = si.G;
si.M  = (1e006)^order; si.mega  = si.M;
si.k  = (1e003)^order; si.kilo  = si.k;
si.h  = (1e002)^order; si.hecto = si.h;
si.da = (1e001)^order; si.deca  = si.da;

si.d  = (1e-01)^order; si.deci  = si.d;
si.c  = (1e-02)^order; si.centi = si.c;
si.m  = (1e-03)^order; si.mili  = si.m;
si.u  = (1e-06)^order; si.micro = si.u;
si.n  = (1e-09)^order; si.nano  = si.n;
si.p  = (1e-12)^order; si.pico  = si.p;
si.f  = (1e-15)^order; si.femto = si.f;
si.a  = (1e-18)^order; si.atto  = si.a;
si.z  = (1e-21)^order; si.zepto = si.z;
si.y  = (1e-24)^order; si.yocto = si.y;

%% binary base
si.Yi = (2^80)^order; si.yobi = si.Yi;
si.Zi = (2^70)^order; si.zebi = si.Zi;
si.Ei = (2^60)^order; si.exbi = si.Ei;
si.Pi = (2^50)^order; si.pebi = si.Pi;
si.Ti = (2^40)^order; si.tebi = si.Ti;
si.Gi = (2^30)^order; si.gibi = si.Gi;
si.Mi = (2^20)^order; si.mebi = si.Mi;
si.Ki = (2^10)^order; si.kibi = si.Ki;