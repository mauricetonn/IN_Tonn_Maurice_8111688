function yAprox = numDiff(func, x, method)
%numDiff - calculate value of derivative at point x of function func
%with three methods: Vorwaerts-, Rueckwaerts & Zentraldifferenzieren
%
% Syntax:  y = numDiff(func, x, method)
%
% Inputs:
%    func := function
%    x := x value
%    method := method name
%
% Outputs:
%    y := y value of the derivative at x
%
% Example: 
%    y = numDiff(@myPoly, 9, 'forward')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: myNewton
% Author: Maurice Tonn
% Palmenwaldstraße 50, 73733 Esslingen
% email: mauricetonn@gmail.com  
% April 2022; Last revision: 05-April-2022
%------------- BEGIN CODE --------------
%% Forward
if strcmp(method, 'forward')
    h = 10^-8;
    yAprox = (func(x+h)-func(x))/h;
%% Backward
elseif strcmp(method, 'backward')
    h = 10^-8;
    yAprox = (func(x) - func(x-h))/h;
%% Central
elseif strcmp(method, 'central')
    h = 10^-6;
    yAprox = (func(x+h) - func(x-h))/(2*h);
end
%------------- END OF CODE --------------
end
