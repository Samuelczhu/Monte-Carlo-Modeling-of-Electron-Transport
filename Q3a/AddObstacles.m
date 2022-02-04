% Helper function to add the obstacles
function [numBox, numCirc] = AddObstacles()
global boxes  % Matrix for holding the boxes
global circles  % Matrix for holding the circles

% % Create the boxes
% boxes = 1e-9 * [80 0 40 40;
%                 80 60 40 40];
% 
% % Create the circles
% circles = 1e-9 * [170 50 15;
%                   180 10 10];

circles = 1e-9 * [100 50 30];

% Return number of obstacles
numBox = height(boxes);
numCirc = height(circles);
end