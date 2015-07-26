function [ theta ] = p3( ita )                                          % function for showing animation in meshgrid.
    X= importdata( 'q1x.dat' );
    Y= importdata( 'q1y.dat' );
    [m , n]=size(X);
    
    X = [ones(m,1) zscore(X)];                                          %  column of ones added in front of normalized X
    Lx = 5;                                                             %  setting up the x dimention of meshgrid
    Ly = Lx;                                                            %  setting up the y dimention of meshgrid
    inc= 0.5;
    [tx,ty]=meshgrid(-Lx+6:inc:Lx+6,-Ly+5:inc:Ly+5);                    %  2D matrix of points in x-y plane
    Z = arrayfun(@(xx,yy) J(X,Y,[xx;yy]),  tx, ty);                     %  evaluating J() at every point of the grid and storing in Z.
    
    h = figure;
    hold on;
    contour3(tx, ty, Z);                                                    % plotting Z 
    
    xlabel('theta1');
    ylabel('theta2');
    zlabel('err function');
    
    theta = zeros(n+1,1);                                               %  theta initialized to zeros' vector of size 
    d=X'*Y;                                                             %  delta vector initialization: d=X'(Y-X*theta)

    ita=ita/m;  i=0;                                                    %  setting up iter count and ita
    hold on;
    rotate3d on;
    view([0 90]);
    scatter3(5.8391,4.6169,J(X,Y,theta),'*');
    while(ita>0.00001)
        while(abs(d'*d)>0.001)
            d =  X'*(Y - X*theta) ;                                     %  delta calculation from previous theta
            theta = theta +  ita*d;                                     %  ntheta = new value of theta
            i=i+1;
            pause(1);
            if(ishandle(h)==0)
                return ;
            end
            scatter3(theta(1),theta(2),J(X,Y,theta),'MarkerFaceColor',[0 .75 .75]);
        end
        ita=ita/2;                                                      %  halve the learning rate to avoid jumping the minima
    end
    i
    
    title('Convergence of Batch Gradient Descent: contour plot');
    xlabel('x1 -> ')                                     % x-axis label
    ylabel('x2 -> ')                                     % y-axis label
    
end

function [ my ] = J( X , Y , Th)
    my = 0.5*mean((Y-X*Th).^2); 
end