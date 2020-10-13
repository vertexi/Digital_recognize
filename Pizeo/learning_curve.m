lambda = 0.1;
MaxIter = 1000;
[lamp_x,lamp_y] = simulator();
sample_num = [1:100:1000];
net_vec = [];
metric_vec = [];
for n = sample_num
    net = train(lamp_x, lamp_y, lambda, MaxIter);
    net_vec = [net_vec; net];
    metric_vec = [metric_vec; metric(lamp_x, lamp_y, net)];
    fprintf('%d\n',n);
end
