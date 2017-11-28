function x = demo(x0)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('fminimax');
%% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'SpecifyObjectiveGradient', true);
x = fminimax(@test,x0,[],[],[],[],[],[],[],options);


