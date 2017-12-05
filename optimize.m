global a h1 l1 l2 dp dl lf1 lf2;
global p1 p2 p3 v1 v2 v3;
global lb ub;
global theta1 theta2 theta3 theta4 theta5 theta6 theta7 d t1 t2 t3;

a=45 /140;%ration betwwen rotation angles of upperlink and lowerlink
h1=0.487;    %hight of the first link of Adept
l1=0.325;    %length of the second link of Adpet
l2=0.275;    %length of the third link of Adpet
dp=0.025;  %distance from the center of the hand plum to the rotaion aixs of two fingers
dl=0.050;  %distance from the rotation axis to the top of the upper links of there fingers
lf1=0.070; %length of the finger's upperlink
lf2=0.058; %length of the finger's lowerlink

joint1_lb = -105 / 180 * pi;
joint1_up = - joint1_lb;
joint2_lb = -150 / 180 * pi;
joint2_up = - joint2_lb;
joint3_lb = -2*pi;
joint3_up = 2*pi;
joint4_lb = -0.4;
joint4_up = -0.1;
bhand_j1_lb = 0;
bhand_j1_up = 140 / 180 * pi;
bhand_j2_lb = 0;
bhand_j2_up = 140 / 180 * pi;
bhand_j3_lb = 0;
bhand_j3_up = 140 / 180 * pi;
bhand_j4_lb = 0;
bhand_j4_up = pi;
lb = [joint1_lb, joint2_lb, joint3_lb, bhand_j4_lb, bhand_j1_lb, bhand_j2_lb, bhand_j3_lb, joint4_lb, 0, 0, 0];
ub = [joint1_up, joint2_up, joint3_up, bhand_j4_up, bhand_j1_up, bhand_j2_up, bhand_j3_up, joint4_up, 1, 1, 1];

x0=[0,0,0,0,0,0,0,-0.1, 0.5, 0.5, 0.5];
    
x1=0.406587896459847;   y1=0.278104497922499;     z1=0.199282380310092;   
x2=0.366285693056258;   y2=0.101613473359549;     z2=0.191553409842422;    
x3=0.581729657538668;   y3=0.135513036503898;     z3=0.168540401498581; 

p1=[x1 y1 z1 1];
p2=[x2 y2 z2 1];
p3=[x3 y3 z3 1];

v1=-[-0.032135333078231 0.032135333078231 0.02084803913806   0];
v2=-[-0.045216672051166 -0.012115770760533 0.017568741204067 0];
v3=-[0.048161245088541 -0.012904766727952 0.003736504679321  0];

opts = optimoptions('fmincon','Display','iter','Algorithm','sqp', 'PlotFcn', {  @bhand_plot_func });
[x,fval,exitflag,output,lambda,grad,hessian]=fmincon(@bhand_ik, x0, [],[], [],[], lb, ub, @nonlcon,opts);
    
draw_bhand(x);   
