function [x,fval,exitflag,output,lambda,grad,hessian] = untitled(x0, lb, ub)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('fmincon');
%% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'Algorithm', 'trust-region-reflective');
options = optimoptions(options,'SubproblemAlgorithm', 'cg');
[x,fval,exitflag,output,lambda,grad,hessian] = ...
fmincon(@bhand_ik,x0,[],[],[],[],lb, ub);
