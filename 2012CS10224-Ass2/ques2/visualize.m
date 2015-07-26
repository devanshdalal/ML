function [] = visualize( digit )
%VISUALIZE visualize the digits corresponding to examples given.

    imshow( vec2mat(digit,28) , 'initialmagnification' , 300);

end

