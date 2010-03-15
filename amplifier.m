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
printpdffig(gcf, [10,10], 'fig/stabiliteitscirkel.pdf');
% bilateral case

B1=1+norm(NPN.S11)^2-norm(NPN.S22)^2-norm(Delta)^2;
B2=1+norm(NPN.S22)^2-norm(NPN.S11)^2-norm(Delta)^2;
C1=NPN.S11-Delta*NPN.S22';
C2=NPN.S22-Delta*NPN.S11';
Ts=(B1-sqrt(B1^2-4*norm(C1)^2))/(2*C1);
Tl=(B2-sqrt(B2^2-4*norm(C2)^2))/2*C2;



Gtmax=(norm(NPN.S21)^2*(1-norm(Tl)^2))/((1-norm(Ts)^2)*(norm((1-NPN.S22*Tl))^2))

% unilateral case
Gtumax=(norm(NPN.S12)^2)/((1-norm(NPN.S11)^2)*(1-norm(NPN.S22)^2))
  