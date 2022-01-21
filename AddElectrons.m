% This function add a bunch of electrons in a given region randomly
% @param numE = number of electrons
%        region = region for the electrons
%        initial velocity for the e
function AddElectrons(numE, region, vth)
global x y

% create the x locations for the points
x = rand(numE, 1) * region.x;
y = rand(numE, 1) * region.y;

end
