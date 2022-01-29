% Helper function to plot one point for electron position
% @param limitX = region limit on the x axis
%        limitY = region limit on the y axis
function PlotPoint(numGridX, numGridY)
global x y xp yp limits

% plot the electron positions
plot([xp;x], [yp;y])

% Adjust the axis limits
axis(limits)
% Set grid
set(gca,'xtick',linspace(0, limits(2), numGridX))
set(gca, 'ytick',linspace(0, limits(4), numGridY));
grid on

% Add title and labels
title("Electron Modeling");
xlabel("X")
ylabel("Y")


end