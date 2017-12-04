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
[x,fval,exitflag,output,lambda,grad,hessian]=fmincon(@bhand_ik, x0, [],[], [],[], lb, ub, @ineqcon, opts);
    
draw_bhand(x);   

%   syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 d;
%     
%  
%     T01=[cos(theta1)  -sin(theta1)   0     0 ;
%          sin(theta1)  cos(theta1)    0     0; 
%          0            0              1     h1; 
%          0            0              0     1]; 
% 
% 
%     T12=[cos(theta2)  -sin(theta2)   0     l1 ;
%          sin(theta2)  cos(theta2)    0     0; 
%          0            0              1     0; 
%          0            0              0     1];
% 
%     T23=[1  0   0     l2;
%          0  1   0     0; 
%          0  0   1     0; 
%          0  0   0     1];
% 
% 
%     T34=[cos(theta3)  -sin(theta3)   0     0 ;
%          sin(theta3)  cos(theta3)    0     0; 
%          0            0              1     d; 
%          0            0              0     1]; 
% 
% 
%     %finger 1
%     T451=[sin(theta4)  -cos(theta4)   0     dp ;
%           cos(theta4)  sin(theta4)    0     0; 
%           0            0              1     0; 
%           0            0              0     1]; 
% 
%     T561=[cos(theta5)   sin(theta5)   0     dl ;
%           0             0             -1    0; 
%           -sin(theta5)  cos(theta5)   0     0; 
%           0             0             0     1]; 
% 
%     T671=[cos(a*theta5-pi/4)  -sin(a*theta5-pi/4)   0     lf1 ;
%           sin(a*theta5-pi/4)  cos(a*theta5-pi/4)    0     0; 
%           0              0                1     0; 
%           0              0                0     1];
% 
%     %finger 2
%     T452=[-sin(theta4)  -cos(theta4)   0     -dp ;
%           cos(theta4)  -sin(theta4)    0     0; 
%           0            0               1     0; 
%           0            0               0     1]; 
% 
%     T562=[cos(theta6)   sin(theta6)   0     dl ;
%           0             0             -1    0; 
%           -sin(theta6)  cos(theta6)   0     0; 
%           0             0             0     1];  
% 
%     T672=[cos(a*theta6-pi/4)  -sin(a*theta6-pi/4)   0     lf1 ;
%           sin(a*theta6-pi/4)  cos(a*theta6-pi/4)    0     0; 
%           0              0                1     0; 
%           0              0                0     1];
% 
%     %finger 3  
%     T453=[0    1   0     0;
%           -1   0   0     0; 
%           0    0   1     0; 
%           0    0   0     1];  
% 
%     T563=[cos(theta7)   sin(theta7)   0     dl;
%           0             0             -1    0; 
%           -sin(theta7)  cos(theta7)   0     0; 
%           0             0             0     1];  
% 
%     T673=[cos(a*theta7-pi/4)  -sin(a*theta7-pi/4)   0     lf1 ;
%           sin(a*theta7-pi/4)  cos(a*theta7-pi/4)    0     0; 
%           0              0                1     0; 
%           0              0                0     1];
% 
% 
%     P=[lf2;0;0;1];
%     P1=[0;0;0;1];
%     L1=T01*T12*T23*T34*T451*T561*T671*P;
%     L2=T01*T12*T23*T34*T452*T562*T672*P;
%     L3=T01*T12*T23*T34*T453*T563*T673*P;
%     
%     L12=T01*T12*T23*T34*T451*T561*T671*P1;
%     L22=T01*T12*T23*T34*T452*T562*T672*P1;
%     L32=T01*T12*T23*T34*T453*T563*T673*P1;
%     
%     L13=T01*T12*T23*T34*T451*T561*P1;
%     L23=T01*T12*T23*T34*T452*T562*P1;
%     L33=T01*T12*T23*T34*T453*T563*P1;
%     
%     
%     
% 
%     dist = (L1(1)/L1(4)-p1(1))^2+(L1(2)/L1(4)-p1(2))^2+(L1(3)/L1(4)-p1(3))^2 ...
%          + (L2(1)/L2(4)-p2(1))^2+(L2(2)/L2(4)-p2(2))^2+(L2(3)/L2(4)-p2(3))^2 ...
%          + (L3(1)/L3(4)-p3(1))^2+(L3(2)/L3(4)-p3(2))^2+(L3(3)/L3(4)-p3(3))^2;
% x=[theta1 theta2 theta3 theta4 theta5 theta6 theta7 d];
% 
% x0=[0,0,0,0.3,0.2,0.2,0.2,-0.2];  
% f0=subs(dist, x, x0);
% 
% m=16;
% t=20;
% s1=0; s2=0;
% 
% for i=1:1:8
%     f(i)= diff(dist,x(i));
%     t1=x0(i)-ub(i); 
%     t2=lb(i)-x0(i);
%     s1=s1+log(-t1);
%     s2=s2+log(-t2);
% end
% f0=f0-(s1+s2);
% 
% while m/t>0.0001
% 
%    while f0 > m/t
%        for i=1:1:8
%            
%               t1=x0(i)-ub(i); 
%               t2=lb(i)-x0(i);
%               
% %               if t1>-0.0001
% %                   t1=-0.0001;
% %               end
% %                 
% %               if t2>-0.0001
% %                   t2=-0.0001;
% %               end
%               
% %               if t1==0 && t2==0
% %                   temp=x0(i)- f0/(t*subs(f(i),x,x0));
% %               else if (t1==0 && t2~=0) ||(t1~=0 && t2==0)
% %                     temp=x0(i);
% %                   else temp=x0(i)- f0/(t*subs(f(i),x,x0)-1/t1+1/t2);
% %                   end
% %               end
%               
%               if t1*t2<0.0000001 && t1-t2==0
%                   temp=x0(i)- f0/(t*subs(f(i),x,x0));
%               else if (t1*t2<0.0000001) ||(t1-t2~=0)
%                     temp=x0(i);
%                   else temp=x0(i)- f0/(t*subs(f(i),x,x0)-(t1-t2)/(t1*t2));
%                   end
%               end
%               
%               if temp>ub(i)
%                   x0(i)=ub(i)-0.0001; 
%               else if temp<lb(i)
%                   x0(i)=lb(i)+0.0001; 
%                   else  x0(i)=temp;
%                   end
%               end
%               s1=s1+log(-t1);
%               s2=s2+log(-t2);
%        end
%        
%        f0=t*subs(dist, x, x0)-(s1+s2);
%        s1=0; s2=0;
%    end
%    t=t+20;
% end