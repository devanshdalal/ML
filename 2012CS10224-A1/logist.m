function [ th  ] = logist( X , Y )
    L=size(X);
    X = [ones(L(1),1) zscore(X)];
    
    th = ones(L(2)+1,1);
    eps = 0.0000001;   i=0; d=th;
    
    while( abs(d'*d)>eps )
        p = 1./(1+exp(- X*th));
        W = diag( p.*(1-p));
        d = (X'*W*X)\X'*(Y-p);
        th = th + d;
        i=i+1;
    end
    i
    
%     plot(X(:,2), Y, 'rx', 'MarkerSize', 10)
    plot(X(:,2),-(th(1)+th(2)*X(:,2) )/th(3),'g-')
    hold on
    for j=1:L(1)
        if( Y(j)==1 )
            plot(X(j,2),X(j,3),'r.')
        else
            plot(X(j,2),X(j,3),'b+')
        end
    end
    hold off
end

