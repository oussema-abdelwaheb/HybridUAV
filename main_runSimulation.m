clear; clc; close all;
addpath(genpath(pwd));

% --- Select battery capacity (Wh)
batteryCapacity = 600; 

% --- Build mission profile
mission = missionProfile();

% --- Run hybrid UAV simulation
results = simulateHybridUAV(mission, batteryCapacity);

% --- Generate professional plots
plotResults(results, mission);

disp('Simulation complete.');
