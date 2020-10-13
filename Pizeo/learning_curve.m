lambda = 0.1;
MaxIter = 1000;
[lamp_x,lamp_y] = simulator();
net = train(lamp_x,lamp_y,lambda,MaxIter);
metric(lamp_x, lamp_y, net)