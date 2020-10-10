alpha = 5;
x = [0 : 0.01 : 1];
y = alpha*x./(1+(alpha-1)*x);
plot(x,y);