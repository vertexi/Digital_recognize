% get the imgdata and labels that all imgdata just contain 0 or 1.
clear;
load training_set.mat
% nn_params = train_parameter(x, y, hidden_layer_size, penalize)
y = labels;
x = temp_imgs;
x(find(x<0.8)) = 0;
x(find(x~=0)) = 1;
y(find(y==0))=10;
%%
% seperate the training set to train/cross validation/test sets(0.6:0.2:0.2)
train_set = x(1:floor((length(temp_imgs)*0.6)),:);
train_set_label = y(1:floor((length(temp_imgs)*0.6)));
cv_set = x((length(train_set_label)+1):(length(train_set_label)+1)+floor((length(temp_imgs)*0.2)),:);
cv_set_label = y((length(train_set_label)+1):(length(train_set_label)+1)+floor((length(temp_imgs)*0.2)));
test_set = x(((length(train_set_label)+1)+floor((length(temp_imgs)*0.2))+1):end,:);
test_set_label = y(((length(train_set_label)+1)+floor((length(temp_imgs)*0.2))+1):end);
%%
% training different parameters pairs and evaluate the cv_errors
num_labels = 10;
input_layer_size = 400;
result = [];
for hidden_layer_size = [10 30 60 100 130 160 200]
    for penalize = [0.01 0.03 0.1 0.3 1 3 10 100]
        nn_params = train_parameter(train_set, train_set_label, hidden_layer_size, penalize);
        
        Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
            hidden_layer_size, (input_layer_size + 1));
        Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
            num_labels, (hidden_layer_size + 1));
        
        cv_label_temp = predict(Theta1, Theta2, cv_set);
        result_temp = mean(cv_label_temp == cv_set_label);
        result = [result; result_temp];
        
        fprintf("%d %.2f %.2f\n",hidden_layer_size, penalize, result_temp);
    end
end
% best 100 0.1 prob:0.9530