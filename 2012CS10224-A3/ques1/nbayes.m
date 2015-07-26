function accu = nbayes
    tic
    system('python shuffle.py');
    accu =0;
    for i=1:5
       accu = accu + Bayes( ['train',num2str(i)] , ['test',num2str(i)]  );
    end
    accu=accu/5
    toc
end

function [ accuracy ] = Bayes(trainfile,testfile )
%Q1 Naive bayes from multinomial event model    
    labels = 0 ;
    
    % READING FILE
    input = readFile(trainfile);
    lines = strsplit(input,'\n');
    m = size(lines,2); n=0;
    hash = containers.Map;                      % Dictionary
    lmap= containers.Map;                       % labels map
    for i=1:m                                   % Building the dictionary
        words=strsplit(char(lines(i)));
        l = length(words);
        word=char(words(1));
        if not(lmap.isKey(word) )
            labels=labels+1;
            lmap(word)=labels;
        end
        for j=2:l
            word = char(words(j));
            if not( hash.isKey(word) )
                n=n+1;
                hash(word)=n;
            end
        end
    end
    n
    m
    phi = ones(labels,n);                      % parameter matrices.
    D = zeros(labels,1);                       % words count for each label
    L = zeros(labels,1);                       % count label
    V = size(hash,1);
    
    for i=1:m                                   % Filling X and Y.
        if strcmp(lines(i),''); continue; end;
        words=strsplit(char(lines(i)));
        ind = lmap(char(words(1)));
        l = length(words);
        D(ind)=D(ind)+l-1;
        L(ind)=L(ind)+1;
%         V =V + 1-1;
        for j=2:l
            word = char(words(j));
            if hash.isKey(word)
                phi(ind,hash(word))=phi(ind,hash(word))+1;
            end
        end
    end
    for i=1:labels
        phi(i,:)=phi(i,:)/(D(i)+V);
    end
    py = L/m;
    phi = log(phi);
    
    good = 0;
    input = readFile(testfile);
    lines = strsplit(input,'\n');
    m=size(lines,2);
    for i=1:m
        if strcmp(lines(i),''); continue; end;
        words=strsplit(char(lines(i)));
        l = length(words);
        prob = log(py);
        for j=2:l
            if hash.isKey(words(j))
                k = hash(char(words(j)));
                prob = prob + phi(:,k); 
            end
        end
        [~,ind]=max(prob);
        good = good + (ind==lmap(char(words(1))));
    end
    
    accuracy = good/m;
    fprintf('Accuracy in test data  : %d/%d ( %f )\n', good,m , accuracy );
	return;
    
    % % % % % % % % %     Classification   % % % % % % % %
    
end

