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

Gtumax=(abs(NPN.S21)^2)./((1-abs(NPN.S11)^2)*(1-abs(NPN.S22)^2));
Gtmax = maxGain(NPN.S,match.allTs,match.allTl);


% maximale gain kiezen
[i,j] = find(abs(Gtmax)==max(max(abs(Gtmax))));
match.Ts = match.allTs(i);
match.Tl = match.allTl(j);



%% gain circles
[gs gl]=normalized_gain(match,NPN.S);

[CS, RS] = gainCircle(NPN.S,gs,'in');
[CL, RL] = gainCircle(NPN.S,gl,'out');
figure;
plot([circle(0,1,100) circle(0.5,0.5,100)],'-k','DisplayName','Smith Chart'); hold on;
plot(circle(CL,RL,100),'-r','DisplayName','Output');
plot(circle(CS,RS,100),'-b','DisplayName','Input'); 
legend(gca,'show'); axis square; grid on;
title('Gaincirkels');
plot(CL,'*r');
plot(CS,'*b'); hold off;
printpdffig(gcf, [10,10], 'verslag/fig/gaincirkels.pdf');
texportCR(CL,RL,'C_L','R_L','verslag/res/gaincirkelload.inc.tex');
texportCR(CS,RS,'C_S','R_S','verslag/res/gaincirkelsource.inc.tex');





  