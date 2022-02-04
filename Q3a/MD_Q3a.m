% This file is the code for ELEC 4700 assignment 1 question 3a: curved surface
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
global boxes     % matrix for the boxes: each row is one box with 4 columns for [x y w h]
global circles   % matrix for the circles: each row is one circle with 3 columns for [x y r]
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
display("Mean path is "+ d);
% Initialize the number of electrons
numE = 3;
% Initialize the time
deltaT = 2e-14; % Time interval per simulation step in second
pauseTime = 0.02; % Time paused per simulation step in second
% Number of simulation steps
numSim = 500;
% Temperature grid
numGridX = 10; % number of grid in x direction
numGridY = 10; % number of grid in y direction
% Array to hold temperature over time
tempOverTime = zeros(1,numSim);
% Boudary mode: specular(0) or diffusive(1)
boundaryMode = 0;

% Add the boxes
[numBox, numCirc] = AddObstacles();

% Add the electrons
AddElectrons(numE, Region, vth, T, numBox, numCirc);

% Calculate the scattering probability
Pscat = 1-exp(-deltaT/Tmn);

% Initalize plot
figure(1)
ax = axes;
ax.ColorOrder = rand(numE,3); % Initalize color for each electron
hold on
% Draw the boxes
for iBox = 1:numBox
    rectangle("Position",boxes(iBox,:));
end
% Draw the circles
for iCirc = 1:numCirc
    d = circles(iCirc, 3)*2;
    px = circles(iCirc,1)-circles(iCirc, 3);
    py = circles(iCirc,2)-circles(iCirc, 3);
    rectangle("Position",[px py d d], "Curvature",[1,1]);
    daspect([1,1,1]);
end


% Loop for simulation
for iSim = 1:numSim
     PlotPoint(numGridX, numGridY);

     % Store the current positions
     xp = x;
     yp = y;
     % Calculate the future positions: x = x0 + vx*t
     x = x + vx * deltaT;
     y = y + vy * deltaT;
     
    % Loop through all the particles 
    for iE=1:numE
        % flag for invalid position
        bInvalid = false;

        % Step 1 - Check for boundaries
        % Check for invalid x position
        if x(iE) <= 0
            x(iE) = Region.x; % Appear on right
            xp(iE) = x(iE); 
            bInvalid = true;
        elseif x(iE) >= Region.x
            x(iE) = 0; % Appear on left 
            xp(iE) = x(iE);
            bInvalid = true;
        end
        % Check for invalid y position
        if y(iE) <= 0
            bInvalid = true;
            y(iE) = 0;
            % Check for boundary mode
            if boundaryMode == 0  % Specular boundary
                vy(iE) = -vy(iE);
            else  % Diffusive boundary  TODO: check randn() is between 0-1, and check for diffusive implementation
                vy(iE) = (sqrt(C.kb*T/C.mn).*randn()+vth);
            end
        elseif y(iE) >= Region.y
            y(iE) = Region.y;
            bInvalid = true;
            % Check for boundary mode
            if boundaryMode == 0  % Specular boundary
                vy(iE) = -vy(iE);
            else  % Diffusive boundary
                vy(iE) = -(sqrt(C.kb*T/C.mn).*randn()+vth);
            end
        end

        % Step 2: Check for boxes
        for iBox = 1:numBox
            % Retrieve box info
            boxX1 = boxes(iBox, 1);
            boxX2 = boxes(iBox, 1)+boxes(iBox, 3);
            boxY1 = boxes(iBox, 2);
            boxY2 = boxes(iBox, 2)+boxes(iBox, 4);
            % Check if the particle is inside a box
            if (x(iE)>=boxX1 && x(iE)<=boxX2 && y(iE)>=boxY1 && y(iE) <= boxY2)
                bInvalid = true;   %Invalid position
                % Check for x position
                if xp(iE) <= boxX1  % Coming from left side
                    x(iE) = boxX1;
                    % Check for boundary mode
                    if boundaryMode == 0  % Specular boundary
                        vx(iE) = -vx(iE);
                    else  % Diffusive boundary
                        vx(iE) = -(sqrt(C.kb*T/C.mn).*randn()+vth);
                    end                    
                elseif xp(iE) >= boxX2  % Coming from right side
                    x(iE) = boxX2;                   
                    % Check for boundary mode
                    if boundaryMode == 0  % Specular boundary
                        vx(iE) = -vx(iE);
                    else  % Diffusive boundary
                        vx(iE) = (sqrt(C.kb*T/C.mn).*randn()+vth);
                    end
                end
                % Check for y position
                if yp(iE) <= boxY1  % Coming from bottom
                    y(iE) = boxY1;               
                    % Check for boundary mode
                    if boundaryMode == 0  % Specular boundary
                        vy(iE) = -vy(iE);
                    else  % Diffusive boundary
                        vy(iE) = -(sqrt(C.kb*T/C.mn).*randn()+vth);
                    end
                elseif yp(iE) >= boxY2 % Coming from top
                    y(iE) = boxY2;                   
                    % Check for boundary mode
                    if boundaryMode == 0  % Specular boundary
                        vy(iE) = -vy(iE);
                    else  % Diffusive boundary
                        vy(iE) = (sqrt(C.kb*T/C.mn).*randn()+vth);
                    end
                end
                % Break the loop for box
                break;
            end
        end

        % Step 3: Check for circles if not invalid yet
        if ~bInvalid
            for iCirc=1:numCirc
                % Retrieve the circle info
                cx = circles(iCirc, 1);
                cy = circles(iCirc, 2);
                cr = circles(iCirc, 3);
                % Check if the particle is inside the circle
                if (x(iE)-cx)^2 + (y(iE)-cy)^2 <= cr^2
                    bInvalid = true;   % Invalid position
                    % First, find the intersection point (xn, yn)
                    xn=x(iE);  % Default assume on the circle
                    yn=y(iE);
                    if (x(iE)-cx)^2 + (y(iE)-cy)^2 < cr^2
                        [xn, yn] = findLineCircIntersect(xp(iE), yp(iE), x(iE), y(iE),cx,cy,cr);
                    end
                    % Second, update the current position to be that intersect point
                    x(iE) = xn;
                    y(iE) = yn;
                    % Third, find the reflected velocity vector
                    [vrx, vry] = findCircReflect(xn,yn,vx(iE),vy(iE), cx, cy);
                    % Finally, updates the velocity vector
                    vx(iE) = vrx;
                    vy(iE) = vry;
                    % Break the loop
                    break;
                end
            end
        end

        
%         % Step 4: Check for scattering
%         if ~bInvalid && Pscat > rand()
%             % Scatter the particle  TODO: Check whether we need phi
%             randPhi = rand()*2*pi;  % Random direction
%             % Rethermalize
%             vx(iE) = (sqrt(C.kb*T/C.mn).*randn()+vth) * cos(randPhi);
%             vy(iE) = (sqrt(C.kb*T/C.mn).*randn()+vth) * sin(randPhi);
%         end
    end
    
    % Calculate the current average temperature
    tempOverTime(iSim) = sum(sqrt(vx.^2)+sqrt(vy.^2))/numE;

    % Pause some time
    pause(pauseTime);
end

% Plot the temperature plot
tempDisplay(numGridX, numGridY, numE, Region.x, Region.y);

% Plot average temperature over time
figure(4)
plot(deltaT*(1:numSim), tempOverTime);
title("Temperature over time");
xlabel("Time");
ylabel("velocity");
ylim([0 inf]);
grid on





