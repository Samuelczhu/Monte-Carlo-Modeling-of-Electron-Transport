% This function add a bunch of electrons in a given region randomly for Q3
% @param numE = number of electrons
%        region = region for the electrons
%        vth = magnitude of the velocity
%        T = temperature in Kelvin
%        numBox = number of boxes
function AddElectrons(numE, region, vth, T, numBox)
global C  % Constants
global x y % arrays for current electron positions
global xp yp % arrays for previous electron positions
global vx vy % arrays for current electron velocities
global boxes  % Matrix for the boxes position

% Create the arrays for electrons locations
x = rand(1, numE) * region.x;
y = rand(1, numE) * region.y;

% Loop through the electrons to make sure that no electrons inside obstacles
for iE = 1:numE
    % Flag to indicate whether inside box
    insideBox = true;
    while (insideBox)
        insideBox = false;
        % Loop through the boxes
        for iBox = 1:numBox
            % Check for invalid electrons position
            if (x(iE)>boxes(iBox, 1) && x(iE)<(boxes(iBox, 1)+boxes(iBox, 3)) ...
                    && y(iE)>boxes(iBox, 2) && y(iE) < (boxes(iBox, 2)+boxes(iBox, 4)))
                insideBox = true;
                break;
            end
        end
        if (insideBox)
            % Regenerate position
            x(iE) = rand() * region.x;
            y(iE) = rand() * region.y;
        end
    end
end

% Create the arrays for previous electron positions
xp = x; 
yp = y;

% TODO: Verify that this is Maxwell-Boltzmann distribution
% mean of vth and standard deviation of sqrt(kT/m)
% Create helper arrays for velocity distrubution
vx = sqrt(C.kb*T/C.mn).*randn(1, numE);
vy = sqrt(C.kb*T/C.mn).*randn(1, numE);

% Plot the temperature distribution
plotTempDistribution(30);

% TODO: remove this debug
display("vth = "+vth);
end
