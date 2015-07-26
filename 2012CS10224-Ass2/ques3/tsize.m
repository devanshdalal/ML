function s = tsize( tre , c )
%SIZE return the size of the tree rooted at c
    
    if tre(c)==-1 || tre(c)==-2
        s=1;
    elseif tre(c)>=1
        s=1+tsize(tre,3*c-1) + tsize(tre,3*c) + tsize(tre,3*c+1);
    elseif tre(c)==0
        s=0;
    else
        error('invalid ');
    end
    
end

