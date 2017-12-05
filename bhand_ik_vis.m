function [x,fval,exitflag,output,lambda,grad,hessian] = bhand_ik_vis(x0,lb,ub)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('fmincon');
%% Modify options setting
options = optimoptions(options,'Display', 'iter');
options = optimoptions(options,'PlotFcn', {  @optimplotx @optimplotfunccount @optimplotconstrviolation @optimplotstepsize @bhand_plot_func });
options = optimoptions(options,'Algorithm', 'sqp');
options = optimoptions(options,'Diagnostics', 'on');
[x,fval,exitflag,output,lambda,grad,hessian] = ...
fmincon(@bhand_ik,x0,[],[],[],[],lb,ub,@nonlcon,options);
