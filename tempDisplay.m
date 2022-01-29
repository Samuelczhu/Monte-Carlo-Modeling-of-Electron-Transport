% This function generate a 2D temperature color plot
% @param numGridX = number of grid in the x direction
%        numGridY = number of grid in the y direction
%        numE = number of electrons
%        limitX = region limit on the x axis
%        limitY = region limit on the y axis
function tempDisplay(numGridX, numGridY, numE, limitX, limitY)
% Global varibles use for temperature calculation
global x y vx vy  
global limits 

% Create the temperature matrix
Temp = zeros(numGridX,numGridY);

% Calculate the deltaX and deltaY for each grid
deltaX = limitX/numGridX;
deltaY = limitY/numGridY;

% Loop through all the electrons
for iE = 1:numE
    % Calculate the x index (column) in the tempeture matrix
    indexCol = floor(x(iE)/deltaX) + 1;
    indexRow = floor(y(iE)/deltaY) + 1;
    % TODO: Calculate the temperature
    
    % Increment the temperature matrix
    Temp(indexRow, indexCol) = Temp(indexRow, indexCol) + 1;
end

% Create the mesh grid
[X,Y] = meshgrid(linspace(0,limitX,numGridX), linspace(0, limitY, numGridY));
% Plot the surface
figure(2)
surf(X,Y,Temp);
view(0,90); % view from the top

end