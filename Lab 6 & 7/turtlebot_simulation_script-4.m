fprintf('What did I say about running this as a script?!');
return;
%------------------------------------------------
% DON'T RUN THIS SCRIPT
% RUN EACH CODE BLOCK INDPENDENTLY (ctrl+enter)
%------------------------------------------------

%%
clc; close all;
% clear;
format compact; format shortg;
set(0, 'DefaultFigureWindowStyle', 'docked');

%% Initialize Turtlebot connection through ROS
turtlebot_ip = '192.168.62.128';  % this is now the ip address you see next to 'inet' when you type 'ifconfig' in the virtual machine
rosinit(turtlebot_ip);

%% Explore the available topics on your Turtlebot
rostopic list               % list the topics in the command window

% You will see the typical turtlebot typics in addition to others related to the gazebo simulation:
% /gazebo/link_states           
% /gazebo/model_states          
% /gazebo/parameter_descriptions
% /gazebo/parameter_updates     
% /gazebo/performance_metrics   
% /gazebo/set_link_state 

% /gazebo/set_model_state   will be particularly useful since it will help us brute force reset the turtlebot    


%% Create Publishers and Subscribers
velocityPublisher = rospublisher('/cmd_vel');% create a publisher to use to send velocites to robot
odometrySubscriber = rossubscriber('/odom');  % create a subscriber to receive odometry information from robot
lidarSubscriber = rossubscriber('/scan');     % create a subscriber to receive laser data from robot

modelStatesSubscriber = rossubscriber('/gazebo/model_states');     % create a publisher to reset the robot's odometry
moveModelsPublisher = rospublisher('/gazebo/set_model_state');     % create a publisher to reset the robot's odometry

%% Examine the messages for your chosen topics - Creates empty message with required structure
velocityMessage = rosmessage(velocityPublisher) % use rosmessage to determine the type of message velocityPublisher uses
odometryMessage = rosmessage(odometrySubscriber);
lidarMessage = rosmessage(lidarSubscriber);

moveModelsMessage = rosmessage(moveModelsPublisher)

%% Change the pose of the turtlebot to place it at the origin or the pose of your choice
moveModelsMessage = rosmessage(moveModelsPublisher)
moveObjectsMessage.ModelName = 'turtlebot3_burger';

% robot_start_pose = [0, 0, deg2rad(180)];      % you might have to use 180 instead of 0 degrees to get the robot to face forward
% robot_start_pose = [0, 0, deg2rad(0)];
robot_start_pose = [-3, -5, deg2rad(180)];

moveModelsMessage.Pose.Position.X = robot_start_pose(1);
moveModelsMessage.Pose.Position.Y = robot_start_pose(2);

orientation_as_quaternion = eul2quat([0, pi, robot_start_pose(3)]);       % you may have to change pi to another value
moveModelsMessage.Pose.Orientation.X = orientation_as_quaternion(1);
moveModelsMessage.Pose.Orientation.Y = orientation_as_quaternion(2);
moveModelsMessage.Pose.Orientation.Z = orientation_as_quaternion(3);
moveModelsMessage.Pose.Orientation.W = orientation_as_quaternion(4);

send(moveModelsPublisher, moveModelsMessage);

%% Command the turtlebot's velocity
forwardSpeed = 0;
rotationSpeed = 0;

turtlebotSendSpeed(forwardSpeed, rotationSpeed, velocityPublisher);

%% Stop Robot
turtlebotStop(velocityPublisher);

%% Read Odometry/Pose
theta_offset = 0;
pose = getTurtlebotOdometry(odometrySubscriber, theta_offset);

%% Move the cardboard box you manually placed in the scene
moveModelsMessage = rosmessage(moveModelsPublisher);
moveModelsMessage.ModelName = 'cardboard_box';

object_pose = [2, 2, deg2rad(180)];      % you might have to use 180 instead of 0 degrees to get the robot to face forward

moveModelsMessage.Pose.Position.X = object_pose(1);
moveModelsMessage.Pose.Position.Y = object_pose(2);

orientation_as_quaternion = eul2quat([0, 0, object_pose(3)]);       % you may have to change pi to another value
moveModelsMessage.Pose.Orientation.X = orientation_as_quaternion(1);
moveModelsMessage.Pose.Orientation.Y = orientation_as_quaternion(2);
moveModelsMessage.Pose.Orientation.Z = orientation_as_quaternion(3);
moveModelsMessage.Pose.Orientation.W = orientation_as_quaternion(4);

send(moveModelsPublisher, moveModelsMessage);

%% Receive lidar data
% Place a cardboard box a few meters in front of the turtlebot a corresponding
% set of points in the lidar plot. Move the box and confirm the points adjust accordingly
lidarMessage = receive(lidarSubscriber);
lidar_angles = deg2rad(1:360);
ranges = lidarMessage.Ranges
scan = lidarScan(ranges, lidar_angles);
plot(scan);

%% Stop Robot
turtlebotStop(velocityPublisher);

%% Turn by a specified amount
turn_amount = -90;
turtlebotTurnAngle(turn_amount, velocityPublisher, odometrySubscriber);

%% Turn to face a specified direction
target_direction = -45;
turtlebotFaceDirection(target_direction, velocityPublisher, odometrySubscriber);

%% Run this section to stop the robot
stopRobot();

%% DON'T FORGET TO DO THIS
rosshutdown