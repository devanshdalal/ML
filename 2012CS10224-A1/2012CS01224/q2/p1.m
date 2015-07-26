function [ theta ] = p1( )                    % calculates theta using normal equation
    
    X= importdata( 'q3x.dat' );
    Y= importdata( 'q3y.dat' );
    [m , n]=size(X);
    
    X = [ones(m,1) zscore(X)];                 %  column of ones added in front of normalized X
    
    theta = pinv(X)*Y;                         %  calculation of theta using normal equation pinv(X)=inv(X'*X)*X'
    
    plot(X(:,2), Y,'m.',X(:,2),X*theta,'g-')   % plotting the X vs Y
    hold on;
    title('Graph of training examples and hypothesis function');
    xlabel('input x(i)s ')                     % x-axis label
    ylabel('output y(i)s ')                    % y-axis label
    legend('training examples','final hypothesis','location','southeast');

end

