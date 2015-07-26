function [ ] = p123(  )                                    % GDA implementation
    X= importdata( 'q4x.dat' );
    Y= importdata( 'q4y.dat' );
    [m , n]=size(X);
    X = zscore(X);                                          %  column of ones added in front of normalized X
    Y=arrayfun(@(z) strcmp(z,'Alaska'),Y);                  %  converting Y to 0/1 vector 
    
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
    p0=1-p1;                                                %  p0 = p(Y==0)
    u1=u1/sum(Y)                                            %  u1 is now mean for points witheta yi=1; 
    u0=u0/(m-sum(Y))                                     %  u0 is now mean for points witheta yi=0;
    
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
    
%     sig=zeros(n,n);                                      %  initializing thetae sigma matrix
%     for i=1:m                                            %  calculating the sigmna 
%         temp=X(i,:)- (Y(i)*u1+(1-Y(i))*u0);
%         sig=sig + (temp')*temp;
%     end
    
%     sig=sig/m                                            % now sigma is the required covariance matrix
    
%     theta=-log(p0/p1)+0.5*(u0+u1)*inv(sig)*(u0-u1)';         
%     M=sig\(u0-u1)';                                         
    
%     h1=plot(X(:,1), (theta -X(:,1)*M(1) )/M(2)  ,'g-');  % plotting the decision boundary
    title('Linear GDA for learning the decision boundary');
    xlabel('x1 -> ')                                     % x-axis label
    ylabel('x2 -> ')                                     % y-axis label
    legend([h2 h3] ,'training example,y=1', 'training example,y=0','location','southeast');
end