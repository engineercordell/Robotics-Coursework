%% RRR DRAW SHAPE script
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Moves the RRR serial robot through a set of desired e-e points at regular
% intervals using a timer object
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None; Robot should move along desired path
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Robot DH parameters are input into data_RRR.m
%       -GoalPos contains the desired points, where each row is a desired 
%        point: [x, y, theta]
%--------------------------------------------------------------------------

%% Clear variables, open serial
clc; clear all; close all;
% dxl_SerialOpen('COM6');
data_RRR;   % load the physical robot parameters

%% Define parameters
global trigger  % initializes the trigger flag for timing
trigger = 0;

elbowplus = 0;  % set elbow configuration
tstep = 0.2;    % time interval for points in seconds
N = 30; % num points

%% Generate desired path points
%**************************************************************************
% INSERT DESIRED PATH GENERATION FUNCTIONS HERE
displ1 = [11.8, 5.7, -40];
displ2 = [23.4, -3.1, -40];

GoalPos = path_line(displ1, displ2, N); % multiple Xe's, so (xe1, ye1), (xe2, ye2), ... ,(xeN, yeN)

%**************************************************************************

%% Set up timer object
% triggertimer sets the variable trigger to 1 every tstep seconds,
% regulating how the robot steps through points 
triggertimer = timer('ExecutionMode','fixedRate','Period',tstep);
triggertimer.TimerFcn = 'TriggerFcn';

%% Move through points or configurations 
disp('---Beginning Path!---');

% dxl_SetVel(254,10); % use a slower motor velocity
SHELL_RRR_go_configuration(dh, GoalPos(1,:), elbowplus); % move to first point
pause(2);
ActAngles(1,:) = [dxl_GetPos(1),dxl_GetPos(2),dxl_GetPos(3)]; %record angles

i = 2; % start at the second goal point
start(triggertimer);
while i <= length(GoalPos)
    if trigger
        trigger = 0; % reset the trigger flag
        ActAngles(i,:) = [dxl_GetPos(1),dxl_GetPos(2),dxl_GetPos(3)]; %record current joint angles
        SHELL_RRR_go_configuration(dh, GoalPos(i,:), elbowplus); %move to the next point
        i = i+1;
    end
end

disp('---Move Complete!---');

%% Process position data
%**************************************************************************
% CALCULATE ACTUAL E-E POSITION HERE
% Use ActAngles, an Nx3 array of measured joint angles
% Calculate ActPos, Nx3 array of end-effector x,y,phie
%**************************************************************************

ActPose = [];

i = 1;
while i <= length(ActAngles)

    dh.t = [nan, ActAngles(i, 3), 0];
    newdh = RRR_forward(dh);

    % Append the new position to ActPose    
    ActPose = [ActPose; newdh.Xe];

    i = i + 1;
end

%% Plot results
%**************************************************************************
% PLOT JOINT ANGLES AND DESIRED VS ACTUAL E-E POSITION HERE
%**************************************************************************
plot(ActAngles);
plot(GoalPos, ActPose);


%% Stop timers and serial
stop(triggertimer);
delete(triggertimer);
dxl_SerialClose