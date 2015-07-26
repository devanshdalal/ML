function []=pca2(faceid)
% Pricipal component analysis algorithm
    
    n=361;
    k = 50;
    X = importdata('X.mat');
    X = X(faceid,:);
    
    V = importdata('V.mat');
    V = V(:,1:k);
    
    Y = sum(V.*repmat(X*V,n,1),2);
    Y = vec2mat(Y,19);
    
    diff=sum(sum(uint8(abs(vec2mat(X,19)-Y))))/n
    imwrite(uint8(Y) , ['out_',num2str(faceid),'.png']);
    imshow(uint8(Y));
    
end