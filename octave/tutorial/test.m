x = linspace(-pi, pi, 100);
y = abs(tan(x));
z = diff(y);
figure;
plot(y);
figure;
plot(z);
