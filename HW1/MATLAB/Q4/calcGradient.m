function gradient = calcGradient(x, y, theta)

%
% Calculate gradient of a function
%
%    function gradient = calcGradient(x, y, theta)
%
% x = vector of input scalars
% y = vector of output scalars
% theta = model coefficients
% gradient = gradient of the function
%

    yy = repmat(y, 1, size(x, 2));
    f = 1./(1 + exp(-x * theta));
    ff = repmat(f, 1, size(x, 2));
    d = x.*repmat(exp(-x * theta ), 1, size(x, 2));
    gradient = (1 - yy ).*(x - d.*ff ) - yy.*d.*ff;
    gradient = sum(gradient ) ;
    gradient = (gradient/length(y ))';
    
end
