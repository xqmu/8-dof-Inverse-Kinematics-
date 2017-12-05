function dist = bhand_ik(input)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    global a h1 l1 l2 dp dl lf1 lf2;
    global p1 p2 p3;
%    global theta1 theta2 theta3 theta4 theta5 theta6 theta7 d t1 t2 t3;

    theta1 = input(1);
    theta2 = input(2);
    theta3 = input(3);
    theta4 = input(4);
    theta5 = input(5);
    theta6 = input(6);
    theta7 = input(7);
    d      = input(8);
    t1     = input(9);
    t2     = input(10);
    t3     = input(11);
 
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


%     P=[lf2;0;0;1];
%     L1=T01*T12*T23*T34*T451*T561*T671*[t1;0;0;1];
%     L2=T01*T12*T23*T34*T452*T562*T672*[t2;0;0;1];
%     L3=T01*T12*T23*T34*T453*T563*T673*[t3;0;0;1];
     
%     lower_link_1 = T01*T12*T23*T34*T451*T561*T671*[1 0 0 1]';
%     sqr = sqrt(lower_link_1(1)^2 + lower_link_1(2)^2 + lower_link_1(3)^2);
%     lower_link_1 = lower_link_1 / sqr;
%     
%     lower_link_2 = T01*T12*T23*T34*T452*T562*T672*[1 0 0 1]';
%     sqr = sqrt(lower_link_2(1)^2 + lower_link_2(2)^2 + lower_link_2(3)^2);
%     lower_link_2 = lower_link_2 / sqr;
%     
%     lower_link_3 = T01*T12*T23*T34*T453*T563*T673*[1 0 0 1]';
%     sqr = sqrt(lower_link_3(1)^2 + lower_link_3(2)^2 + lower_link_3(3)^2);
%     lower_link_3 = lower_link_3 / sqr;

%     dist = (L1(1)/L1(4)-p1(1))^2+(L1(2)/L1(4)-p1(2))^2+(L1(3)/L1(4)-p1(3))^2 ...
%          + (L2(1)/L2(4)-p2(1))^2+(L2(2)/L2(4)-p2(2))^2+(L2(3)/L2(4)-p2(3))^2 ...
%          + (L3(1)/L3(4)-p3(1))^2+(L3(2)/L3(4)-p3(2))^2+(L3(3)/L3(4)-p3(3))^2;
    
    p11=T01*T12*T23*T34*T451*T561*T671*[0;0;0;1];
    p21=T01*T12*T23*T34*T452*T562*T672*[0;0;0;1];
    p31=T01*T12*T23*T34*T453*T563*T673*[0;0;0;1];
    
    p12=T01*T12*T23*T34*T451*T561*T671*[lf2;0;0;1];
    p22=T01*T12*T23*T34*T452*T562*T672*[lf2;0;0;1];
    p32=T01*T12*T23*T34*T453*T563*T673*[lf2;0;0;1];
    
    p11 = p11(1:3);
    p21 = p21(1:3);
    p31 = p31(1:3);
    p12 = p12(1:3);
    p22 = p22(1:3);
    p32 = p32(1:3);
    
    p10 = p1(1:3);
    p20 = p2(1:3);
    p30 = p3(1:3);
    
    d1  = norm(cross((p10 - p11), (p10 - p12))) / norm(p12 - p11); 
    d2  = norm(cross((p20 - p21), (p20 - p22))) / norm(p22 - p21); 
    d3  = norm(cross((p30 - p31), (p30 - p32))) / norm(p32 - p31); 
    
    dist = d1^2 + d2^2 + d3^3;
end

