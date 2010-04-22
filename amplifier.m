%% Versterker
clc; clear all; close all;
specs;

%% NVV Stabiliteit
% formule 11.71/11.72
[K,Delta] = KDelta(NPN.S);
disp('Stabiliteit');
disp(['K = ' num2str(K) ' |Delta| =' num2str(Delta)]);
if ((K>1) && norm(Delta) < 1)
    disp('NVV Stabiliteit voldaan');
end;
texportRollet(K,Delta,'verslag/res/rollet.inc.tex');

%% Stabiliteitscirkels
[CL, RL] = stabCircle(NPN.S,'load');
[CS, RS] = stabCircle(NPN.S,'source');

figure;
plot([circle(0,1,100) circle(0.5,0.5,100)],'-k','DisplayName','Smith Chart'); hold on;
plot(circle(CL,RL,100),'-r','DisplayName','Output stabiliteitscirkel');
plot(circle(CS,RS,100),'-b','DisplayName','Input stabiliteitscirkel'); 
legend(gca,'show'); axis square; grid on;
title('Stabiliteitscirkels');
plot(CL,'*r');
plot(CS,'*b'); hold off;
printpdffig(gcf, [10,10], 'verslag/fig/stabiliteitscirkels.pdf');
texportCR(CL,RL,'C_L','R_L','verslag/res/stabcirkelload.inc.tex');
texportCR(CS,RS,'C_S','R_S','verslag/res/stabcirkelsource.inc.tex');


%% Controle unilateraal
U=figure_of_merit(NPN.S);
unilateralBounds = [1/(1+U)^2 1/(1-U)^2];
texportUnilateral(U,unilateralBounds,'verslag/res/unilateral.inc.tex');

%% bilateral case
[B1, B2, C1, C2] = BBCC(NPN.S);
match.allTs=(B1-[1 -1]*sqrt(B1^2-4*norm(C1)^2))/(2*C1);
match.allTl=(B2-[1 -1]*sqrt(B2^2-4*norm(C2)^2))/(2*C2);

if abs(K) > 1
    match.Ts = match.allTs(1);
    match.Tl = match.allTl(1);
elseif abs(K) > 1
    match.Ts = match.allTs(2);
    match.Tl = match.allTl(2);
end;

Gtumax=(abs(NPN.S21)^2)./((1-abs(NPN.S11)^2)*(1-abs(NPN.S22)^2));
%Gtmax = maxGain(NPN.S,match.Ts,match.Tl);

Gtmax = maxGain2(NPN.S,K); % eenvoudigere formule

%% gain circles
[gs gl] = normalized_gain(match,NPN.S);

[CS, RS] = gainCircle(NPN.S,gs,'in');
[CL, RL] = gainCircle(NPN.S,gl,'out');

Gp= [10.^([3 2 1]/20) 0.5*Gtmax 0.99*Gtmax Gtmax];
[C, R] = gainCircle(NPN.S,Gp,'in',K);
figure;
scDraw(0); hold on;
color = 'rgbcmk'; 

h = plot([0 C(end)],'-y','DisplayName','Drager');
nolegend(h);

for i = 1:numel(C)
    plot(circle(C(i),R(i),100),color(i),'LineWidth',2,'DisplayName',['Gaincirkel: ' num2str(db(Gp(i))) ' dB']);
end;
legend(gca,'show'); axis square; grid on;
for i = 1:numel(C)
    h = plot(C(i),['*' color(i)]);
    nolegend(h);
end;
title('Gaincirkels');
printpdffig(gcf, [10,10], 'verslag/fig/gaincirkels.pdf');
texportCRs(Gp,C,R,'verslag/res/gaincirkeltbl.inc.tex');

%% Matching input and output
close all;
figure;
[match.in, h] = matcher(NPN.S11');
printpdffig(h,[10 10],'verslag/fig/matchSource.pdf');
figure;
[match.out, h] = matcher(NPN.S22');
printpdffig(h,[10 10],'verslag/fig/matchLoad.pdf');
texportMatch(match);

%% manueel
% input netwerk
% lengteverbindingin=0.4325-0.326; %verbinding bjt 
% imaginair_tecompin=1.4;
% halvetecompin=imaginair_tecompin/2;
% tweemaalin_lengte=0.096;
% Einstub = elecLength(tweemaalin_lengte); % elec. lengte in degree
% Einlijn = elecLength(lengteverbindingin); % elek. lengte in degree
% % output netwerk
% lengteverbindingout=0.1961-0.184; %verbinding bjt
% imaginair_tecompout=1.9;
% halvetecompout=imaginair_tecompout/2;
% tweemaalout_lengte=0.3849-0.25;
% Eoutstub = elecLength(tweemaalout_lengte); % elec. lengte in degree
% Eoutlijn = elecLength(lengteverbindingout); % elek. lengte in degree
% disp('Elektrische lengtes' );
% disp([Einstub Einlijn]);
% disp([Eoutstub Eoutlijn]);

%% man matching (in lambda)
match.in.man.L1 = 0.072;
match.in.man.L2 = 0.25-0.176;
match.out.man.L1 = 0.028;
match.out.man.L2 = 0.25-0.126;

%% ADS matching
match.in.ADS.E1 = 9.141;
match.in.ADS.E2 = 28.89;
match.in.ADS.term = 'open' ;
match.out.ADS.E1 = 45.36;
match.out.ADS.E2 = 50.18;
match.out.ADS.term = 'short' ;

match.in.ADS.L1 = match.in.ADS.E1 / 360 * PCBAmp.lambda;
match.in.ADS.L2 = match.in.ADS.E2 / 360 * PCBAmp.lambda;
match.out.ADS.L1 = match.out.ADS.E1 / 360 * PCBAmp.lambda;
match.out.ADS.L2 = match.out.ADS.E2 / 360 * PCBAmp.lambda;
disp(['in L1 = ' eng(match.in.ADS.L1)]);
disp(['in L2 = ' eng(match.in.ADS.L2)]);
disp(['out L1 = ' eng(match.out.ADS.L1)]);
disp(['out L2 = ' eng(match.out.ADS.L2)]);


%% DC bias netwerk
% architectuur zoals in Gonzalez fig. 3.9.2b (p. 287 PDF)
OPSpec.Vcc=OPSpec.Vce *2 - NPN.Vbe;
OPSpec.Vbb=0.1 * OPSpec.Vcc;
OPSpec.Ib=OPSpec.Ic/NPN.hFE;
OPSpec.Rb=(OPSpec.Vbb-NPN.Vbe)/OPSpec.Ib;
OPSpec.Rb2 = 10^(2/12) * 1000;
OPSpec.Ibb = OPSpec.Vbb/OPSpec.Rb2;
if OPSpec.Ibb < 10 * OPSpec.Ib
    warning(0,'te kleine Ibb!');
end;
%OPSpec.Rb2=OPSpec.Vbb/OPSpec.Ibb;
OPSpec.Rc=(OPSpec.Vcc-OPSpec.Vce)/(OPSpec.Ic+OPSpec.Ibb+OPSpec.Ib);
OPSpec.Rb1=(OPSpec.Vce-OPSpec.Vbb)/(OPSpec.Ibb+OPSpec.Ib);
texportDCBias(OPSpec,NPN,'verslag/res/DCBias.inc.tex');

%%



