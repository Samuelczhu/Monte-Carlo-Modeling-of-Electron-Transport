% Helper function to plot one point for electron position
% @param  numEPlot = number of electrons to be plotted
%         numGridX = number of grid on the x axis
%         numGridY = number of grid on the y axis
function PlotPoint(numEPlot, numGridX, numGridY)
global x y xp yp limits

% plot the electron positions
plot([xp(1:numEPlot);x(1:numEPlot)], [yp(1:numEPlot);y(1:numEPlot)])

% Adjust the axis limits
axis(limits)
% Set grid
set(gca,'xtick',linspace(0, limits(2), numGridX));
set(gca, 'ytick',linspace(0, limits(4), numGridY));
grid on

% Add title and labels
title("Electron Modeling");
xlabel("Length (m)")
ylabel("Width (m)")


end