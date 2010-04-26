%% Design HF amplifier & dipole antenna
% Bert Follon & Egon Geerardyn
% Vrije Universiteit Brussel
% 2009 - 2010
% Specifications

%% set path for smith chart
path(path,'smithchart');
si = genSIprefix();

%% general specs
f0 = 1445 * si.M;       %[Hz] working frequency
c0 = 299792458;         %[m/s] speed of light in vacuum

%% DC operation point amplifier
OPSpec = struct('name','DC Operating Point Specifications');
OPSpec.group= 1;
OPSpec.f0   = f0;
OPSpec.Vce  = 5;        %[V] collector emittor voltage
OPSpec.Ic   = 5e-3;     %[A] quiescent collector current
texportSpec(OPSpec)

%% NPN transistor for amplifier
NPN = struct('name', 'NPN Transistor values');
NPN.type    = 'BFR91 A';
NPN.f0      = f0;
NPN.S11     = -0.104 + 1i * 0.181; % 
NPN.S12     =  0.102 + 1i * 0.154; % 
NPN.S21     =  1.369 + 1i * 1.397; %
NPN.S22     =  0.355 - 1i * 0.318; %
NPN.S       = [ NPN.S11 NPN.S12    % S parameter matrix
                NPN.S21 NPN.S22 ];
NPN.Vbe     = 0.7;                 % [V] base emitter voltage
NPN.Icmax   = 35e-3;               % [A] maximal collector current
NPN.hFE     = 100;                 % [] nominal current gain
texportNPN(NPN);

%% PCB for amplifier
PCBAmp = struct('name', 'PCB Material Amplifier');
PCBAmp.type = 'FR4';
PCBAmp.epsR = 4.25;     %[] relative dielectric constant
PCBAmp.Z0   = 50;       %[Ohm] characteristic impedance
PCBAmp.c = 2/3 * c0;    %[m/s] speed of light in PCB
PCBAmp.f0 = f0;         
PCBAmp.lambda = PCBAmp.c/PCBAmp.f0; %[m] wave length 
PCBAmp.h = 1.6 * si.m;  %[m] height of PCB

texportPCB(PCBAmp,'verslag/res/PCBAmp.inc.tex');

%% PCB for antenna
PCBAE = struct('name', 'PCB Material Antenna');
PCBAE.type  = 'RO3003';
PCBAE.epsR  = 3;        %[] relative dielectric constant
PCBAE.Z0    = 50;       %[Ohm] characteristic impedance of microstrip
PCBAE.ZAE   = 73;       %[Ohm] characteristic impedance of antenna
PCBAE.h     = 1.7e-3;   %[m] thickness
texportPCB(PCBAE,'verslag/res/PCBAE.inc.tex');

%% Matching networks
match = struct('name', 'Matching networks');
match.f0      = f0;

