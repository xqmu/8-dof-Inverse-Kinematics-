global a h1 l1 l2 dp dl lf1 lf2;
global p1 p2 p3 v1 v2 v3;
global lb ub;
global theta1 theta2 theta3 theta4 theta5 theta6 theta7 d;

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
lb = [joint1_lb, joint2_lb, joint3_lb, bhand_j4_lb, bhand_j1_lb, bhand_j2_lb, bhand_j3_lb, joint4_lb];
ub = [joint1_up, joint2_up, joint3_up, bhand_j4_up, bhand_j1_up, bhand_j2_up, bhand_j3_up, joint4_up];

x0=[0,0,0,0,0,0,0,-0.1];
    
x1=0.3;   y1=0.05;  z1=0.2;   
x2=0.3;   y2=0;     z2=0.2;    
x3=0.25;  y3=0;     z3=0.2; 

p1=[x1 y1 z1 1];
p2=[x2;y2;z2;1];
p3=[x3;y3;z3;1];

v1=[0 0.1 0.05 0];
v2=[-0.05 0.05*sqrt(2) 0.05 0];
v3=[-0.05 -0.05*sqrt(2) 0.05 0];

opts = optimoptions('fmincon','Display','iter','Algorithm','sqp');
[x,fval,exitflag,output,lambda,grad,hessian]=fmincon(@bhand_ik, x0, [],[], [],[], lb, ub, @nonlcon, opts);
    
draw_bhand(x);   
