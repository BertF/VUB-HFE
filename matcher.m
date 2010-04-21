function [ res, H ] = matcher(Tr)
%MATCHER Matches reflection factors with integrated smith charts
% Tr: required reflection factor
% mode: matching mode (not used)
% file: file name for tex output
  H = scDraw(0); hold on;
  dir = -1; % towards load
  %% reflectiefactor uitzetten op SC
  Gamma1 = -Tr;
  plot(Gamma1,'*b','DisplayName','\Gamma_1');
  
  h = plot(ray(0,Gamma1),'--b','DisplayName','hulplijn \Gamma_1');
  nolegend(h);
  
  h = plot(circle(0,norm(Gamma1),100),'-.b','DisplayName','hulplijn TL_1');
  nolegend(h);
  
  %% juiste snijpunt kiezen
  [x,y] = POI(0.5,0.5,0,norm(Gamma1));
  ang = zeros(size(x));
  for i = 1:numel(x)
      ang(i) = anglebetween(Gamma1,x(i) + 1i * y(i),0,dir);
  end;
  disp(ang);
  i = find(ang == min(ang));
  Gamma2 = x(i) + y(i) * 1i;
  
  %% snijpunt gekozen
  plot(Gamma2,'*g','DisplayName','\Gamma_2');
  plot(partcircle(0,Gamma1,Gamma2,dir),'-b','LineWidth',2,'DisplayName','TL_1');
  
  h = plot(ray(0,Gamma2),'--g','DisplayName','hulplijn \Gamma_2');
  nolegend(h);
  
  %% lengte TL1 bepalen
  ang = anglebetween(Gamma1,Gamma2,0,-1);
  angDeg = ang/(2*pi)*360;
  L1 = angDeg/360*(1/2);
  E1 = L1*360;
  
  %% eigenschappen van snijpunt bepalen
  Y2 = getZ(Gamma2);
  Y3 = 1i*imag(Y2);
  Gamma3 = getG(Y3);
  plot(Gamma3,'*c','DisplayName','\Gamma_3');
  h = plot(ray(0,Gamma3),'--c');
  nolegend(h);
  
  %% matchingspecifiek: parallelmatch met symmetrische stubs forceren
  Y4 = Y3/2;
  Gamma4 = getG(Y4);
  plot(Gamma4,'*m','DisplayName','\Gamma_4');
  h = plot(ray(0,Gamma4),'--m');
  nolegend(h);
  
  %% elektrische lengte stubs bepalen
  stubterm1 = 'open'; Gstub1 = 1+0*1i;
  stubterm2 = 'short'; Gstub2 = -1+0*1i; 
  
  angstub1 = anglebetween(Gamma4,Gstub1,0,dir);
  angstub2 = anglebetween(Gamma4,Gstub2,0,dir);
  if angstub1 < angstub2
      stubterm = stubterm1;
      Gstub = Gstub1;
      ang2 = angstub1;
  else
      stubterm = stubterm2;
      ang2 = angstub2;
      Gstub = Gstub2;
  end;
  plot(Gstub,0,'*k','DisplayName','Terminatie');
  plot(partcircle(0,Gamma4,Gstub,dir),'m','LineWidth',2,'DisplayName','TL_2 (stub)');
  
  ang2Deg = ang2/(2*pi)*360;
  L2 = ang2Deg/360*(1/2);
  E2 = L2*360;
  
  %% export values
  res = struct('name','matching network');
  res.Gamma1 = Gamma1;
  res.Gamma2 = - Gamma2; % mintekens: van getekende ZSC naar YSC transformeren
  res.Gamma3 = - Gamma3;
  res.Gamma4 = - Gamma4;
  res.stubterm = stubterm;
  res.Y2 = Y2;
  res.Y3 = Y3;
  res.Y4 = Y4;
  res.ang1 = ang;
  res.ang2 = ang2;
  res.angunit = 'radian';
  res.ang1deg = angDeg;
  res.ang2deg = ang2Deg;
  res.E1 = E1;
  res.E2 = E2;
  res.Eunit = 'degree';
  res.L1 = L1;
  res.L2 = L2;
  res.Lunit = '\lambda';
  

  H = gcf;
end

