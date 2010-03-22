function [ h ] = matcher(Ti, Tr, mode, demo)
%MATCHER Matches reflection factors with integrated smith charts
% Ti: reflection factor to start from
% Tr: required reflection factor
% mode: matching mode (not used)
% demo: wait between smith chart actions for demo
h = scDraw(0); hold on;
  plot(Tr,'*b','DisplayName','\Gamma_1');
  plot(circle(0,norm(Tr),100),'-b','DisplayName','eerste TL');
  [x,y] = POI(0.5,0.5,0,norm(Tr));
  plot(x,y,'*g','DisplayName','\Gamma_2');
  u1 = x(2); v1 = y(2);
  g = u1 + 1i*v1;
  Y = (1+g)/(1-g);
  Y2 = -1*1i*imag(Y);
  G2 = (1+Y2)/(Y2-1);
  plot(G2,'*m');
  ang = (2*pi - angle(G2))
  angDeg = ang/(2*pi)*360
  
end

