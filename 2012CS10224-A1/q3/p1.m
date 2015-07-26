function [   ] = p1( )                                 % logistic regression using Newtoin's method
    X= importdata( 'q2x.dat' );
    Y= importdata( 'q2y.dat' );
    [m , n]=size(X);
    X = [ones(m,1) zscore(X)];                              %  column of ones added in front of normalized X
    
    theta = ones(n+1,1);
    eps = 0.0000001;   i=0; d=theta;                        %  setting up iter count,d and eps
    
    while( abs(d'*d)>eps )                                  % convergence criterion
        p = 1./(1+exp(- X*theta));
        W = diag( p.*(1-p));                                % W matrix calculation for calculating delta d
        d = (X'*W*X)\X'*(Y-p);                              % delta d vector calculation for update of theta
        theta = theta + d;
        i=i+1;
    end
    i
    theta
    
%     plot(X(:,2),-(theta(1)+theta(2)*X(:,2) )/theta(3),'g-')
%     hold on
%     for j=1:m                                            % plotting the points of different classes with different colors
%         if( Y(j)==1 )
%             plot(X(j,2),X(j,3),'r.')
%         else
%             plot(X(j,2),X(j,3),'b+')
%         end
%     end
%     title('Newton methetaod convergence for logistic regression');
%     xlabel('x1 -> ')                                     % x-axis label
%     ylabel('x2 -> ')                                     % y-axis label
%     legend('sepating boundary','training examples','location','southeast');
%     fprintf('Number of Iterations: %d .\n',i)
end
