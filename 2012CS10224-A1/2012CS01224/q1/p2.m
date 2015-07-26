function [ theta  ] = p2(ita,eps)             % batch gradient algorithm
    X= importdata( 'q1x.dat' );
    Y= importdata( 'q1y.dat' );
    [m , n]=size(X);
    
    X = [ones(m,1) zscore(X)];               %  column of ones added in front of normalized X
    
    theta = zeros(n+1,1);                    %  theta initialized to zeros' vector of size 
    d=X'*Y;                                  %  delta vector initialization: d=X'(Y-X*theta)

    ita=ita/m;  i=0;                         %  setting up iter count and ita
    
    while(ita>0.000001)
        while(abs(d'*d)>eps)
            d =  X'*(Y - X*theta) ;          %  delta calculation from previous theta
            theta = theta +  ita*d;          %  ntheta = new value of theta
            i=i+1;
        end
        ita=ita/2;                           %  halve the learning rate to avoid jumping the minima
    end
    fprintf('Number of Iterations: %d .\n',i)
    
%     plot(X(:,2), Y, 'rx', 'MarkerSize', 10)
    plot(X(:,2), Y,'m*',X(:,2),X*theta,'g-') % plotting the data
    hold on;
    title('Graph of training examples and hypothesis function');
    xlabel('input x(i)s ')                   % x-axis label
    ylabel('output y(i)s ')                  % y-axis label
    legend('training examples','final hypothesis','location','southeast');
    
end