function numstr = eng(num, varargin)

% numstr = ENG(num, [digits], [digitsaftercomma])
%    returns a string with the engineering notation of the number 'num'
%    e.g. eng(pi*10e3)        uses '%0.5g' and returns '31.416k'
%    e.g. eng(pi*10e3, 7)     uses '%0.7g' and returns '31.41593k'
%    e.g. eng(pi*10e3, [], 6) uses '%0.6f' and returns '31.415927k'
%
% JCx, 29-09-2004

% JCx, 31-10-2003
%   First version
% JCx, 29-09-2004
%   Bugfix for string inputs


% Check string
if ischar(num)
    numstr = num;
    return
end

% Check complex number
if ~isreal(num)
    engreal = eng(real(num));
    engimag = eng(imag(num));
    if strncmp(engimag,'-',1)
        tel = ' - j*';
        engimag = engimag(2:length(engimag));
    else
        tel = ' + j*';
    end
    numstr = [engreal tel engimag];
    return
end

% check magnitude
absnum=abs(num);
if absnum < 1e-21
    numstr = [engformat(num,  varargin{:}) ' '];
elseif absnum < 1e-18
    tmp = floor(log10(absnum)) + 18;
    if nargin < 2
        numstr = [engformat(num*1e18, 6+tmp) 'a'];
    elseif nargin<=2
        digits = varargin{1} + tmp;
        numstr = [engformat(num*1e18, digits), 'a'];
    else
        comma = varargin{2};
        numstr = [engformat(num*1e18, [], comma), 'a'];
    end
elseif absnum < 1e-15
    numstr = [engformat(num*1e18, varargin{:}),'a'];
elseif absnum < 1e-12
    numstr = [engformat(num*1e15, varargin{:}),'f'];
elseif absnum < 1e-9
    numstr = [engformat(num*1e12, varargin{:}),'p'];
elseif absnum < 1e-6
    numstr = [engformat(num*1e09, varargin{:}),'n'];
elseif absnum < 1e-3
    numstr = [engformat(num*1e06, varargin{:}),'u'];
elseif absnum < 1e0
    numstr = [engformat(num*1e03, varargin{:}),'m'];
elseif absnum < 1e+3
    numstr = [engformat(num*1e00, varargin{:}) ' '];
elseif absnum < 1e+6
    numstr = [engformat(num/1e03, varargin{:}),'k'];
elseif absnum < 1e+9
    numstr = [engformat(num/1e06, varargin{:}),'M'];
elseif absnum < 1e+12
    numstr = [engformat(num/1e09, varargin{:}),'G'];
elseif absnum < 1e+15
    numstr = [engformat(num/1e12, varargin{:}),'T'];
else
    numstr = engformat(num, varargin{:});
end


% =========================================================
function engformat = engformat(num, varargin)

% Check optional arguments
digits=6;
if nargin == 2
    digits = varargin{1};;
end

if nargin < 3
    cmd = sprintf('engformat = sprintf(''%%0.%ig'', num);', digits);
else
    comma = varargin{2};
    cmd = sprintf('engformat = sprintf(''%%0.%if'', num);', comma);
end

if abs(num) < 1e-20 | abs(num) >= 1e15
    comma = eval('comma', 'digits-3') - 1;
    cmd = sprintf('engformat = sprintf(''%%0.%ig'', num);', comma);
end

eval(cmd);
