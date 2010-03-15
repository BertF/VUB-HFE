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
% output
[CL, RL] = stabCircle(NPN.S,'load');
[CS, RS] = stabCircle(NPN.S,'source');

figure;
plot(circle(0,1,100),'-k','DisplayName','Smith Chart'); hold on;
plot(circle(CL,RL,100),'-r','DisplayName','Output stabiliteitscirkel');
plot(circle(CS,RS,100),'-b','DisplayName','Input stabiliteitscirkel'); hold off;
legend(gca,'show'); axis square; grid on;
title('Stabiliteitscirkels');
printpdffig(gcf, [10,10], 'verslag/fig/stabiliteitscirkels.pdf');
texportCR(CL,RL,'C_L','R_L','verslag/res/stabcirkelload.inc.tex');
texportCR(CS,RS,'C_S','R_S','verslag/res/stabcirkelsource.inc.tex');


%% Control unilateraal
U=figure_of_merit(NPN.S);
ondergrens=1/(1+U)^2;
bovengrens=1/(1-U)^2;
texportUnilateral(U,ondergrens,bovengrens,'verslag/res/unilateral.inc.tex');

%% bilateral case
[B1, B2, C1, C2] = BBCC(NPN.S);
Ts=(B1-[1 -1]*sqrt(B1^2-4*norm(C1)^2))/(2*C1);
Tl=(B2-[1 -1]*sqrt(B2^2-4*norm(C2)^2))/(2*C2);

Gtumax=(abs(NPN.S21)^2)./((1-abs(NPN.S11)^2)*(1-abs(NPN.S22)^2));

Gtmax=(abs(NPN.S21)^2*(1-abs(Tl).^2))./((1-abs(Ts(1)).^2)*(norm((1-NPN.S22*Tl)).^2))
Gtmax/Gtumax
Gtmax=(abs(NPN.S21)^2*(1-abs(Tl).^2))./((1-abs(Ts(2)).^2)*(norm((1-NPN.S22*Tl)).^2))
Gtmax/Gtumax


  