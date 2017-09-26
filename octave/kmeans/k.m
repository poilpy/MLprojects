data = load('fisheriris.txt');
X = data(:, 3); y = data(:, 4);

figure;
plot(X, y,'k*','MarkerSize', 5);
title 'Fisher''s Iris Data';
xlabel 'sepal Lengths (cm)';
ylabel 'sepal Widths (cm)';


