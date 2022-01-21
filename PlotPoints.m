% Helper function to plot the points
% @param limits = limits for the x and y axis
function PlotPoints(plotTitle, limits)
global x y

% Plot the electron points
plot(x, y, "bo");
% Adjust the axis limits
axis(limits)


% Add title and labels
title(plotTitle);
xlabel("X")
ylabel("Y")
end