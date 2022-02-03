% This function add a bunch of electrons in a given region randomly for Q1
% @param numE = number of electrons
%        region = region for the electrons
%        vth = magnitude of the velocity
function AddElectrons(numE, region, vth)
global C  % Constants
global x y % arrays for current electron positions
global xp yp % arrays for previous electron positions
global vx vy % arrays for current electron  velocities

% Create the arrays for electrons locations
x = rand(1, numE) * region.x;
xp = x; 
y = rand(1, numE) * region.y;
yp = y;

% Create a helper array for electrons directions
phi = rand(1, numE) * 2*pi;

% Create the arrays for current electron velocities
vx = vth .* cos(phi);
vy = vth .* sin(phi);

% TODO: remove this debug
display("vth = "+vth);
end
