% This function generate a 2D temperature color plot
% @param numGridX = number of grid in the x direction
%        numGridY = number of grid in the y direction
%        numE = number of electrons
%        limitX = region limit on the x axis
%        limitY = region limit on the y axis
function tempDisplay(numGridX, numGridY, numE, limitX, limitY)
% Global varibles use for temperature calculation
global x y vx vy C
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

    % Calculate the velocity squared
    Vsqrt = sqrt(vx(iE)^2 + vy(iE)^2);
    % Calculate the temperature
    T = C.mn * Vsqrt^2 / (2*C.kb);

    % Increment the total temperature matrix
    matrixTempTotal(indexRow, indexCol) = matrixTempTotal(indexRow, indexCol) + T;  
    % Increment the particle matrix
    matrixParticles(indexRow, indexCol) = matrixParticles(indexRow, indexCol) + 1;
end

% Calculate the temperature matrix
Temp = matrixTempTotal ./ matrixParticles;
Temp(isnan(Temp)) = 0;

% Create the mesh grid
[X,Y] = meshgrid(linspace(0,limitX,numGridX+1), linspace(0, limitY, numGridY+1));
% Plot the surface
figure(2)
surf(X,Y,Temp);
view(0,90); % view from the top

end