% Helper function to find the reflected vector from an incident vector
% @param  xn,yn = point of intersection on the circle
%         vix, viy = incident vector
%         cx, cy = center of the circle
% @return vrx, vry = reflected vector
function [vrx, vry] = findCircReflect(xn, yn, vix, viy, cx, cy)

% Caclulate the normal vector
n = [xn-cx; yn-cy];
n = n/norm(n);  % Normalize

% Incident vector
d = [vix; viy];
magD = norm(d);  % magnitude of the incident vector

% Calculate the reflected vector direction
r = d - 2*dot(d,n)*n;
theta = angle(r(1)+1j*r(2));  % angle for the reflected vector

% Return the result
vrx = magD*cos(theta);
vry = magD*sin(theta);

end