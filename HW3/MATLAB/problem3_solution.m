clc;
clear variables;

%% PART 1 - 
data = load("dataset.mat");

X = data.X;
y = data.Y;

y(y==0) = -1;

%% PART 2 - Splitting the dataset
n = length(X);
trainIdx = randsample(n, n/2);
testIdx = setdiff(1:n, trainIdx);

xtrain = X(trainIdx, :);
xtest = X(testIdx, :);
ytrain = y(trainIdx, :);
ytest = y(testIdx, :);

%% PART 3 -

% classify using polynomials
dmax = 10;
C = linspace(-6,6,12);
err_d = zeros(dmax, numel(C));

global p1 ;
for d=1:dmax
    for c=1:numel(C)
    p1 = d ;
    
    % train
    [nsv, alpha, bias] = svc(xtrain, ytrain, 'poly', c);
    
    % predict
    predictedY = svcoutput(xtrain, ytrain, xtest, 'poly', alpha, bias);
   
    % compute test error
    err_d(d,c) = svcerror(xtrain, ytrain, xtest, ytest, 'poly', alpha, bias);
    end
end

% ploterror vs polynomial degree
f = figure(2);
clf(f);
%plot(1:dmax, err_d);
%var = [1:dmax; err_d].';
surf(err_d);
print(f , '-dpng', 'poly.png');


% classify using rbfs
sigmas = .1:.1:2;
err_sigma = zeros(1 ,numel(sigmas));

for sigma_i=1:numel(sigmas)
    p1 = sigmas(sigma_i);
    
    % train
    [nsv, alpha, bias] = svc(xtrain, ytrain, 'rbf', inf);
    
    % predict
    predictedY = svcoutput(xtrain, ytrain, xtest, 'rbf' , alpha, bias);

    % compute test error
    err_sigma(sigma_i) = svcerror(xtrain, ytrain, xtest, ytest, 'rbf', alpha, bias) ;
end

f = figure(3);
clf(f);
%plot(sigmas , err_sigma);
var = [sigmas; err_sigma].';
hist3(var);
%surface();
print(f , '-dpng', 'rbf.png');