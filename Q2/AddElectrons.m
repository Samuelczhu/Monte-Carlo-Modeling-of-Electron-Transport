% This function add a bunch of electrons in a given region randomly for Q2
% @param numE = number of electrons
%        region = region for the electrons
%        vth = magnitude of the velocity
%        T = temperature in Kelvin
function AddElectrons(numE, region, vth, T)
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
% Initialize the arrays for velocity distrubution
vx = sqrt(C.kb*T/C.mn).*randn(1, numE);
vy = sqrt(C.kb*T/C.mn).*randn(1, numE);

% Plot the Vth distribution
plotVthDistribution(30);

% Display the vth to compare with the actual distribution 
display("vth = "+vth);
end
