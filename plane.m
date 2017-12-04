function [ output ] = plane( p1, p2, p3 )
%PLANE Summary of this function goes here
%   Detailed explanation goes here
output(1)=det([p1(2) p1(3) p1(4); p2(2) p2(3) p2(4);p3(2) p3(3) p3(4)]);
output(2)=-det([p1(1) p1(3) p1(4); p2(1) p2(3) p2(4);p3(1) p3(3) p3(4)]);
output(3)=det([p1(1) p1(2) p1(4); p2(1) p2(2) p2(4);p3(1) p3(2) p3(4)]);
output(4)=-det([p1(1) p1(2) p1(3); p2(1) p2(2) p2(3);p3(1) p3(2) p3(3)]);

end

