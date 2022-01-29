% Clear all
clearvars
clearvars -global
close all
format shorte

x = linspace(0,200e-9,5);
y = linspace(0, 100e-9, 5);
[X,Y] = meshgrid(x,y)
Z = [-10 22 4 5 3;
    -8 -5 -6 -2 -1;
    5 4 2 3 -1;
    5 -6 3 2 -5;
    0 1 5 -7 6]
surf(X,Y,Z)
view(0,90)

