function [ ] = kmeansC( X )
%KMEANS K-means algorithm
%   clustering using k-means algorithm with 4 centers
    % Training Examples' Labels
    Y = (X(:,1)+1)/2;
    % Training Examples
    X = X(:,2:end);
    
    % Number of examples
    m = size(X,1);
    % dimentions
    n = size(X,2);
    % Number of cluster
    k=4;
    
    M = X(randi([1 m],4,1),:); %rand(k,n);
    C = zeros(m,1);
    yaxis = [];
    S = inf;
    Map = -ones(k,1);
    
    for iter=1:20
        S=0;
        for i=1:m
            [val,ind] = min(sum(abs(M - repmat(X(i,:),k,1)).^2,2));
            C(i)=ind;
            S=S+val;
        end
        yaxis = [yaxis ; S ];
        M = zeros(k,n);
        for i=1:m
            M(C(i),:)=M(C(i),:) + X(i,:);
        end
        for j=1:k
            M(j,:)=M(j,:)/sum(C==j);
        end
    end
    
    for i=1:k
        Map(i)=mode(Y(C==i));
    end
    
    plot(yaxis,':*b','Markersize',10,'LineWidth',2);
    title('variations of error during Learning');
    xlabel('no. of iterations')
    ylabel('Value of S')
    
    fprintf('Accuracy after learning %f\n',sum(Map(C)==Y)/m);
    
end

