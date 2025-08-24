%% DON'T FORGET TO DO THIS
rosshutdown

%% Initialize Turtlebot connection through ROS
% turtlebot_ip = '192.168.0.177';% <-- put the IP of the turtlebot you want to use here
turtlebot_ip = '192.168.0.117';
rosinit(turtlebot_ip);

%% Explore the available topics on your Turtlebot
% list the topics in the command window
% rostopic list

%% Get Publishers and Subscribers
% create a publisher to use to send velocites to robot
velocityPublisher = rospublisher('/cmd_vel');
% create a subscriber to receive odometry information from robot
odometrySubscriber = rossubscriber('/odom');

%% Examine the messages for your chosen topics
velocityMessage = rosmessage(velocityPublisher)
odometryMessage = rosmessage(odometrySubscriber)