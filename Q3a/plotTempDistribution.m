% Helper function to plot the temperature distribution
% @ param  nbins = number of bins
function plotTempDistribution(nbins)
global vx vy C

% Calculate the velocity squared
Vsqrt = sqrt(vx.^2 + vy.^2);

% Calculate the temperature
T = C.mn * Vsqrt.^2 / (2*C.kb);

% Plot the velocity distribution histogram 
figure(3)
hist(T, nbins);
title("Temperature Distribution")
ylabel("Counts")
xlabel("Temperature")
end