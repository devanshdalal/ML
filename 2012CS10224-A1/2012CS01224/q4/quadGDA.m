function [  ] = quadGDA( )
    X= importdata( 'q4x.dat' );
    Y= importdata( 'q4y.dat' );
    [m , n]=size(X);
    X = zscore(X);                                       %  column of ones added in front of normalized X
    Y=arrayfun(@(z) strcmp(z,'Alaska'),Y); 
    
    u0 = zeros( 1 , n );                                 %  initializing u0
    u1=  zeros( 1 , n );                                 %  initializing u1
    for i=1:m                                            %  filling u0 and u1  
        if Y(i)
            u1=u1+X(i,:);
        else
            u0=u0+X(i,:);
        end
    end
    p1=sum(Y)/m;                                         %  p1 = p(Y==1)
    p0=1-p1;                                             %  p0 = p(Y==0)
    u0=u0/(m-sum(Y))                                     %  u0 is now mean for points witheta yi=0;
    u1=u1/sum(Y)                                         %  u1 is now mean for points witheta yi=1; 
    
    hold on
    plot(u0(1),u0(2),'mo')
    plot(u1(1),u1(2),'m*')
    for j=1:m                                            % plotting training examples
        if Y(j)
            h2=plot(X(j,1),X(j,2),'r.');
        else
            h3=plot(X(j,1),X(j,2),'b+');
        end
    end
    
    sig0=zeros(n,n);                                     %  initializing thetae sigma0 matrix
    sig1=zeros(n,n);                                     %  initializing thetae sigma1 matrix
    for i=1:m                                            %  calculating the sigmnas
        if Y(i)
            temp=X(i,:)-u1;
            sig1=sig1+(temp')*temp;
        else
            temp=X(i,:)-u0;
            sig0=sig0+(temp')*temp;
        end
    end
    
    sig0=sig0/(m-sum(Y))                                 % now sig0 is the required covariance matrix
    sig1=sig1/sum(Y)                                     % now sig1 is the required covariance matrix
    si1=inv(sig1);                                       % inverse of sig1 
    si0=inv(sig0);                                       % inverse of sig0
    
    c=log(det(sig0)/det(sig1)) + 2*log(p1/p0);           % constant term in the required expression
    syms x1 x2                                           % symbols for the values of theta0 and theta1
%     ezplot( [x1 x2]*(inv(sig1)*[x1;x2] - inv(sig0)*[x1;x2]) - [x1,x2]*(inv(sig1)*u1'-inv(sig0)*u0' ) - (u1*inv(sig1) - u0*inv(sig0))*[x1;x2] + c )
    h1=ezplot( ([x1,x2]-u0)*si0*([x1;x2]-u0') - ([x1,x2]-u1)*si1*([x1;x2]-u1') + c , [-3,3,-3,3] );    % final plot of quadratic separting bounday.
    
    set(h1,'Color','magenta', 'LineStyle', '-', 'LineWidth', 1);
    title('GDA for learning the decision boundary');
    xlabel('x1 -> ')                                     % x-axis label
    ylabel('x2 -> ')                                     % y-axis label
    legend([h1 h2 h3] ,'separating boundary','training example,y=1(Alaska)', 'training example,y=0(Canada)','location','southeast');
end

