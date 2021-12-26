clc;
clear variables;

TransitionProbabilities = [0.8, 0.2; 0.2, 0.8];
EmissionProbabilities = [0.4, 0.1, 0.3, 0.2; 0.1, 0.4, 0.2, 0.3];
ObservedStates = [1, 4, 2, 2, 3];
InitialProbabilities = [1; 0];

tSize = size(TransitionProbabilities, 1);
nSize = size(ObservedStates, 2);
psi = zeros(tSize, tSize, nSize);
phi = zeros(tSize, nSize);
phi(:, 1) = InitialProbabilities;

% Forward
for i = 2:nSize
    k = ObservedStates(1, i);
    psi(:, :, i) = diag(phi(:, i - 1)) *TransitionProbabilities * diag(EmissionProbabilities(:,k));
    phi(:, i) = max(psi(:, :, i));
end

% Backward
for i = nSize-1:-1:1
    phi_new = max(psi(:, :, i + 1), [], 2);
    psi(:, :, i) = psi(:, :, i) * diag(phi_new ./ phi(:, i));
    phi(:, i) = phi_new;
end

[~, HiddenStates] = max(phi);

disp('Emotional States of Mario:');
for i=1:size(HiddenStates,2)
    fprintf('Day %d: ', i);
    if(HiddenStates(i)==1)
        disp('Happy');
    else
        disp('Angry');
    end
end