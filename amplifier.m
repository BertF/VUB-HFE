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
Gtmax = maxGain(NPN.S,match.Ts,match.Tl);

Gtmax = maxGain2(NPN.S,K);





%% gain circles
[gs gl]=normalized_gain(match,NPN.S);

[CS, RS] = gainCircle(NPN.S,gs,'in');
[CL, RL] = gainCircle(NPN.S,gl,'out');

Gp= [10.^([3 2 1]/20) 0.5*Gtmax 0.99*Gtmax Gtmax];
[C, R] = gainCircle(NPN.S,Gp,'in',K);
figure;
plot([circle(0,1,100) circle(0.5,0.5,100)],'-k','DisplayName','Smith Chart'); hold on;
color = 'rgbcmk'; 
for i = 1:numel(C)
    plot(circle(C(i),R(i),100),color(i),'DisplayName',['Gaincirkel = ' num2str(db(Gp(i))) ' dB']);
end;
legend(gca,'show'); axis square; grid on;
for i = 1:numel(C)
    plot(C(i),['*' color(i)]);
end;
title('Gaincirkels');
printpdffig(gcf, [10,10], 'verslag/fig/gaincirkels.pdf');
texportCR(C(1),R(1),'C_L','R_L','verslag/res/gaincirkel3db.inc.tex');

%% 
% Gp=Gtmax;
% Gp=10^(3/20)
% R=sqrt(norm(NPN.S12*NPN.S21)^2-2*K*norm(NPN.S12*NPN.S21)*(norm(NPN.S21)^2/Gp)+(norm(NPN.S21)^2/Gp)^2)/(norm(NPN.S22)^2-norm(Delta)^2+norm(NPN.S21)^2/Gp)
% C=(NPN.S22'-NPN.S11*Delta')/(norm(NPN.S22)^2-norm(Delta)^2+norm(NPN.S21)^2/Gp)

  