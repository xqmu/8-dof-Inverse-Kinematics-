function dist = bhand_ik(input)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    theta1 = input(1);
    theta2 = input(2);
    theta3 = input(3);
    theta4 = input(4);
    theta5 = input(5);
    theta6 = input(6);
    theta7 = input(7);
    d      = input(8);
    %theta1, theta2, theta3, theta4, theta5, theta6, theta7, d

    
    a=45 /140;   %ration betwwen rotation angles of upperlink and lowerlink
    h1=0.487;    %hight of the first link of Adept
    l1=0.325;    %length of the second link of Adpet
    l2=0.275;    %length of the third link of Adpet
    dp=0.025;  %distance from the center of the hand plum to the rotaion aixs of two fingers
    dl=0.050;  %distance from the rotation axis to the top of the upper links of there fingers
    lf1=0.070; %length of the finger's upperlink
    lf2=0.058; %length of the finger's lowerlink

    x1=0.3; y1=0.05; z1=0.2; 
    x2=0.3; y2=0; z2=0.2; 
    x3=0.25; y3=0; z3=0.2; 

    p1=[x1 y1 z1 1];
    p2=[x2;y2;z2;1];
    p3=[x3;y3;z3;1];


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


    L1=T01*T12*T23*T34*T451*T561*T671*[lf2;0;0;1];
    L2=T01*T12*T23*T34*T452*T562*T672*[lf2;0;0;1];
    L3=T01*T12*T23*T34*T453*T563*T673*[lf2;0;0;1];

    dist = (L1(1)/L1(4)-p1(1))^2+(L1(2)/L1(4)-p1(2))^2+(L1(3)/L1(4)-p1(3))^2 ...
         + (L2(1)/L2(4)-p2(1))^2+(L2(2)/L2(4)-p2(2))^2+(L2(3)/L2(4)-p2(3))^2 ...
         + (L3(1)/L3(4)-p3(1))^2+(L3(2)/L3(4)-p3(2))^2+(L3(3)/L3(4)-p3(3))^2;


end

