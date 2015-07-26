function [] = nonface(image)
    a=imread(image);
    b=rgb2gray(a);
    X=imresize(b,[19 19]);
    
    imwrite(uint8(X), [image,'_.png'] );
    
    n=361;
    k = 50;
    X = double(X(:)');
    
    V = importdata('../V.mat');
    V = V(:,1:k);
    
%     size(X)
%     size(V)

    Y = sum(V.*repmat(X*V,n,1),2);
    Y = vec2mat(Y,19);
    
    diff=sum(sum(uint8(abs(vec2mat(X,19)-Y))))/n
    imwrite(uint8(Y) , [image,'_out','.png']);
    imshow(uint8(Y));
    
end 