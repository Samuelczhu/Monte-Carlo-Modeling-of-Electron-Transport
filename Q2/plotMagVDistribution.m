% Helper function to plot the velocity magnitude distribution
function plotMagVDistribution()
global vx vy

% Calculate the magintude of velocity
magV = sqrt(vx.^2 + vy.^2);

% Plot the velocity distribution histogram 
figure(3)
hist(magV);
title("Velocity Distribution")
ylabel("Counts")
xlabel("Velocity")
end