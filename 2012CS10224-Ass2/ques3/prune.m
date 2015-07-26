function [tre, curr_ac, p_validation, p_testing, p_xaxis] = prune( tre , curr_ac  )
%PRUNE Iteratively prunes the tree for maximizing validation efficiency.
    disp('prunning ...');
    global X V TX;
    p_validation = [check(V,1,tre)];            % tables for ploting
    p_testing=[check(TX,1,tre)];
    p_xaxis=[tsize(tre,1)];
    while 1
                                                % calling best_to_prune
        [c,label,aval] = best_to_prune(X,tre,1,0,0,curr_ac);
        if c==0; break; end;
        tre(c)=label;
        curr_ac = aval;
        p_xaxis = [p_xaxis; tsize(tre,1)];     % filling tables for ploting
        p_validation = [p_validation; check(V,1,tre)];
        p_testing = [p_testing; check(TX,1,tre)];
    end
end

function [ ind, label , aval ] = best_to_prune(D , tre , c ,ind, label, aval )
    global V;
    m = size(D,1);
    if m==0; return; end;
    j=tre(c);
    if j<=1 ;return; end;                         % base cases
    
    D1 = []; D2 = []; D3 = [];
    for i =1:m                                    % partitioning data in 3 classes
        if D(i,j)==1
            D1 = [ D1 ; D(i,:)];
        elseif D(i,j)==2
            D2 = [ D2 ; D(i,:)];
        else
            D3 = [ D3 ; D(i,:)];
        end
    end                                           % MAKING RECURSIVE CALLS
    if size(D1,1)>0; [ ind, label , aval ] = best_to_prune(D1,tre,3*c-1,ind, label,aval); end;
    if size(D2,1)>0; [ ind, label , aval ] = best_to_prune(D2,tre,3*c  ,ind, label,aval); end;
    if size(D3,1)>0; [ ind, label , aval ] = best_to_prune(D3,tre,3*c+1,ind, label,aval); end;
    
    s1=mode(D(:,1));
    tre(c)=-1-s1;
    accu = check(V,1,tre);                        % RECHECKING VALIDITY
    if accu>=aval
        label=-1-s1;
%         'paused'
%         [ accu aval c]
%         pause
        aval = accu;
        ind = c;
    end;

end
