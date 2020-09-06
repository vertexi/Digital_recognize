clear
load training_set.mat
% nn_params = train_parameter(x, y, hidden_layer_size, penalize)
y = labels;
x = temp_imgs;
x(find(x<0.8)) = 0;
x(find(x~=0)) = 1;
y(find(y==0))=10;

input_layer_size = 400;
hidden_layer_size = 100;
penalize = 0.1;

nn_params = train_parameter(x, y, hidden_layer_size, penalize);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
    hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
    10, (hidden_layer_size + 1));
mean(predict(Theta1, Theta2, x)==y)