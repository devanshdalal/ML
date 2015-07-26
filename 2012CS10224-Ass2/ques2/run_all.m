function [th1, th2 ] = run_all
%START Neural Network Learning For All Digits
    data = load('mnist_all.mat');
    
    m0 = size(data.train0,1);                     % Setting up tables for training.
    m1 = size(data.train1,1);
    m2 = size(data.train2,1);
    m3 = size(data.train3,1);
    m4 = size(data.train4,1);
    m5 = size(data.train5,1);
    m6 = size(data.train6,1);
    m7 = size(data.train7,1);
    m8 = size(data.train8,1);
    m9 = size(data.train9,1);
    X = [ones(m0+m1+m2+m3+m4+m5+m6+m7+m8+m9,1) zscore(double([ data.train0; data.train1; data.train2; data.train3; 
        data.train4; data.train5; data.train6; data.train7; data.train8; data.train9 ])) ];
    Y = [zeros(m0,1); ones(m1,1); 2*ones(m2,1); 3*ones(m3,1); 4*ones(m4,1); 5*ones(m5,1); 6*ones(m6,1) ; 
        7*ones(m7,1); 8*ones(m8,1); 9*ones(m9,1) ];
    m0 = size(data.test0,1);                       % Setting up tables for testing.
    m1 = size(data.test1,1);
    m2 = size(data.test2,1);
    m3 = size(data.test3,1);
    m4 = size(data.test4,1);
    m5 = size(data.test5,1);
    m6 = size(data.test6,1);
    m7 = size(data.test7,1);
    m8 = size(data.test8,1);
    m9 = size(data.test9,1);
    TX = [ones(m0+m1+m2+m3+m4+m5+m6+m7+m8+m9,1) zscore(double([ data.test0; data.test1; data.test2; data.test3; 
        data.test4; data.test5; data.test6; data.test7; data.test8; data.test9 ])) ];
    TY = [zeros(m0,1); ones(m1,1); 2*ones(m2,1); 3*ones(m3,1); 4*ones(m4,1); 5*ones(m5,1); 6*ones(m6,1) ; 7*ones(m7,1); 8*ones(m8,1); 9*ones(m9,1) ];
    
    disp('data loaded into tables from .mat file');
    [th1, th2] = nn(X,Y,10,TX,TY);
end