function F1 = metric(X, Y)
    lambda = 0.1;
    MaxIter = 1000;
    net = train(X, Y, lambda, MaxIter);
    ysim = net(lamp_x');
    ysim(ysim<= 0.5) = 0;
    ysim(ysim > 0.5) = 1;
    
    
end