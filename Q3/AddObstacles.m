% Helper function to add the obstacles
function [numBox] = AddObstacles()
global boxes  % Matrix for holding the boxes

% Create the boxes
boxes = 1e-9 * [80 0 40 40;
                80 60 40 40];

% Return number of boxes
numBox = height(boxes);
end