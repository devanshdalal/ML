function []=pca1()
% Pricipal component analysis algorithm
    
    m = 2429;
    n = 361;
    k = 50;
    X = importdata('X.mat');
    
    X_avg = mean(X,1);
    Sig = X - repmat( X_avg ,m,1);
    
    [U, S , V ]=svd(Sig);  % S = u*d*v';
    
%     u = n X n
%     d = n X n
%     v = n X n
%     Top 5 eigrn vectors
    fprintf('Top 5 eigrn vectors\n %f\n%f\n%f\n%f\n%f\n',S(1,1),S(2,2),S(3,3),S(4,4),S(5,5))
    save('V','V')

    V = V-repmat(min(V),n,1);
    V = V.*( 255./ repmat(max(V),n,1) );
    
    for i=1:k
        T = uint8(vec2mat( V(:,i) ,19));
        imwrite(T , ['faces/',num2str(i),'.png'] );
    end
    
end
