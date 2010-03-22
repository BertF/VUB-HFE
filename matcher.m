function [ H, res ] = matcher(Ti, Tr, mode, file)
%MATCHER Matches reflection factors with integrated smith charts
% Ti: reflection factor to start from
% Tr: required reflection factor
% mode: matching mode (not used)
% file: file name for tex output
  H = scDraw(0); hold on;
  
  %% reflectiefactor uitzetten op SC
  Gamma1 = Tr;
  plot(Gamma1,'*b','DisplayName','\Gamma_1');
  
  h = plot(ray(0,Gamma1),'--b','DisplayName','hulplijn \Gamma_1');
  nolegend(h);
  
  h = plot(circle(0,norm(Gamma1),100),'-b','DisplayName','hulplijn TL_1');
  nolegend(h);
  
  %% juiste snijpunt kiezen
  [x,y] = POI(0.5,0.5,0,norm(Gamma1));
  %FIXME: juiste punt kiezen: kleinste hoek
  u1 = x(2); v1 = y(2);
  g = u1 + 1i*v1;
  Gamma2 = g;
  
  %% snijpunt gekozen
  plot(Gamma2,'*g','DisplayName','\Gamma_2');
  plot(partcircle(0,Tr,anglebetween(Tr,g',0)),'-b','LineWidth',2,'DisplayName','TL_1');
  
  h = plot(ray(0,g'),'--b','DisplayName','hulplijn \Gamma_2');
  nolegend(h);
  
  %% lengte TL1 bepalen
  ang = anglebetween(Tr,x(1)+1i*y(1))
  angDeg = ang/(2*pi)*360
  
  %% eigenschappen van snijpunt bepalen
  Y2 = getZ(g);
  Y3 = 1i*imag(Y2);
  Gamma3 = getG(Y3);
  plot(Gamma3,'*m','DisplayName','\Gamma_3');
  h = plot(ray(0,Gamma3),'--m');
  nolegend(h);
  
  %% matchingspecifiek: parallelmatch met symmetrische stubs forceren
  Y4 = Y3/2;
  Gamma4 = getG(Y4);
  plot(Gamma4,'*m','DisplayName','\Gamma_4');
  
  %% elektrische lengte stubs bepalen
  stubterm = 'open';
  ang2 = anglebetween(Gamma4,1)
  plot(partcircle(0,Gamma4,ang),'c','DisplayName','TL_2 (stub)');
  
  ang2Deg = ang2/(2*pi)*360
  
  %% export values
  res = struct('name','matching network');
  res.Gamma1 = Gamma1;
  res.Gamma2 = Gamma2;
  res.Gamma3 = Gamma3;
  res.Gamma4 = Gamma4;
  res.stubterm = stubterm;
  res.Y2 = Y2;
  res.Y3 = Y3;
  res.Y4 = Y4;
  res.ang1 = ang;
  res.ang2 = ang2;
  res.ang1deg = angDeg;
  res.ang2deg = ang2Deg;
  
  %% make tex
  
  
end

