function [theta1,  theta2] = nn( X , Y , n2 , TX , TY ) % n2 is the number of last layer outputs.
%NN  neural network
    tic;
    m=size(X,1)                             % INITIALIZING VARIABLES
    P=randperm(m);
    X=X(P,:);
    Y=Y(P,:);
    n=784;
    n1=100;
    YY = zeros(m,n2);
    for i=1:m                               % SETTING UP Y
        YY(i,Y(i,1)+1)=1;
    end
    e=0.20;                                 % RANDOMLY SETTING UP thetas
    theta1 = e*rand(n1,n+1) - e/2;
    theta2 = e*rand(n2,n1+1) - e/2;
    
    disp('starting ... ');
    iter=1;
    oldth=0;
    while iter<100*m                        % MAIN LOOP
        dth = 0;
        for k=1:m
            % Feedforward the kth example
            O1 = [1; sigmoid(theta1*X(k,:)')];
            
            O2 = [1; sigmoid(theta2*O1)];   % outer lauer computation 
            O2_ = O2(2:end);
            dth = dth + norm(O2_-YY(k,:)').^2;
            delta2 = (YY(k,:)' - O2_).*O2_.*(1-O2_);
            
            theta2 = theta2 + (1/sqrt(iter))*delta2*O1';
            
            % backpropagation
            delta1 = (theta2'*delta2).*(O1.*(1-O1));
            theta1 = theta1 + (1/sqrt(iter))*(delta1(2:end)*X(k,:));
            iter = iter+1;
        end
        dth=dth/(2*m);
        diff=abs(oldth-dth)
        if diff<0.00001  % && iter>10*m  % stoppping criteria
           fprintf('Iterations  : %d\n', uint32(iter/m) );
           break;
        end
        oldth=dth;
    end
    
    % classify the Test cases
    tm = size(TX,1);
    
    tnet1 = theta1*TX';
    TO1 = [ones(1,tm) ; sigmoid(tnet1)];
    
    tnet2 = theta2*TO1;
    TO2 = sigmoid(tnet2)'; % tm X n2
    OY = zeros(tm,1);
    for i=1:tm
        acc=-inf;ind=0;
        for j=1:n2
            if acc<=TO2(i,j)
                acc=TO2(i,j);
                ind=j;
            end
        end
        OY(i,1)=ind-1;
    end
    
    for i=0:n2-1
        fprintf('output for %d : %10d %10d  %10d\n',i,sum(OY==i), sum(TY==i) ,sum( (OY==i).*(TY==i) )   );
    end
    
    correct=sum(TY==OY);
    fprintf('Accuracy in test data  : %d/%d ( %f )\n', correct,tm, 100*correct/tm   );
    toc;
end

function out = sigmoid( in )
%SIGMOID Summary of this function goes here
%   Sigmoid fn
    out = 1./(1+exp(-in));
end
