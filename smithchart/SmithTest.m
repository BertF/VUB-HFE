
h = scDraw();


RC = 50;
z0 = (100 + 75j)/RC;
% 
% [u,v] = scPOI(real(z0),imag(z0));
% 
% scRay(z0);
% scMove(z0,0.1,'k');
% scRay(RC^2/z0);

% scMatchCirc('c');
legend(gca,'show');

printpdffig(h,[10,10],'test.pdf');