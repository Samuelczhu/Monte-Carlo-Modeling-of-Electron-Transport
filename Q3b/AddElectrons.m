% This function add a bunch of electrons in a given region randomly for Q3b
% @param numE = number of electrons
%        region = region for the electrons
function AddElectrons(numE, region)
global x y % arrays for current electron positions
global xp yp % arrays for previous electron positions
global vx vy % arrays for current electron velocities

% Create the arrays for electrons locations
x = -10*ones(1, numE);
y = region.y/2 * ones(1, numE);

% Create the arrays for previous electron positions
xp = x; 
yp = y;

% Create arrays for velocity
vx = zeros(1, numE);
vy = zeros(1, numE);
end
