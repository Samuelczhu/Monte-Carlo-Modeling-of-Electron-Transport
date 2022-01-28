% Helper function to plot one point for electron position
function PlotPoint()
global x y xp yp limits

% plot the electron positions
plot([xp;x], [yp;y])

% Adjust the axis limits
axis(limits)

% Add title and labels
title("Electron Modeling");
xlabel("X")
ylabel("Y")


end