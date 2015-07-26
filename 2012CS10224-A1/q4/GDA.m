function [ ] = GDA(  )                                                     % linear GDA implementation
    X= importdata( 'q2x.dat' );
    Y= importdata( 'q2y.dat' );
    [m , n]=size(X);
    Y=arrayfun(@(z) strcmp(z,'Alaska'),Y);                                 % converting Y to a boolean vector
    X=zscore(X);                                                           % normalizing X
    
    u0 = zeros( 1 , n );                                                   %  initializing u0
    u1=  zeros( 1 , n );                                                   %  initializing u1
    for i=1:m                                                              %  filling u0 and u1 
        if Y(i)
            u1=u1+X(i,:);
        else
            u0=u0+X(i,:);
        end
    end
    p1=sum(Y)/m;                                                        %  p1 = p(Y==1)
    p0=1-p1;                                                               %  p0 = p(Y==0)
    u1=u1/sum(Y);                                                          %  u0 is now mean for points with yi=0;
    u0=u0/(m-sum(Y));                                                   %  u1 is now mean for points with yi=1;
    
%   plot(X(:,2),-(th(1)+th(2)*X(:,2) )/th(3),'g-')
    hold on
    plot(u0(1),u0(2),'g*')
    plot(u1(1),u1(2),'g.')
    for j=1:m
        if Y(j)                                                            % plotting training examples
            plot(X(j,1),X(j,2),'r.')
        else
            plot(X(j,1),X(j,2),'b+')
        end
    end
    
    sig=zeros(n,n);
    for i=1:m
        temp=X(i,:)- (Y(i)*u1+(1-Y(i))*u0);
        sig=sig + (temp')*temp;
    end
    
    sig=sig/L(1);
    th=-log(p0/p1)+0.5*(u0+u1)*inv(sig)*(u0-u1)';
    M=sig\(u0-u1)';
    p1
    p0
    th
    M

    plot(X(:,1), (th -X(:,1)*M(1) )/M(2)  ,'g-');
    
end