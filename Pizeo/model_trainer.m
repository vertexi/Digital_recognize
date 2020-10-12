function output = model_trainer(X, Y)
    lambda = 0.1;
    MaxIter = 100;
    net = imageNet(X, Y, lambda, MaxIter);
    [~, ysim] = max(net(X'));
    fprintf('Training accuracy: %g%%', sum(Y == ysim') / length(Y));
end