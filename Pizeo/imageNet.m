function net = imageNet(X, Y, lambda, MaxIter)
    % Build, train, and return a neural network model to classify the 1x400 images
    % of digits in X with labels in Y

    % MATLAB neural networks prefer examples in columns and labels in rows
    X = X';
    Y = Y';

    % Set network options:
    hiddenLayerSize = 25; % Create a neural net with a single hidden layer with 25 output neurons
    trainFcn = 'trainscg'; % Use scaled conjugate gradient backpropagation
    net = patternnet(hiddenLayerSize, trainFcn); % Create the net variable
    net.layers{1}.transferFcn = 'logsig'; % Change default transfer function to match ex3/4 implementation

    % Add regularization:
    % Note that the MATLAB regularization parameter must lie between 0 and 1,
    % where 0 correspnds to lambda = 0 (no regularization) and 1 corresponds to lambda = inf.
    % We map the input lambda value to [0,1] using tanh function
    net.performParam.regularization = tanh(lambda);
    net.trainParam.epochs = MaxIter;
    net.trainParam.showWindow = false; % Don't show training GUI

    % Setup Division of Data for Training, Validation, Testing
    % This example uses all of the data for training (to match ex3/ex4 network example)
    % Validation and test data is discussed later in the course
    % I modified it to 8/1/1 crossvalidation
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 10/100;
    net.divideParam.testRatio = 10/100;

    % Train the Network
    net = train(net, X, Y);
end