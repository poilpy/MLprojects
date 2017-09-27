
clear ; close all; clc


fprintf('\nRunning K-Means clustering\n\n');

X = load('fisheriris.txt');
X = X(:, 3:4);

K = 3;
max_iters = 10;

initial_centroids = kMeansInitCentroids(X, K);

[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
fprintf('\nK-Means Done.\n\n');

