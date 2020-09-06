function nn_params = train_parameter(x, y, hidden_layer_size, penalize)
m = size(y,1);
% y = labels;
% x = temp_imgs;

x(find(x<0.8))=0;
x(find(x~=0))=1;
% x = [x, x.^2];
% sigma = std(x);
% th = mean(x);
% x = x - th;
% for aaa = 1:size(x,2)
%     x(:,aaa) = x(:,aaa)/sigma(aaa);
% end
input_layer_size = 400;
% hidden_layer_size = 30;
num_labels = 10;
% penalize = 1;
costFunc = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, ...
                               num_labels, x, y, penalize);
for kk = 1:2
    init_para_1 = randInitializeWeights(input_layer_size,hidden_layer_size);
    init_para_2 = randInitializeWeights(hidden_layer_size,num_labels);
    init_para_temp(:,kk) = [init_para_1(:);init_para_2(:)];
    cost(kk) = costFunc(init_para_temp(:,kk));
end
[fval, index]=min(cost);
init_para = init_para_temp(:,kk);
options = optimset('MaxIter', 200);
[nn_params, ~] = fmincg(costFunc, init_para, options);
%% 
% Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
%                  hidden_layer_size, (input_layer_size + 1));
% 
% Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
%                  num_labels, (hidden_layer_size + 1));
% temp_y = sigmoid(Theta2*[ones(1, m);sigmoid(Theta1*[ones(m, 1), x]')]);
% temp_y = temp_y';
end