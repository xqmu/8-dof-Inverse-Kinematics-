function [] = draw_bhand(input)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    theta1 = input(1);
    theta2 = input(2);
    theta3 = input(3);
    theta4 = input(4);
    theta5 = input(5);
    theta6 = input(6);
    theta7 = input(7);
    d      = input(8);
    
    a= 45 /140;   %ration betwwen rotation angles of upperlink and lowerlink
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


%     L1=T01*T12*T23*T34*T451*T561*T671*[1;0;0;0];
%     L2=T01*T12*T23*T34*T452*T562*T672*[1;0;0;0];
%     L3=T01*T12*T23*T34*T453*T563*T673*[1;0;0;0];

    % f1 = dot(L1, p1)^2+dot(L2, p2)^2+dot(L3, p3)^2;
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
    
    plot3(p1(1), p1(2), p1(3), '*');
    plot3(p2(1), p2(2), p2(3), '.');
    plot3(p3(1), p3(2), p3(3), 'o');
    
    grid on;
    axis('equal'); 
end

