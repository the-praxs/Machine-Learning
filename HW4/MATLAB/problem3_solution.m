clc;
clear variables;

load('teapots.mat');
data = teapotImages;

u = mean(data);
X = data - u;

f = figure(1);
imagesc(reshape(u, 38, 50));
title('Mean of all images');
colormap gray;
print(f , '-dpng', 'mean.png');

coef = cov(X);
[V, D] = eig(coef);

[d, index] = sort(diag(D), 'descend');
d = d(1:3, :);
v = V(:, index(1:3));

disp('Top 3 Eigenvalues:');
disp(d);

f = figure(2);
imagesc(reshape(V(:, index(1)), 38, 50));
title(sprintf('Eigenvalue = %.3f', d(1)));
colormap gray;
print(f , '-dpng', 'eigenvalue1.png');

f = figure(3);
imagesc(reshape(V(:, index(1)), 38, 50));
title(sprintf('Eigenvalue = %.3f', d(2)));
colormap gray;
print(f , '-dpng', 'eigenvalue2.png');

f = figure(4);
imagesc(reshape(V(:, index(1)), 38, 50));
title(sprintf('Eigenvalue = %.3f', d(3)));
colormap gray;
print(f , '-dpng', 'eigenvalue3.png');

c = X*v;
X_hat = u + c*v';

for i=51:60
    ii = i-46;
    figure(ii);
    colormap gray;
    subplot(1,2,1);
    imagesc(reshape(data(i,:), 38, 50));
    title('Before Reconstruction');
    axis image;
    subplot(1, 2, 2);
    imagesc(reshape(X_hat(i, :), 38, 50));
    title('After Reconstruction');
    axis image;
    filename = sprintf('Image No. %d.jpeg', i);
    print(filename, '-dpng');
end

n = norm(data-X_hat);
disp('Normalized Value:');
disp(n); 