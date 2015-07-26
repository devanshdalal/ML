function accuracy = check( D , c , tre )
%CHECK Checks accuracy
    m = size(D,1);
    if m==0; accuracy=1; return;  end    %  base case
    
    j=tre(c,1);
    count = sum(D(:,1));                 %  if this is leaf node
    if j==-1
        accuracy = 1 - count/m;
        return
    elseif j==-2
        accuracy = count/m;
        return
    end

    if j==0; accuracy=0.5; return; end;  %  if this is Null
    
    D1 = []; D2 = []; D3 = [];
    for i =1:m                           % partitioning data in 3 classes
        if D(i,j)==1                     % democrat
            D1 = [ D1 ; D(i,:)];
        elseif D(i,j)==2
            D2 = [ D2 ; D(i,:)];
        else
            D3 = [ D3 ; D(i,:)];
        end
    end
    
    % recursive calls
    a1=check(D1,3*c-1,tre);
    a2=check(D2,3*c,tre);
    a3=check(D3,3*c+1,tre);            
    % answer
    accuracy = (a1*size(D1,1) + a2*size(D2,1) + a3*size(D3,1) )/m;
end

