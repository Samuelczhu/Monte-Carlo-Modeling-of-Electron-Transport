% This function add a bunch of electrons in a given region randomly for Q3a
% @param numE = number of electrons
%        region = region for the electrons
%        vth = magnitude of the velocity
%        T = temperature in Kelvin
%        numBox = number of boxes
%        numCirc = number of circles
function AddElectrons(numE, region, vth, T, numBox, numCirc)
global C  % Constants
global x y % arrays for current electron positions
global xp yp % arrays for previous electron positions
global vx vy % arrays for current electron velocities
global boxes  % Matrix for the boxes: [x y w h]
global circles  % Matrix for the circles: [x y r]

% Create the arrays for electrons locations
x = rand(1, numE) * region.x;
y = rand(1, numE) * region.y;

% Loop through the electrons to make sure that no electrons inside obstacles
for iE = 1:numE
    % Flag to indicate whether inside an obstacle
    insideObstacles = true;
    while (insideObstacles)
        insideObstacles = false;
        % Loop through the boxes
        for iBox = 1:numBox
            % Check for invalid electrons position
            if (x(iE)>=boxes(iBox, 1) && x(iE)<=(boxes(iBox, 1)+boxes(iBox, 3)) ...
                    && y(iE)>=boxes(iBox, 2) && y(iE) <= (boxes(iBox, 2)+boxes(iBox, 4)))
                insideObstacles = true;
                break;
            end
        end
        % If not inside box, check whether inside circles
        if ~insideObstacles
            % Loop through the circles
            for iCirc = 1:numCirc
                % Check for invalid electrons position
                if (x(iE)-circles(iCirc,1))^2 + (y(iE)-circles(iCirc,2))^2 <= circles(iCirc,3)^2
                    insideObstacles = true;
                    break;
                end
            end
        end
        % If inside an obstacle, regenerate position
        if (insideObstacles)
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
randVx = sqrt(C.kb*T/C.mn).*randn(1, numE)+vth;
randVy = sqrt(C.kb*T/C.mn).*randn(1, numE)+vth;

% Create a helper array for electrons directions
phi = rand(1, numE) * 2*pi;  % TODO: check whether we need phi, phi seems to add negative effect

% Create the arrays for current electron velocities
vx = randVx .* cos(phi);
vy = randVy .* sin(phi);

% Plot the velocity distribution
plotMagVDistribution();

% TODO: remove this debug
display("vth = "+vth);
end
