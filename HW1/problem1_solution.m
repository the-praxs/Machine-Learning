clear variables;

% Set path for saving figures
path = "N:\\My Drive\\Repositories\\ece-gy-6143\\HW1\\Figures\\";

% Load the dataset, which contains a structure
dataset = load('problem1.mat');

% Assigning structure values to variables
X = dataset.x;
y = dataset.y;

% Checking for the dimension d from 1 to 7 to determine overfitting
for D=1:7
    [err, model] = polyreg(X, y, D);       % Returns the error and model coefficients
    
    title(sprintf('Degree of polynomial (d) = %d', D));     % Saving title for plot with string formatting
    filename = sprintf(path + 'fig_d_%d.jpeg', D);      % Figure files are saved in Figures subfolder
    print(filename, '-djpeg');      % Saving the figures as .jpeg format for high-quality, low space requirements
    
    save('problem1_part1_values.mat', 'err', 'model');      % Save workspace variables
end

close all;


