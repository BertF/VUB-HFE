function [ H ] = matcher(Ti, Tr, mode, demo)
%MATCHER Matches reflection factors with integrated smith charts
% Ti: reflection factor to start from
% Tr: required reflection factor
% mode: matching mode (not used)
% demo: wait between smith chart actions for demo
H = scDraw(0); hold on;
  plot(Tr,'*b','DisplayName','\Gamma_1');
  h = plot(ray(0,Tr),'--b');
  nolegend(h);
  h = plot(circle(0,norm(Tr),100),'-b','DisplayName','eerste TL');
  nolegend(h);
  
  [x,y] = POI(0.5,0.5,0,norm(Tr));
  u1 = x(2); v1 = y(2);
  g = u1 + 1i*v1;
  plot(x,y,'*g','DisplayName','\Gamma_2');
  plot(partcircle(0,Tr,anglebetween(Tr,g',0)),'-b','LineWidth',2,'DisplayName','eerste TL');
  
  
  h = plot(ray(0,g'),'--b');
  nolegend(h);
  
  Y = (1+g)/(1-g);
  Y2 = -1*1i*imag(Y);
  G2 = (1+Y2)/(Y2-1);
  
  Y3 = Y2/2;
  G3 = (1+Y3)/(Y3-1);
  plot(G2,'*m','DisplayName','\Gamma_3');
  plot(G3,'*m','DisplayName','\Gamma_4' );
  h = plot(ray(0,G3),'--m');
  nolegend(h);
  ang = anglebetween(G3,1)
  plot(partcircle(0,G3,ang),'c','DisplayName','tweede TL');
  
  %ang = -pi+(angle(G2))
  angDeg = ang/(2*pi)*360
  
  ang2 = anglebetween(Tr,x(1)+1i*y(1))
  ang2deg = ang2/(2*pi)*360
end

