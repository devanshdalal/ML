function [ theta ] = p4( ita )                                          % function for showing animation in meshgrid.
    X= importdata( 'q1x.dat' );
    Y= importdata( 'q1y.dat' );
    [m , n]=size(X);
    
    X = [ones(m,1) zscore(X)];                                          %  column of ones added in front of normalized X
    Lx = 7;                                                             %  setting up the x dimention of meshgrid
    Ly = Lx;                                                            %  setting up the y dimention of meshgrid
    inc= 0.5;
    [tx,ty]=meshgrid(-Lx+6:inc:Lx+6,-Ly+5:inc:Ly+5);                    %  2D matrix of points in x-y plane
    Z = arrayfun(@(xx,yy) J(X,Y,[xx;yy]),  tx, ty);                     %  evaluating J() at every point of the grid and storing in Z.
    
    h = figure;
    hold on;
    mesh(tx, ty, Z);                                                    % plotting Z 
    
    xlabel('theta1');
    ylabel('theta2');
    zlabel('err function');
    
    theta = zeros(n+1,1);                                               %  theta initialized to zeros' vector of size 
    d=X'*Y;                                                             %  delta vector initialization: d=X'(Y-X*theta)

    ita=ita/m;  i=0;                                                    %  setting up iter count and ita
    hold on;
    rotate3d on;
    view([32 -4]);
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
    title('Graph of training examples and hypothesis function');
    
end

function [ my ] = J( X , Y , Th)
    my = 0.5*mean((Y-X*Th).^2); 
end