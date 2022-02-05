% This file is a helper file to test the line circle intersection

% Clear all
clearvars
clearvars -global
close all
format shorte

% x = [2,3];  
% y = [4,3];
% x = [3,2];  
% y = [3,4];

circle = [4, 2, 2];  % [x y r]

% Plot
figure(1)
% Draw the circle
d = circle(3)*2;
px = circle(1)-circle(3);
py = circle(2)-circle(3);
rectangle("Position",[px py d d], "Curvature",[1,1]);
daspect([1,1,1]);
hold on
% Plot the line segment
plot(x,y)

% Calculate the intersect
[xn, yn] = findLineCircIntersect(x(1),y(1),x(2),y(2),circle(1),circle(2),circle(3))
% Plot the intersect
plot(xn,yn, "o")
