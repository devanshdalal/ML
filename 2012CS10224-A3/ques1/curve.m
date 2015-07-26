function [] = curve
    tic
%     system('python shuffle.py');
    table = [0;0;0;0;0;0];
    traintab = [0;0;0;0;0;0];
    for i=1:5
        k=0;
        for j=[1000:1000:5000 , 5784]
            k=k+1;
            [temp,at] = Bayes( ['train',num2str(i)] , ['test',num2str(i)],j);
            table(k)=table(k)+temp;
            traintab(k)=traintab(k)+at;
        end
    end
    table=table/5;
    traintab=traintab/5;
    plot(1000*[1;2;3;4;5;5.784],table,':ob','Markersize',0.1,'LineWidth',2);
    hold on;
    plot(1000*[1;2;3;4;5;5.784],traintab,'-.*m','Markersize',0.1,'LineWidth',2);
    title('variations of accuracies during Learning');
    legend('test set accuracies','train set accuracies');
    toc
end

function [ accuracy , accutrain ]=Bayes(trainfile,testfile, mm )
%Q1 Naive bayes from multinomial event model    
    labels = 0 ;
    
    % READING FILE
    input = readFile(trainfile);
    lines = strsplit(input,'\n');
    m = size(lines,2); n=0;
    hash = containers.Map;                      % Dictionary
    lmap= containers.Map;                       % labels map
    for i=1:mm                                  % Building the dictionary
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
        if mod(i,1000)==0
        end
    end
    n
    mm
    phi = ones(labels,n);                      % parameter matrices.
    D = zeros(labels,1);                       % words count for each label
    L = zeros(labels,1);                       % count label
    V = size(hash,1);
    
    for i=1:mm                                 % Filling X and Y.
        if strcmp(lines(i),''); continue; end;
        words=strsplit(char(lines(i)));
        ind = lmap(char(words(1)));
        l = length(words);
        D(ind)=D(ind)+l-1;
        L(ind)=L(ind)+1;
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
    py = log(L/mm);
    phi = log(phi);
    accuracy=test(hash,lmap,testfile,phi,py,-1)
    accutrain=test(hash,lmap,trainfile,phi,py,mm)
    
% % % % % % % % %     Classification   % % % % % % % %
end

function [ accuracy ] = test(hash,lmap,testfile,phi, py1 , mm )
    good = 0;
    input = readFile(testfile);
    lines = strsplit(input,'\n');
    m=size(lines,2);
    if mm==-1 || mm >m
        mm = m;
    end
    for i=1:mm
        if strcmp(lines(i),''); continue; end;
        words=strsplit(char(lines(i)));
        l = length(words);
        prob =  py1 ;
        for j=2:l
            if hash.isKey(words(j))
                k = hash(char(words(j)));
                prob = prob + phi(:,k); 
            end
        end
        [~,ind]=max(prob);
        good = good + (ind==lmap(char(words(1))));
    end
    
    accuracy = good/mm;
    fprintf('Accuracy on given file : %d/%d ( %f )\n', good,mm , accuracy );
	return;
    
    
end