% Helper function to find the reflected vector from an incident vector
% @param  xn,yn = point of intersection on the circle
%         vix, viy = incident vector
%         cx, cy = center of the circle
% @return vrx, vry = reflected vector
function [vrx, vry] = findCircReflect(xn, yn, vix, viy, cx, cy)

% Retrieve the incident vector
vi = [vix;viy];
vnorm = norm(vi); % Normalized value of vi

% Let's find the normal vector on the circle
n = [xn-cx; yn-cy];

% Let's find the angle of the normal vector
alpha = angle(n(1)+1j*n(2));

% Define the rotation matrix to rotate alpha clockwise
RACW = [cos(alpha), sin(alpha); 
        -sin(alpha), cos(alpha)];

% Define the mirror matrix to mirror along x axis
MX = [1, 0;
      0, -1];

% Define the rotation matrix to rotate alpha counter-clockwise
RACC = [cos(alpha), sin(alpha)
        -sin(alpha), cos(alpha)];

% Calculate the reflection vector
vr = RACC*MX*RACW*(-1*vi);

% Calculate the angle of the reflection vector
theta = angle(vr(1)+1j*vr(2));

% Return the results
vrx = vnorm * cos(theta);
vry = vnorm*sin(theta);

display([vrx, vry])

end