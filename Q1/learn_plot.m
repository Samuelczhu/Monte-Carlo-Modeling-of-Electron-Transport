% Clear all
clearvars
clearvars -global
close all
format shorte

limits=[-10 10 -10 10];

ax = axes;
hold on
ax.ColorOrder = rand(5, 3);
x0 = [0 0 0 0 7];
y0 = [0 0 0 0 -5];
x1 = [1 2 3 7 2];
y1 = [1 5 0 6 -4];
plot([x0;x1], [y0;y1])
axis(limits)
pause(1)

x2 = [-2 5 6 3 0];
y2 = [2 7 1 -1 -5];
plot([x1;x2], [y1;y2])
axis(limits)
pause(1)

x3 = [-8 -2 8 -3 6];
y3 = [-7 5 -2 -2 8];
plot([x2; x3], [y2; y3])
axis(limits)
pause(1)