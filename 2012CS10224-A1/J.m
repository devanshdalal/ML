function [ my ] = J( X , Y , Th)
    my = 0.5*mean((Y-X*Th).^2); 
end
