function [  ] = p2( tau )                                           % main function for weighted regression
    
    X= importdata( 'q3x.dat' );
    Y= importdata( 'q3y.dat' );
    [m , n]=size(X);
%     X = [ones(m,1) X];                                             %  column of ones added in front of normalized X.
    X = [ones(m,1) zscore(X)];
    
    xseries = -2:0.01:2;
    l = size(xseries);
    yseries = zeros(1,l(2));
    
    for i=1:l(1,2)
        xd=(xseries(1,i)*ones(m,1))-X(:,2);
        W= diag( exp((xd.*xd)/(-2*tau*tau)));                        %  setting up the required diagonal matrix
        U=(X'* W* X);
        V=(X'*W*Y);
        theta=U\V;                                                   %  required theta
        yseries(1,i) = theta(1,1) + theta(2,1)*xseries(1,i) ;
    end                                                  
    
    plot(X(:,2), Y,'m*',xseries,yseries,'g-')                        % plotting the data
    hold on
    title([' Weighted linear regression with tau = ',num2str(tau)]);
    xlabel('input x(i)s ');                                          % x-axis label
    ylabel('output y(i)s ');                                         % y-axis label
    legend('training examples','final hypothetaesis','location','southeast');
end