
yaxis =[]; %[1,2,3,4,5,6];
for i=1:6
    [status,comout]=system(['python 2.py train-', num2str((i-1)*20),'.data']);
    yaxis = [yaxis,  str2num(comout) ];
end

plot([0,20,40,60,80,100],yaxis,'--*b');
title('varaition of logliklihood v/s percentage of missing data during training')
ylabel('log liklihood');
xlabel('missing data percntage in traindata');