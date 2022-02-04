% Helper function to find the intersection between a line segment and a circle
% @param  x1,y1 = first coordinate of the line segment
%         x2,y2 = second coordinate of the line segment
%         cx,cy = center of the circle
%         r = radius of the circle
% @return xn,yn = intersection point on the circle
function [xn yn] = findLineCircIntersect(x1, y1, x2, y2, cx, cy, r)
% Declare some variable for easy reading
xc1 = x1-cx;
x12 = x2-x1;
yc1 = y1-cy;
y12 = y2-y1;
a=x12^2+y12^2;
b=2*(xc1*x12+yc1*y12);
c=xc1^2+yc1^2-r^2;

% First, let's find the parameter t for the parametrization of line segment
t = (-b + sqrt(b^2-4*a*c))/(2*a);
% Check that 0<=t<=1
if t<0 || t>1
    % The other solution is the correct solution
    t = (-b - sqrt(b^2-4*a*c))/(2*a);
end

% Next, find the intersection point
xn = x1+t*x12;
yn= y1+t*y12;

end