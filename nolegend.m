function [  ] = nolegend( h )
%NOLEGEND Prevents the legend from showing the object with handle h
%  Usage:
%   h = plot(...)
%   nolegend(h)
   set(get(get(h,'Annotation'),'LegendInformation'),...
   'IconDisplayStyle','off'); % Exclude line from legend
end

