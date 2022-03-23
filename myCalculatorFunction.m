function returnValue = myCalculatorFunction(varargin)

operator = varargin{find(strcmp('op', varargin))+1};
value1 = varargin{find(strcmp('value1', varargin))+1};
value2 = varargin{find(strcmp('value2', varargin))+1};

switch operator
    case '+'
        returnValue = value1 + value2;
    case '-'
        returnValue = value1 - value2;
    case '*'
        returnValue = value1 * value2; 
    case '/'
        returnValue = value1 / value2;
    otherwise
        error('Invalid Operator')
end

end