function [X Y] = initData( ques )
    X= importdata( ['q', num2str( ques), 'x.dat'] );
    Y= importdata( ['q', num2str( ques), 'y.dat'] );

end

