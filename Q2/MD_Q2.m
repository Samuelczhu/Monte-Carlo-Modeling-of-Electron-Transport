% This file is the code for ELEC 4700 assignment 1 question 2
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
display("Expected Mean free path is "+ d);
% Initialize the number of electrons
numE = 10000;
numEPlot = 10;  % Number of electron to be plotted
% Initialize the time
deltaT = 2e-14; % Time interval per simulation step in second
pauseTime = 0.02; % Time paused per simulation step in second
simTime = 0;  % Hold the current simulation time
% Number of simulation steps
numSim = 500;
% Temperature grid
numGridX = 10; % number of grid in x direction
numGridY = 10; % number of grid in y direction
% Array to hold temperature over time
tempOverTime = zeros(1,numSim);
% Variables for actual mean free paths and mean collision time calculations
totalFP = 0;  % total free path
totalFT = 0;  % total free time
countFPFT = 0;  % count for scattering
arrScatterPx = zeros(1, numE);  % Hold the previous scattering point: index to target previous point for an electron
arrScatterPy = zeros(1, numE); 
arrScatterT = zeros(1, numE);  % Hold the previous scattering time: index to target previous scatter time for an electron


% Add the electrons
AddElectrons(numE, Region, vth, T);

% Calculate the scattering probability
Pscat = 1-exp(-deltaT/Tmn);

% Initalize plot
figure(1)
ax = axes;
ax.ColorOrder = rand(numEPlot,3); % Initalize color for each electron
hold on

% Loop for simulation
for iSim = 1:numSim
     PlotPoint(numEPlot, numGridX, numGridY);

     % Store the current positions
     xp = x;
     yp = y;
     % Calculate the future positions: x = x0 + vx*t
     x = x + vx * deltaT;
     y = y + vy * deltaT;

     % Increment simulation time
     simTime = simTime + deltaT;
     
    % Loop through all the particles 
    for iE=1:numE
        % flag for invalid
        bInvalid = false;
        % Check for invalid x position
        if x(iE) < 0
            x(iE) = Region.x; % Appear on right
            xp(iE) = x(iE); 
            bInvalid = true;
        elseif x(iE) > Region.x
            x(iE) = 0; % Appear on left 
            xp(iE) = x(iE);
            bInvalid = true;
        end
        % Check for invalid y position
        if y(iE) < 0
            y(iE) = 0; % Reflect
            vy(iE) = -vy(iE);
            bInvalid = true;
        elseif y(iE) > Region.y
            y(iE) = Region.y; % Reflect
            vy(iE) = -vy(iE);
            bInvalid = true;
        end
        
        % Check for scattering
        if ~bInvalid && Pscat > rand()
            % Rethermalize
            vx(iE) = sqrt(C.kb*T/C.mn).*randn();
            vy(iE) = sqrt(C.kb*T/C.mn).*randn();
            % Calculate the free path
            deltaX = x(iE) - arrScatterPx(iE);
            deltaY = y(iE) - arrScatterPy(iE);
            totalFP = totalFP + sqrt(deltaX^2 + deltaY^2);
            arrScatterPx(iE) = x(iE);  % Update the previous scatter position
            arrScatterPy(iE) = y(iE);
            % Calculate the free time
            totalFT = totalFT + simTime - arrScatterT(iE);
            arrScatterT(iE) = simTime;  % Update the previous scatter time
            % Increment the count
            countFPFT = countFPFT+1;
        end
    end
    
    % Calculate the current average temperature
    % tempOverTime(iSim) = sum(sqrt(vx.^2)+sqrt(vy.^2))/numE;
    % tempOverTime(iSim) = C.mn*(sum(vx.^2+vy.^2)/numE)/(2*C.kb);
    vth2_mean = mean(sqrt(vx.^2+vy.^2)).^2;
    tempOverTime(iSim) = C.mn*vth2_mean/(2*C.kb);

    % Pause some time
    pause(pauseTime);
end

% Plot the temperature plot
tempDisplay(numGridX, numGridY, numE, Region.x, Region.y);

% Plot average temperature over time
figure(4)
plot(deltaT*(1:numSim), tempOverTime);
title("Temperature over time");
xlabel("Time (s)");
ylabel("Temperature (K)");
ylim([0 inf]);
grid on


% Calculate the actual mean free path and mean time between collision
meanFreePath = totalFP/countFPFT;
meanTimeCollision = totalFT/countFPFT; 
display("Actual mean free path: "+meanFreePath);
display("Mean time between collision: "+meanTimeCollision);




