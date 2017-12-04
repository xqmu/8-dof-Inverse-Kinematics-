
joint1_lb = -105 / 180 * pi;
joint1_up = - joint1_lb;
joint2_lb = -150 / 180 * pi;
joint2_up = - joint2_lb;
joint3_lb = -inf;
joint3_up = +inf;
joint4_lb = 0.1;
joint4_up = 0.4;
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
%DH table
%  i     a_i-1    alpha_i-1     d_i     theta_i
%  1       0         0           h1       theta1
%  2       l1        0           0        theta2
%  3       l2        0           0          0
%  4       0         0           d        theta3

%  51      dp        0           0        pi/2-theta4
%  61      dl        pi/2        0        -theta5
%  71      df1       0           0        a*theta5-pi/4

%  52      dp        0           0        pi/2+theta4
%  62      dl        pi/2        0        -theta6
%  72      df1       0           0        a*theta6-pi/4

%  53      0        0           0        pi/2
%  63      dl        pi/2        0        -theta7
%  73      df1       0           0        a*theta7-pi/4

syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 d; 

theta1=0; theta2=0; theta3=0; theta4=0; theta5=0; theta6=0; theta7=0; d=-0.1; 

a=45 /140;%ration betwwen rotation angles of upperlink and lowerlink
h1=0.487;    %hight of the first link of Adept
l1=0.325;    %length of the second link of Adpet
l2=0.275;    %length of the third link of Adpet
dp=0.025;  %distance from the center of the hand plum to the rotaion aixs of two fingers
dl=0.050;  %distance from the rotation axis to the top of the upper links of there fingers
lf1=0.070; %length of the finger's upperlink
lf2=0.058; %length of the finger's lowerlink


x1=1; y1=1; z1=1; 
x2=1; y2=1; z2=1; 
x3=1; y3=1; z3=1; 

% p1=[x1 y1 z1 1];
% p2=[x2;y2;z2;1];
% p3=[x3;y3;z3;1];


T01=[cos(theta1)  -sin(theta1)   0     0 ;
     sin(theta1)  cos(theta1)    0     0; 
     0            0              1     h1; 
     0            0              0     1]; 
 
 
T12=[cos(theta2)  -sin(theta2)   0     l1 ;
     sin(theta2)  cos(theta2)    0     0; 
     0            0              1     0; 
     0            0              0     1];
 
T23=[1  0   0     l2;
     0  1   0     0; 
     0  0   1     0; 
     0  0   0     1];
 

T34=[cos(theta3)  -sin(theta3)   0     0 ;
     sin(theta3)  cos(theta3)    0     0; 
     0            0              1     d; 
     0            0              0     1]; 
 

%finger 1
T451=[sin(theta4)  -cos(theta4)   0     dp ;
      cos(theta4)  sin(theta4)    0     0; 
      0            0              1     0; 
      0            0              0     1]; 

T561=[cos(theta5)   sin(theta5)   0     dl ;
      0             0             -1    0; 
      -sin(theta5)  cos(theta5)   0     0; 
      0             0             0     1]; 

