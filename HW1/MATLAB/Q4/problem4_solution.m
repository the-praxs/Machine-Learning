clc;
clear variables;

%% PART 1 - INITIALIZATION

path = "N:\\My Drive\\Repositories\\ece-gy-6143\\HW1\\MATLAB\\Q4\\Figures\\";       % Set path for saving figures

dataset = load('dataset4.mat');     % Load the dataset

% Assigning values to variables
X = dataset.X;
y = dataset.Y;

% Initializing parameters for Gradient Descent
stepSize = 5;
tolerance = 0.001;
theta = rand(size(X,2), 1);
nIter = 100000;
curIter = 0;
previousTheta = theta + 2 * tolerance;

% Preallocating for speed
empirical_risks = [];
model_classification_errors = [];

%% PART 2 - CALCULATING EMPIRICAL RISK, MODEL CLASSIFICATION ERROR AND GRADIENT

while norm(theta-previousTheta) >= tolerance
    % To check if max iterations are reached
    if curIter > nIter
        break;
    end
    
    % Calculate empirical risk and the model classification error
    risk = calcRisk(X, y, theta);
    f = 1./(1+exp(-X*theta));
    f(f>=0.5) = 1;
    f(f<0.5) = 0;
    error = sum(f~=y)/length(y);
     
    % Calculating the gradient and update theta
    previousTheta = theta;
    gradient = calcGradient(X,y,theta);
    theta = theta-stepSize*gradient;
    curIter = curIter+1;
    
    % Display the error and risk per iteration
    fprintf('Iteration: %d, Error: %0.4f, Risk: %0.4f\n', curIter, error, risk);
    empirical_risks = cat(1, empirical_risks, risk);
    model_classification_errors = cat(1, model_classification_errors, error);
end

%% PART 3 - PLOTTING GRAPHS
figure(1), plot(1:curIter, model_classification_errors, 'r', 1:curIter, empirical_risks, 'b');
title('Error and Risk vs Iterations');
legend('Error', 'Risk');
disp('\nTheta:');
disp(theta);
filename = path + 'Error and Risk vs Iterations.jpeg';      % Figure file saved in Figures subfolder
print(filename, '-djpeg');      % Saving the figures as .jpeg format for high-quality, low space requirements

x=0:0.01:1;
y=(-theta(3) - theta(1).*x)/theta(2);
figure(2), plot(x, y, 'g');
hold on;
plot(X(:,1), X(:,2), 'r.');
title('Linear Decision Boundary');
filename = path + 'Linear Decision Boundary.jpeg';      % Figure file saved in Figures subfolder
print(filename, '-djpeg');      % Saving the figures as .jpeg format for high-quality, low space requirements