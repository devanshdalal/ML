function [ ] = kmeans( X )
%KMEANS K-means algorithm
%   clustering using k-means algorithm with 4 centers
    
    % Training Examples' Labels
    Y = (X(:,1)+1)/2;
    % Training Examples
    X = X(:,2:end);
    
    % Number of examples and dimentions
    [m, n] = size(X);
    % Number of cluster
    k=4;
    
    M = X(randi([1 m],4,1),:); %rand(k,n);
    size(M)
    C = zeros(m,1);
    Map = -ones(k,1);
    
    for iter=1:30
        for i=1:m
            [~,ind] = min(sum((M - repmat(X(i,:),k,1)).^2,2));
            C(i)=ind;
        end
        M = zeros(k,n);
        for i=1:m
            M(C(i),:)=M(C(i),:) + X(i,:);
        end
        for j=1:k
            M(j,:)=M(j,:)/sum(C==j);
%           fprintf('for j = %d > %d\n', j,sum(C==j));
        end
    end
    
    for i=1:k
        Map(i)=mode(Y(C==i));
    end
    
    fprintf('Accuracy after learning %f\n',sum(Map(C)==Y)/m);
end

