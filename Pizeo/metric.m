function F1 = metric(X, Y, net)
    ysim = net(X');
    ysim(ysim<= 0.5) = 0;
    ysim(ysim > 0.5) = 1;
    
    predict_true = sum(ysim==1);
    real_true = sum(Y==1);
    
    ident =(ysim'==Y);
    predict_right_ture = sum(Y(ident)==1);
    presice = predict_right_ture/predict_true;
    recall = predict_right_ture/real_true;
    
    F1 = (2*presice*recall)/(presice+recall);
end