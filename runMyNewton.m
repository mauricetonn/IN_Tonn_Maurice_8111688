% Other m-files required: myNewton.m, myFunc.m
% Subfunctions: myNewton, myPoly, dmyPoly (optional)
% MAT-files required: none
%
% See also: myNewton, numDiff, myPoly, dmyPoly
% Author: Maurice Tonn
% Palmenwaldstra�e 50, 73733 Esslingen
% email: mauricetonn@gmail.com
% April 2022; Last revision: 05-April-2022

%% clear the workspace & close all opened plots
clear; clc; close all;

%% call function
[xZero, abortFlag, iters] = myNewton('function', @myPoly, 'livePlot', 'on')
