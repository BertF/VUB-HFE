%% Design HF amplifier & dipole antenna
% Bert Follon & Egon Geerardyn
% Vrije Universiteit Brussel
% 2009 - 2010
% Specifications

%% general specs
f0 = 1445e6;            %[Hz] working frequency

%% DC operation point amplifier
OPSpec = struct('name','DC Operating Point Specifications');
OPSpec.f0   = f0;
OPSpec.Vce  = 5;        %[V] collector emittor voltage
OPSpec.Ic   = 5e-3;     %[A] quiescent collector current

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

%% PCB for amplifier
PCBAmp = struct('name', 'PCB Material Amplifier');
PCBAmp.type = 'FR4';
PCBAmp.epsR = 4.25;     %[] relative dielectric constant
PCBAmp.Z0   = 50;       %[Ohm] characteristic impedance

%% PCB for antenna
PCBAE = struct('name', 'PCB Material Antenna');
PCBAE.type  = 'RO3003';
PCBAE.epsR  = 3;        %[] relative dielectric constant
PCBAE.Z0    = 50;       %[Ohm] characteristic impedance of microstrip
PCBAE.ZAE   = 73;       %[Ohm] characteristic impedance of antenna