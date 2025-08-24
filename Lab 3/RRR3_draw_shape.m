%% RRR3 DRAW SHAPE script
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Moves the 3RRR parallel robot through a set of desired e-e points at regular
% intervals using a timer object
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Robot DH parameters are input into data_RRR.m
%       -GoalPos contains the desired points, where each row is a desired 
%        point: [x, y, theta]
%--------------------------------------------------------------------------

%% Clear variables, open serial
clc; clear all; close all;
dxl_SerialClose;
dxl_SerialOpen_RRR3('COM6');
data_RRR3;

%% Define parameters
global trigger  % initializes the trigger flag for timing
trigger = 0;
elbowplus = 1;
tstep = 0.2;    % time interval for points in seconds

%% Generate desired path points
%**************************************************************************
% INSERT DESIRED PATH GENERATION FUNCTIONS HERE
%
%**************************************************************************

%% Set up timer object
% triggertimer sets the variable trigger to 1 every tstep seconds,
% regulating how the robot steps through points 
triggertimer = timer('ExecutionMode','fixedRate','Period',tstep);
triggertimer.TimerFcn = 'TriggerFcn';

%% Move through points or configurations 
disp('---Beginning Path!---');

dxl_SetVel(254,80); % use a slower motor velocity
RRR3_go_configuration(dh, GoalPos(1,:), elbowplus); % move to first point
pause(2);
ActAngles(1,:) = [dxl_GetPos(1),dxl_GetPos(2),dxl_GetPos(3)]; %record angles

i = 2; % start at the second goal point
start(triggertimer);
while i <= length(GoalPos)
    if trigger
        trigger = 0; % reset the trigger flag, then move/record next point
        ActAngles(i,:) = [dxl_GetPos(1),dxl_GetPos(2),dxl_GetPos(3)];
        RRR3_go_configuration(dh, GoalPos(i,:), elbowplus);
        i = i+1;
    end
end
ActAngles(i,:) = [dxl_GetPos(1),dxl_GetPos(2),dxl_GetPos(3)];

disp('---Move Complete!---');

%% Plot results
% figure(1)
% hold on;
% plot(ActAngles,'b')

%% Stop timers and serial
stop(triggertimer);
delete(triggertimer);
dxl_SerialClose