function [] = visualize( digit )
%VISUALIZE visualize the digits corresponding to examples given.
    
    decomp = zeros(1,784);
    decomp((3:5:783)')= digit(2:end);
    imshow( vec2mat(decomp,28) , 'initialmagnification' , 300);

end

