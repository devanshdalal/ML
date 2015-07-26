function [ Z ] = my3D( X , Y )
    L=size(X);
    X = [ones(L(1),1) zscore(X)];
    
    Lx = 150;
    Ly = Lx;
    inc= 2;
    [tx , ty] = meshgrid(-Lx:inc:Lx, -Ly:inc:Ly);
    Z = arrayfun(@(xx,yy) mean((Y-X*[xx;yy]).^2)/(2*L(1)),  tx, ty);
    
%     surf(tx,ty,Z);
%     mesh(tx, ty, Z);
    surf(tx,ty,Z,'EdgeColor','none');
    hold on
%     contour3(tx,ty,Z,20,'k');
%     contour3(Z,20);
    hold off
    xlabel('theta1');
    ylabel('theta2');
    zlabel('err');
end

function [ my ] = J( X , Y , Th)
    my = 0.5*mean((Y-X*Th).^2); 
end