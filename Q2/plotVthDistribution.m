% Helper function to plot the vth distribution
% @ param  nbins = number of bins
function plotVthDistribution(nbins)
global vx vy

% Calculate the vth
Vth_data = sqrt(vx.^2 + vy.^2);

% Plot the velocity distribution histogram 
figure(3)
hist(Vth_data, nbins);
title("Vth Distribution")
ylabel("Counts")
xlabel("Velocity")
end