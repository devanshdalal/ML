function [th1, th2] = run38
%START Neural Network Learning For 3 and 8 Only

    data = load('mnist_bin38.mat');
    
    m1 = size(data.train3,1);                     % Setting up tables for training.
    m2 = size(data.train8,1);
    X = [ones(m1,1)  zscore(double(data.train3)); ones(m2,1)  zscore(double(data.train8))];
    Y = [zeros(m1,1); ones(m2,1)];
    
    t1 = size(data.test3,1);                      % Setting up tables for testing.
    t2 = size(data.test8,1);
    TX = [ones(t1,1)  zscore(double(data.test3)); ones(t2,1)  zscore(double(data.test8))];
    TY = [zeros(t1,1); ones(t2,1)];
    
    [th1, th2]=nn(X,Y,2,TX,TY);

end