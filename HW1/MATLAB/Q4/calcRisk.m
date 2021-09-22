function risk = calcRisk(x, y, theta)

%
% Calculate Empirical Risk for the function
%
%    function risk = calcRisk(x, y, theta)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% theta = model coefficients
% risk = Empirical Risk of the function
%

    f = 1./(1 + exp(-x * theta));
    risk = (y - 1).*log(1 - f) - y.*log(f);
    risk(isnan(risk)) = 0;
    risk = mean(risk);
    
end