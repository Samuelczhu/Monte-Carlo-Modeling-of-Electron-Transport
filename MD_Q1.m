% This file is the code for ELEC 4700 assignment 1 question 1
% Electron Modeling

% Clear all
clearvars
clearvars -global
close all
format shorte

% Make plot pretier
set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth', 2);

% Global variables
global C         % constants module that holds all the constants
global x y       % arrays for the current electrons positions: 1 row, colum for current position 
global xp yp     % arrays for the previous electrons positions: 1 row, column for previous position
global vx vy     % arrays for current electrons velocities: 1 row, column for current velocity
global limits    % Limits for the plot
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
d = Tmn*vth;
fprintf("Mean path is %f\n", d);
% Initialize the number of electrons
numE = 3;
% Initialize the time
deltaT = 2e-14; % Time interval per simulation step in second
pauseTime = 0.005; % Time paused per simulation step in second
% Number of simulation steps
numSim = 1000;

% Add the electrons
AddElectrons(numE, Region, vth);

% Initalize plot
ax = axes;
ax.ColorOrder = rand(numE,3); % Initalize color for each electron
hold on

% Loop for simulation
for iSim = 1:numSim
     PlotPoint();

     % Store the current positions
     xp = x;
     yp = y;
     % Calculate the future positions: x = x0 + vx*t
     x = x + vx * deltaT;
     y = y + vy * deltaT;
     
    % Loop through all the particles for boundary collision
    for iE=1:numE
        % Check for invalid x position
        if x(iE) < 0
            x(iE) = 0;
            vx(iE) = -vx(iE);
        elseif x(iE) > Region.x
            x(iE) = Region.x;
            vx(iE) = -vx(iE);
        end
        % Check for invalid y position
        if y(iE) < 0
            y(iE) = 0;
            vy(iE) = -vy(iE);
        elseif y(iE) > Region.y
            y(iE) = Region.y;
            vy(iE) = -vy(iE);
        end
    end


    
    % Pause some time
    pause(pauseTime);
end






