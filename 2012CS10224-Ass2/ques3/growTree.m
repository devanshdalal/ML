function[tre,training,validation,testing,numNodes] = growTree(D,c,tre,left,training,validation,testing,numNodes,error_criteria)
%GROWtre Recursive function for growing tre
    global TX V X;
    
    m = size(D,1);
    if m==0; tre(c)=-2; return; end;      %  base case
    
    count = sum(D(:,1));                  %  if this is leaf node
    if count == 0
        tre(c)=-1;
        return
    elseif count == m
        tre(c)=-2;
        return
    end
    
    % choosebest
    j=chooseBest(D, left ,error_criteria);
    fprintf('choosen attribute for split: %d\n' , j-2 );
    if j==-1;  error('not possible'); end;
    tre(c)=j;
    
    D1 = []; D2 = []; D3 = [];
    for i =1:m                                % partitioning data in 3 classes
        if D(i,j)==1
            D1 = [ D1 ; D(i,:)];
        elseif D(i,j)==2
            D2 = [ D2 ; D(i,:)];
        else
            D3 = [ D3 ; D(i,:)];
        end
    end
    
    if size(D1,1)>0; tre(3*c-1)=-mode(D1(:,1))-1; else tre(3*c-1)=-1; end;
    if size(D2,1)>0; tre(3*c  )=-mode(D2(:,1))-1; else tre(3*c)=-1; end;
    if size(D3,1)>0; tre(3*c+1)=-mode(D3(:,1))-1; else tre(3*c+1)=-1; end;

    ac = check(X,1,tre);                       % filling tables for ploting
    training = [training; ac];
    ac = check(V,1,tre);
    validation = [validation; ac];
    ac = check(TX,1,tre);
    testing = [testing ; ac];
    numNodes = [numNodes; tsize(tre,1) ];
    
    left(j)=0;
    % MAKING RECURSIVE CALLS
    [tre,training,validation,testing,numNodes] = growTree(D1,3*c-1,tre,left,training,validation,testing,numNodes,error_criteria);
    [tre,training,validation,testing,numNodes] = growTree(D2,3*c ,tre,left,training,validation,testing,numNodes,error_criteria);
    [tre,training,validation,testing,numNodes] = growTree(D3,3*c+1,tre,left,training,validation,testing,numNodes,error_criteria);

end