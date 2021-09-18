clc;
clear variables;

%% PART 1 - DIVIDING DATA INTO TRAINING AND TESTING SET USING CROSS-VALIDATION

path = "N:\\My Drive\\Repositories\\ece-gy-6143\\HW1\\MATLAB\\Q2\\Figures\\";       % Set path for saving figures

dataset = load('problem2.mat');     % Load the dataset which contains a structure

% Assigning structure values to variables
X = dataset.x;
y = dataset.y;

% Initializing values of penalty parameter lambda int lambdas array
lambdas = 0:2000;

% Dividing data into training and testing sets
[length, ~] = size(X);
idx = crossvalind('KFold', length, 2);

% Training data
train = (idx==1);
X_train = X(train,:);
y_train = y(train);

% Testing data
test = (idx==2);
X_test = X(test,:);
y_test = y(test);

% Preallocating variables for speed optimization
model_training_errors = [];
model_testing_errors = [];
model_coefficients = {};

%% PART 2 - TRAINING AND TESTING FOR THE RIDGE REGRESSION MODEL

% Checking for lambda to determine training and testing risk
for lambda=lambdas
    [err, model, errT] = ridgereg(X_train, y_train, lambda, X_test, y_test);        % Returns the error and model coefficients
    
    model_training_errors(lambda+1) = err;     
    model_testing_errors(lambda+1) = errT;     
    model_coefficients{lambda+1} = model;
end

% Determine minimum testing error and corresponding lambda value
[~, idx] = min(model_testing_errors);
min_lambda = lambdas(idx);
min_model_testing_error = model_testing_errors(idx);

save('problem2_values.mat', 'err', 'errT', 'model');      % Save workspace variables

% Display the values of minimum testing error and d
fprintf('Minimum Testing Error = %f for penalty paramter lambda = %d \n', min_model_testing_error, min_lambda);

% Clear figure handles
close all;
hold on;

% Plot model training and testing errors against lambda values
plot(lambdas, model_training_errors, 'b');
plot(lambdas, model_testing_errors, 'r');

plot(min_lambda, min_model_testing_error, 'rX');    % Mark minimum testing error value corresponding to lambda with red X

% Set plot labels and legend
xlabel('Penalty Parameter \lambda');
ylabel('Error');
legend('Training', 'Testing');
text(min_lambda, min_model_testing_error, sprintf('Value=%d', min_lambda));

title('Training and Testing Errors with Penalty Parameter \lambda');     % Saving plot title
filename = 'fig_cross_validation_error_lambda.jpeg';      % Figure file saved in Figures subfolder
print(path+filename, '-djpeg');      % Saving the figures as .jpeg format for high-quality, low space requirements