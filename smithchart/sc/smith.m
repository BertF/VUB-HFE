function hpol = smith(zeta,line_style)
%SMITH  Smith chart plot.
%   SMITH(ZETA) makes a plot of ZETA using a conformal (Moebius)
%   mapping, i.e. in Smith chart coordinates.
%   It is assumed that the data is normalized to the reference
%   impedance, e.g. 50 Ohm
%   SMITH(ZETA,S) uses the linestyle specified in string S.
%   See PLOT for a description of legal linestyles.
%
%   See also PLOT, LOGLOG, SEMILOGX, SEMILOGY, POLAR.

%   Copyright 1984-2001 The MathWorks, Inc. 
%   $Revision: 5.21 $  $Date: 2001/04/15 12:00:43 $
%   Modified from POLAR by dr.ing. Mikael Hammer, NTNU, Trondheim
%   15.04.03

if nargin < 1
    error('Requires 1 or 2 input arguments.')
elseif nargin == 1
    line_style = 'auto';
end
if isstr(zeta)
    error('First input argument must be numeric.');
end

% get hold state
cax = newplot;
next = lower(get(cax,'NextPlot'));
hold_state = ishold;

% get x-axis text color so grid is in same color
tc = get(cax,'xcolor');
ls = get(cax,'gridlinestyle');

% Hold on to current Text defaults, reset them to the
% Axes' font attributes so tick marks use them.
fAngle  = get(cax, 'DefaultTextFontAngle');
fName   = get(cax, 'DefaultTextFontName');
fSize   = get(cax, 'DefaultTextFontSize');
fWeight = get(cax, 'DefaultTextFontWeight');
fUnits  = get(cax, 'DefaultTextUnits');
set(cax, 'DefaultTextFontAngle',  get(cax, 'FontAngle'), ...
    'DefaultTextFontName',   get(cax, 'FontName'), ...
    'DefaultTextFontSize',   get(cax, 'FontSize'), ...
    'DefaultTextFontWeight', get(cax, 'FontWeight'), ...
    'DefaultTextUnits','data')

% only do grids if hold is off
if ~hold_state

% Convert zeta to S parameters (special fix to cope with division by zero)
Numerator=zeta - 1;
Denominator=zeta + 1;
epsilon=1e-6;
for i=1:length(Denominator)
    if Denominator(i) == 0
        Denominator(i)=Denominator(i) + epsilon;
    end
end
S=Numerator./Denominator;
    
%% make a radial grid
    hold on;
    maxs = max(abs(S(:)));
    hhh=plot([-maxs -maxs maxs maxs],[-maxs maxs maxs -maxs]);
    set(gca,'dataaspectratio',[1 1 1],'plotboxaspectratiomode','auto')
    v = [get(cax,'xlim') get(cax,'ylim')];
    ticks = sum(get(cax,'ytick')>=0);
    delete(hhh);
% check radial limits and ticks
    rmin = 0; rmax = v(4); rticks = max(ticks-1,2);
    if rticks > 5   % see if we can reduce the number
        if rem(rticks,2) == 0
            rticks = rticks/2;
        elseif rem(rticks,3) == 0
            rticks = rticks/3;
        end
    end

%% define a circle
    th = 0:pi/50:2*pi;
    xunit = cos(th);
    yunit = sin(th);
%% now really force points on x/y axes to lie on them exactly
    inds = 1:(length(th)-1)/4:length(th);
    xunit(inds(2:2:4)) = zeros(2,1);
    yunit(inds(1:2:5)) = zeros(3,1);
% plot background if necessary
    if ~isstr(get(cax,'color')),
       patch('xdata',xunit*rmax,'ydata',yunit*rmax, ...
             'edgecolor',tc,'facecolor',get(gca,'color'),...
             'handlevisibility','off');
    end

%% draw radial circles
%    c82 = cos(82*pi/180);
%    s82 = sin(82*pi/180);
%    rinc = (rmax-rmin)/rticks;
%    for i=(rmin+rinc):rinc:rmax
%        hhh = plot(xunit*i,yunit*i,ls,'color',tc,'linewidth',1,...
%                   'handlevisibility','off');
%        text((i+rinc/20)*c82,(i+rinc/20)*s82, ...
%            ['  ' num2str(i)],'verticalalignment','bottom',...
%            'handlevisibility','off')
%end
%    set(hhh,'linestyle','-') % Make outer circle solid

% draw circles of Smith chart
    rotation=[1 j -1 -j];
    cirangle=0:(0.01*2*pi):(2*pi);
    cirradii=[0.1 0.2 0.5 0.7 1 2 3 4 5];
    for q=1:4
        for r=1:length(cirangle)
            for s=1:length(cirradii)
                pt=rotation(q)*(cirradii(s)*exp(j*cirangle(r))+cirradii(s))+1;
                if (abs(pt) < maxs)
                    hold on;
                    plot(pt,ls,'color',tc,'linewidth',1,...
                        'handlevisibility','off')
                end
            end
        end
    end
    
% plot x and y axes to indicate origin
    th = (1:4)*pi/2;
    cst = cos(th); snt = sin(th);
    cs = [-cst; cst];
    sn = [-snt; snt];
    plot(rmax*cs,rmax*sn,ls,'color',tc,'linewidth',1,...
         'handlevisibility','off')

%% annotate spokes in degrees
%    rt = 1.1*rmax;
%    for i = 1:length(th)
%        text(rt*cst(i),rt*snt(i),int2str(i*30),...
%             'horizontalalignment','center',...
%             'handlevisibility','off');
%        if i == length(th)
%            loc = int2str(0);
%        else
%            loc = int2str(180+i*30);
%        end
%        text(-rt*cst(i),-rt*snt(i),loc,'horizontalalignment','center',...
%             'handlevisibility','off')
%    end

% set view to 2-D
    view(2);
% set axis limits
    axis(rmax*[-1 1 -1.15 1.15]);
end

% Reset defaults.
set(cax, 'DefaultTextFontAngle', fAngle , ...
    'DefaultTextFontName',   fName , ...
    'DefaultTextFontSize',   fSize, ...
    'DefaultTextFontWeight', fWeight, ...
    'DefaultTextUnits',fUnits );

% plot data on top of grid
if strcmp(line_style,'auto')
    hold on;
    q = plot(real(S),imag(S));
else
    hold on;
    q = plot(real(S),imag(S),line_style);
end
if nargout > 0
    hpol = q;
end
if ~hold_state
    set(gca,'dataaspectratio',[1 1 1]), axis off; set(cax,'NextPlot',next);
end
set(get(gca,'xlabel'),'visible','on')
set(get(gca,'ylabel'),'visible','on')


