function []=dt(error_criteria)
% decision tree learning

    training = [];
    validation = [];
    testing = [];
    numNodes = [];
    nodes = (3^17 + 1)/2;

    global TX V X;
    X = csvread('ptrain.txt');
    V = csvread('pvalid.txt');
    TX = csvread('ptest.txt');

    n = size(X,2);
    left = ones(n,1);
    tre = zeros( nodes , 1  );

    XX=X;
    [tre,training,validation,testing,numNodes] = growTree(XX,1,tre,left,training,validation,testing,numNodes,error_criteria);
    trainac = check(X,1,tre)
    validac = check(V,1,tre)
    testac = check(TX,1,tre)
    fprintf('Size of tree : %d\n' ,tsize(tre,1) );


    figure;
    h = plot(NaN,NaN); %// initiallize plot. Get a handle to graphic object
    set(h,'Marker','*');
    hold on;
    grid on;
    plot(numNodes,training,':ob','Markersize',0.1,'LineWidth',2);
    plot(numNodes,validation,'--*r','Markersize',0.1,'LineWidth',2);
    plot(numNodes, testing,'-gd','Markersize',0.1,'LineWidth',2);
    legend('Training','Validation','Testing','Location','northwest')
    title(['variations of accuracies during dtree construction (',error_criteria,')']);

    %  PRUNNING
    [tre,newValidAcc,p_validation, p_testing, p_xaxis]=prune(tre,validac);
    figure(2);
    g=plot(NaN,NaN);
    hold on;
    grid on;
    set(gca,'XDir','reverse');
    plot(p_xaxis, p_testing,':ob','Markersize',10,'LineWidth',2);
    plot(p_xaxis, p_validation,'--*r','Markersize',0.1,'LineWidth',2);
    legend('testing','Validation','Location','northwest');
    title(['variations of accuracies during prunning (',error_criteria,')']);

    newValidAcc

    disp('done')
    finalTestAccu = check(TX,1,tre)
    finalvalidationAccu = check(V,1,tre)

    fprintf('Size of tree after prunning : %d\n' ,tsize(tre,1) );
end
