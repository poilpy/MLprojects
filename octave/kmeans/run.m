
clear ; close all; clc


fprintf('\nRunning K-Means clustering\n\n');


importfile;
scatter(PL, PW);

fprintf('Press enter to continue.\n');
pause;

K = 3;
max_iters = 10;
X = [PL, PW, SL, SW];

initial_centroids = kMeansInitCentroids(X, K);
% initial_centroids = [  48,  32;
%    59,  32;
%    49,  30 ];


[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
fprintf('\nK-Means Done.\n\n');

figure
% Create palette
palette = hsv(K);
colors = palette(TYPE+1, :);

% Plot the data
scatter(PL, PW, 15, colors);

