% This function add a bunch of electrons in a given region randomly for Q2
% @param numE = number of electrons
%        region = region for the electrons
%        vth = magnitude of the velocity
%        T = temperature in Kelvin
function AddElectrons_Q2(numE, region, vth, T)
global C  % Constants
global x y % arrays for current electron positions
global xp yp % arrays for previous electron positions
global vx vy % arrays for current electron  velocities

% Create the arrays for electrons locations
x = rand(1, numE) * region.x;
xp = x; 
y = rand(1, numE) * region.y;
yp = y;

% TODO: Verify that this is Maxwell-Boltzmann distribution
% mean of vth and standard deviation of sqrt(kT/m)
% Create helper arrays for velocity distrubution
randVx = sqrt(C.kb*T/C.mn).*randn(1, numE)+vth;
randVy = sqrt(C.kb*T/C.mn).*randn(1, numE)+vth;

% Create a helper array for electrons directions
phi = rand(1, numE) * 2*pi;

% Create the arrays for current electron velocities
vx = randVx .* cos(phi);
vy = randVy .* sin(phi);

% Plot the velocity distribution
plotMagVDistribution();

% TODO: remove this debug
display("vth = "+vth);
end
