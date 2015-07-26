function [ ind ] = chooseBest( D , left , type )
%CHOOSEBEST chooses the best attribute.
    ind =-1;
    m=size(D,1);
    n=size(D,2);
    if strcmp(type,'error')                       % error based splitting
        curr = inf;
        for j=2:n
            if left(j)                            % if present
                D1 = []; D2 = []; D3 = [];
                for i =1:m
                    if D(i,j)==1
                        D1 = [ D1 ; D(i,1)];
                    elseif D(i,j)==2
                        D2 = [ D2 ; D(i,1)];
                    else
                        D3 = [ D3 ; D(i,1)];
                    end
                end
                a1 = sum(D1); s1 = size(D1,1); assert(a1<=s1);
                a2 = sum(D2); s2 = size(D2,1); assert(a2<=s2);
                a3 = sum(D3); s3 = size(D3,1); assert(a3<=s3);
                temp = (min(a1,s1-a1) + min(a2,s2-a2) + min(a3,s3-a3))/m;
                if curr>temp
                    curr=temp;
                    ind = j;
                end
            end
        end
    elseif strcmp(type,'rand')                    % rand based splitting
        for i=2:n
            if left(i)==1
                ind = i;
                break;
            end
        end
    elseif strcmp(type,'entropy')                  % IG based splitting
        p1 = sum(D(:,1)==1)
        p2 = m - p1;
        curr = -inf;
        Es = -(p1*log2(max(p1,1)/m) + p2*log2(max(p2,1)/m))/m;
        for j=2:n
            if left(j)
                D1 = []; D2 = []; D3 = [];
                for i =1:m
                    if D(i,j)==1
                        D1 = [ D1 ; D(i,1)];
                    elseif D(i,j)==2
                        D2 = [ D2 ; D(i,1)];
                    else
                        D3 = [ D3 ; D(i,1)];
                    end
                end
                a1 = sum(D1); s1 = size(D1,1);
                a2 = sum(D2); s2 = size(D2,1);
                a3 = sum(D3); s3 = size(D3,1);
                if s1==0; E1=0; else E1 = -(a1*log2(max(a1,1)/s1)+(s1-a1)*log2(max(s1-a1,1)/s1))/m; end;
                if s2==0; E2=0; else E2 = -(a2*log2(max(a2,1)/s2)+(s2-a2)*log2(max(s2-a2,1)/s2))/m; end;
                if s3==0; E3=0; else E3 = -(a3*log2(max(a3,1)/s3)+(s3-a3)*log2(max(s3-a3,1)/s3))/m; end;
                temp = Es - E1 - E2 -E3;
                if curr<temp
                    curr=temp;
                    ind = j;
                end
            end
        end
    else
        error([type,' is Not implemented'])
    end
end

