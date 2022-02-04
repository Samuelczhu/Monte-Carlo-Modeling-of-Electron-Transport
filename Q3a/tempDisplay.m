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

% Create the matrix for particle and total temperature
matrixParticles = zeros(numGridX+1,numGridY+1);
matrixTempTotal = zeros(numGridX+1, numGridY+1);

% Calculate the deltaX and deltaY for each grid
deltaX = limitX/numGridX;
deltaY = limitY/numGridY;

% Loop through all the electrons
for iE = 1:numE
    % Calculate the x index (column) in the tempeture matrix
    indexCol = floor(x(iE)/deltaX)+1;
    indexRow = floor(y(iE)/deltaY)+1;
%     % Check for invalid index
%     if indexRow <=0
%         indexRow = 1;
%     end
%     if indexCol <= 0
%         indexCol = 1;
%     end

    % TODO: Calculate the temperature of the particle
    vth = sqrt(vx(iE)^2 + vy(iE)^2);
    % Increment the total temperature matrix
    matrixTempTotal(indexRow, indexCol) = matrixTempTotal(indexRow, indexCol) + vth;  
    % Increment the particle matrix
    matrixParticles(indexRow, indexCol) = matrixParticles(indexRow, indexCol) + 1;
end

% Calculate the temperature matrix
Temp = matrixTempTotal ./ matrixParticles;
Temp(isnan(Temp)) = 0;

% Create the mesh grid
[X,Y] = meshgrid(linspace(0,limitX,numGridX+1), linspace(0, limitY, numGridY+1));
% Plot the surface for temperature map
figure(2)
surf(X,Y,Temp);
view(0,90); % view from the top
title("Temperature Map")

% Plot the surface for density map
figure(5)
surf(X,Y, matrixParticles);
view(0,90); % view from the top
title("Density Map")

% TODO: seek help on temperature and density map, they seems not correct
matrixParticles

end