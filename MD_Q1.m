% This file is the code for ELEC 4700 assignment 1 question 1
% Electron Modeling

% Clear all
clearvars
clearvars -global
close all
format shorte

% Global variables
global C % constants module that holds all the constants
global x y % x and y arrays for the electrons position
% Initalize global constants
globalVars

% Initialize the region size 200nm X 100nm
Region.x = 200e-9;
Region.y = 100e-9; 
limits = [0 Region.x 0 Region.y];  % plot limit
% Initialize the temperature
T = 300;  % K
vth = sqrt(2*C.kb*T/C.mn);  % Calculate the thermal velocity
% Initialize the mean time between collision
Tmn = 0.2e-12;  % 0.2ps
% Initialize the number of electrons
numE = 10;

% Add the electrons
AddElectrons(numE, Region, vth);

% Plot the points
PlotPoints("Electron Modeling", limits);