T671=[cos(a*theta5-pi/4)  -sin(a*theta5-pi/4)   0     lf1 ;
      sin(a*theta5-pi/4)  cos(a*theta5-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];

%finger 2
T452=[-sin(theta4)  -cos(theta4)   0     -dp ;
      cos(theta4)  -sin(theta4)    0     0; 
      0            0               1     0; 
      0            0               0     1]; 

T562=[cos(theta6)   sin(theta6)   0     dl ;
      0             0             -1    0; 
      -sin(theta6)  cos(theta6)   0     0; 
      0             0             0     1];  
  
T672=[cos(a*theta6-pi/4)  -sin(a*theta6-pi/4)   0     lf1 ;
      sin(a*theta6-pi/4)  cos(a*theta6-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];
  
%finger 3  
T453=[0    1   0     0;
      -1   0   0     0; 
      0    0   1     0; 
      0    0   0     1];  

T563=[cos(theta7)   sin(theta7)   0     dl;
      0             0             -1    0; 
      -sin(theta7)  cos(theta7)   0     0; 
      0             0             0     1];  
  
T673=[cos(a*theta7-pi/4)  -sin(a*theta7-pi/4)   0     lf1 ;
      sin(a*theta7-pi/4)  cos(a*theta7-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];
  
  
  
P0=[0; 0; 0;1];
P=[lf2;0;0;1];


L1=T01*T12*T23*T34*T451*T561*T671*[1;0;0;0];
L2=T01*T12*T23*T34*T452*T562*T672*[1;0;0;0];
L3=T01*T12*T23*T34*T453*T563*T673*[1;0;0;0];

% f = dot(L1, p1)^2+dot(L2, p2)^2+dot(L3, p3)^2;
% f2=dot(L1, p2)^2+dot(L2, p3)^2+dot(L3, p1)^2;
% f3=dot(L1, p3)^2+dot(L2, p1)^2+dot(L3, p2)^2;


P1=T01*P0;
P2=T01*T12*P0;
P3=T01*T12*T23*P0;
P4=T01*T12*T23*T34*P0;

P51=T01*T12*T23*T34*T451*P0;
P61=T01*T12*T23*T34*T451*T561*P0;
P71=T01*T12*T23*T34*T451*T561*T671*P0;
P712=T01*T12*T23*T34*T451*T561*T671*P;


P52=T01*T12*T23*T34*T452*P0;
P62=T01*T12*T23*T34*T452*T562*P0;
P72=T01*T12*T23*T34*T452*T562*T672*P0;
P722=T01*T12*T23*T34*T452*T562*T672*P;

P53=T01*T12*T23*T34*T453*P0;
P63=T01*T12*T23*T34*T453*T563*P0;
P73=T01*T12*T23*T34*T453*T563*T673*P0;
P732=T01*T12*T23*T34*T453*T563*T673*P;

% T=[0 -1 0 0 ; 1 0 0 0 ; 0 0 1 0; 0 0 0 1];
T=[1 0 0 0 ; 0 0 -1 0 ; 0 1 0 0; 0 0 0 1];
Pp=T*(T01*T12*T23*T34*T453*T563*T673*[0.05; 0;0;0]);

plot3([P0(1), P1(1)],[P0(2),P1(2)],[P0(3),P1(3)],'LineWidth',3);
hold on;
plot3([P1(1), P2(1)],[P1(2),P2(2)],[P1(3),P2(3)],'LineWidth',3);
plot3([P2(1), P3(1)],[P2(2),P3(2)],[P2(3),P3(3)],'LineWidth',3);
plot3([P3(1), P4(1)],[P3(2),P4(2)],[P3(3),P4(3)],'LineWidth',3);

plot3([P4(1), P51(1)],[P4(2),P51(2)],[P4(3),P51(3)],'LineWidth',3);
plot3([P51(1), P61(1)],[P51(2),P61(2)],[P51(3),P61(3)],'LineWidth',3);
plot3([P61(1), P71(1)],[P61(2),P71(2)],[P61(3),P71(3)],'LineWidth',3);
plot3([P71(1), P712(1)],[P71(2),P712(2)],[P71(3),P712(3)],'LineWidth',3);


plot3([P4(1), P52(1)],[P4(2),P52(2)],[P4(3),P52(3)],'LineWidth',3);
plot3([P52(1), P62(1)],[P52(2),P62(2)],[P52(3),P62(3)],'LineWidth',3);
plot3([P62(1), P72(1)],[P62(2),P72(2)],[P62(3),P72(3)],'LineWidth',3);
plot3([P72(1), P722(1)],[P72(2),P722(2)],[P72(3),P722(3)],'LineWidth',3);

plot3([P4(1), P53(1)],[P4(2),P53(2)],[P4(3),P53(3)],'LineWidth',3);
plot3([P53(1), P63(1)],[P53(2),P63(2)],[P53(3),P63(3)],'LineWidth',3);
plot3([P63(1), P73(1)],[P63(2),P73(2)],[P63(3),P73(3)],'LineWidth',3);
plot3([P73(1), P732(1)],[P73(2),P732(2)],[P73(3),P732(3)],'LineWidth',3);

plot3([P73(1),P73(1)+ Pp(1)],[P73(2),P73(2)+Pp(2)],[P73(3),P73(3)+Pp(3)],'LineWidth',3);

grid on;
axis('equal'); 
