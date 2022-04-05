function [xZero, abortFlag, iters] = myNewton(varargin)
%myNewton - calculate the y value for the functions zero point
%calculates the y value of a functions zero point
%
% Syntax:  [xZero, abortFlag, iters] = myNewton(varargin)
%
% Inputs:
%    varargin := array of different element pairs (see following lines)
%    'Function', func := function to calculate the zero point from
%    'Derivative', dfunc := derivative of function (optional)
%    'StartValue', x0 := x value to start the calculation with (optional)
%    'MaxIters', maxIters := maximum number of iterations (optional)
%    'Feps', feps := configure feps value (optional)
%    'Xeps', xeps := configure xeps value (optional)
%    'LivePlot', livePlot := turn livePlot 'on'/'off' (optional)
%
% Outputs:
%    xZero := x value of calculated zero point
%    abortFlag := gives information about type of abortion
%    iters := number of iterations
%
% Example: 
%    [xZero, abortFlag, iters] = myNewton('Function', @myPoly);
%
% Other m-files required: numDiff.m
% Subfunctions: numDiff
% MAT-files required: none
%
% See also: numDiff
% Author: Maurice Tonn
% Palmenwaldstraße 50, 73733 Esslingen
% email: mauricetonn@gmail.com
% April 2022; Last revision: 05-April-2022
%------------- BEGIN CODE --------------
%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};
    end
end

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end

if ~exist('dfunc', 'var')
    answer = questdlg('Which kind of Approximation Method would you like to use', ...
        'No Derivative found', ...
        'Forwards', 'Backwards', 'Central', 'Forwards');
end
switch answer
    case 'Forwards'
        disp([answer, '-Method will be used'])
        method = 'forward';
    case 'Backwards'
        disp([answer, '-Method will be used'])
        method = 'backward';
    case 'Central'
        disp([answer, '-Method will be used'])
        method = 'central';
    otherwise
        method = 'forward';
end
    
if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

%% start of algorithm
if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if f < feps
        abortFlag = 'feps';
        break;
    end
    if ~exist('dfunc', 'var')
        df = numDiff(func, xOld, method);
    else 
        df = dfunc(xOld);
    end

    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
%------------- END OF CODE --------------
end