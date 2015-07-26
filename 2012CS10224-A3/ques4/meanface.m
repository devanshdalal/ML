function []=meanface()
% displays the mean face of data
    
    M = 2429;
    N = 361;
    list = dir('q5_data/*.pgm');
    
    X = zeros(M,N);
    total = zeros(19,19);
    % Load images
    for i=1:M
      disp(['loading ' , num2str(i)]);
      temp = double(imread(['q5_data/',list(i).name]))';
      total = total + temp';
      X(i,: ) = temp(:);
    end
    
    total = total/M;
    imshow(uint8(total));
    
    save('X','X');
    
end
