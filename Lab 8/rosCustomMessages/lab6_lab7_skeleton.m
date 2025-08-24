fprintf('What did I say about running this as a script?!');
return;
%------------------------------------------------
% DON'T RUN THIS SCRIPT
% RUN EACH CODE BLOCK INDPENDENTLY (ctrl+enter)
%------------------------------------------------

% One thing you'll want to do frequently is reset the position of the
% robot. In the Gazebo environment, there are 2 ways to do this. The easy
% way is to click on the robot in the simulation window. You will then see
% a drop down "pose". Open the drop down and you can then type in the pose
% you want to set it to. You can also do this by clicking on the robot and
% clicking the "Translation Mode" icon on top, then dragging it into the
% desired place. Same goes for orientation one button over. You can also do
% this in a script. I've included the method in the script I've attached
% but the Gazebo method is more straightforward.
% 
% You can also place objects that you can treat as obstacles to avoid. On
% Gazebo, click "Insert" and in the first dropdown select "Cardboard Box".
% You can then drop this into the scene wherever you like. You can move
% this around as you did the turtlebot. You can also move this via the
% script I attached. I've also included a little section that plots the
% lidar readings to confirm you are indeed detecting the box.
% 
% Note that the robot might slightly drift in the angular z direction. To
% fix this might take some time so I would just ignore it.
% 
% To close the virtual machine, execute the rosshutdown command on MATLAB.
% Then, simply open up the terminal window that popped up when you started
% the Gazebo simulation and click Ctrl + C; You can then shut down the
% virtual machine. MATLAB/Gazebo is well documented so leverage those
% resources as needed.

%% Initialize Turtlebot connection through ROS
% turtlebot_ip = '192.168.0.177';% <-- put the IP of the turtlebot you want to use here
turtlebot_ip = '192.168.0.101';
rosinit(turtlebot_ip);

%% Explore the available topics on your Turtlebot
% list the topics in the command window
rostopic list

%% Get Publishers and Subscribers
% create a publisher to use to send velocites to robot
velocityPublisher = rospublisher('/cmd_vel');
% create a subscriber to receive odometry information from robot
odometrySubscriber = rossubscriber('/odom');

%% Examine the messages for your chosen topics
velocityMessage = rosmessage(velocityPublisher)
odometryMessage = rosmessage(odometrySubscriber)

%% create a subscriber to receive odometry information from robot
overallPath = [];

while(1)
    odar = receive(odometrySubscriber);
    % cartO = rosReadCartesian(odar.MessageType);
    state = getTurtlebotOdometry(odometrySubscriber, 0);
    overallPath = [overallPath; state(1), state(2), state(3)];

    %plot(cart0(:,1), cart0(:,2), '.')
    plot(overallPath(:, 1), overallPath(:, 2), 'r-')
end
%% Reading Lidar
lidarSubscriber = rossubscriber("/scan", "DataFormat","struct");
while(1)
    lidar = receive(lidarSubscriber);
    cart = rosReadCartesian(lidar);
    plot(cart(:,1), cart(:,2), '.')
end

%% Some Velocity Stuff

% if you run this with a speed, 
% be ready to send another command to tell it to stop 
% or use your cat-like speed and reflexes to pick the robot up if need be...
forwardSpeed = 0;
turnSpeed = 0;
% forwardSpeed = 1;
% turnSpeed = 0.5;

% use rosmessage to determine the type of message velocityPublisher uses
velocityMessage = rosmessage(velocityPublisher);
% set parameters of the message
velocityMessage.Linear.X = forwardSpeed;
velocityMessage.Linear.Y = 0;
velocityMessage.Linear.Z = 0;
velocityMessage.Angular.Z = turnSpeed;
% send the message over the publisher to the robot
send(velocityPublisher,velocityMessage);

%% Start Turtle, Move Few Secs, Stop Turtle, Get Odometry Data, Return Displacement
initialState = getTurtlebotOdometry(odometrySubscriber, 0);
fprintf('Initial Position: X = %.2f, Y = %.2f\n', initialState(1), initialState(2));

% Command TurtleBot to move
forwardSpeed = 0.2;  % Speed
movementDuration = 5;  % Duration

% Set the forward speed
velocityMessage.Linear.X = forwardSpeed;
velocityMessage.Angular.Z = 0;  % No angular velocity for straight movement

% Send the command to move forward
send(velocityPublisher, velocityMessage);
disp('TurtleBot is moving...');

% Wait for the specified duration
pause(movementDuration)

% Stop the TurtleBot
velocityMessage.Linear.X = 0;
send(velocityPublisher, velocityMessage);
disp('TurtleBot has stopped.');

% Read final odometry data
finalState = getTurtlebotOdometry(odometrySubscriber, 0);
fprintf('Final Position: X = %.2f, Y = %.2f\n', finalState(1), finalState(2));

% Calculate and display the displacement
displacement = sqrt((finalState(1) - initialState(1))^2 + (finalState(2) - initialState(2))^2);
fprintf('Displacement: %.2f meters\n', displacement);
%% What is a quaternion!? I just want x,y,theta

theta_offset = 0;
state = getTurtlebotOdometry(odometrySubscriber, theta_offset)


%% Fun with turtlebots (make it move)
% set the speed parameters
forwardSpeed = 0.1;
rotationSpeed = 1;

% set the run time
runtime = 1;    %seconds
timeInterval = 0.01;
n_intervals = floor(runtime/timeInterval);

% run robot for specified run time
for i = 1:n_intervals
    turtlebotSendSpeed(forwardSpeed, rotationSpeed, velocityPublisher);
    pause(timeInterval);
end

%% Package up some forward motion
distance = 1; 
% turtlebotGoDistance(distance, velocityPublisher, odometrySubscriber); % x ends up being 1.85...almost 2, terrible
turtlebotGoDistanceImproved(distance, velocityPublisher, odometrySubscriber); % adjust tolerance if necessary, but much better than previous iteration of GoDistance


%% Package up turning
theta = 90;
turtlebotTurnAngle(theta, velocityPublisher, odometrySubscriber); % yaw = 1.577 rad = 90.35 deg, pretty accurate

%% CW

% 0. Start Facing Down
% 1. Save Robot Pose (x, y, theta)
% 2. 1.9 ft downward = 0.57911 m
% 4. Save Robot Pose (x, y, theta)
% 5. Turn CW (Facing Left)
% 6. Save Robot Pose (x, y, theta)
% 7. 2.8 ft leftward = 0.85344 m
% 8. Save Robot Pose (x, y, theta)
% 9. Turn CW (Facing Up)
% 10. Save Robot Pose (x, y, theta)
% 11. 2.8 ft upwards = 0.85344 m
% 12. Save Robot Pose (x, y, theta)
% 13. Turn CW (Facing Right)
% 14. Save Robot Pose (x, y, theta)
% 15. 2.8 ft rightward = 0.85344 m
% 16. Save Robot Pose (x, y, theta)
% 17. Turn CW (Facing Down)
% 18. Save Robot Pose (x, y, theta)
% 19. 1.9 ft downward = 0.57911 m
% 20. Save Robot Pose (x, y, theta)
% 21. Stop Robot

poses = []; % To store the robot poses

% 1. Save Initial Robot Pose
initialPose = getTurtlebotOdometry(odometrySubscriber, 0);
poses = [poses; initialPose'];

% Move and turn according to the steps outlined
% .85344
% distances = [0.57912, 0.95, 0.95, 0.95, 0.57912]; % Distances to move in meters
% angles = [-90, -90, -85, -80]; % Angles to turn in degrees (CW turns are positive)

distances = [0.57912, 1.05, 0.95, 0.95, 0.48]; % Distances to move in meters
angles = [90, 85, 85, 83]; % Angles to turn in degrees (CW turns are positive)

for i = 1:length(distances)
    % 2. Move Forward
    turtlebotGoDistanceImproved(distances(i), velocityPublisher, odometrySubscriber);
    pause(0.5)
    % 3. Save Robot Pose after moving
    poseAfterMove = getTurtlebotOdometry(odometrySubscriber, 0);
    poses = [poses; poseAfterMove'];

    if i <= length(angles)
        % 4. Turn CW
        turtlebotTurnAngle(angles(i), velocityPublisher, odometrySubscriber);
        pause(0.5)
        % 5. Save Robot Pose after turning
        poseAfterTurn = getTurtlebotOdometry(odometrySubscriber, 0);
        poses = [poses; poseAfterTurn'];
    end
end

% Stop Robot
turtlebotStop(velocityPublisher);

figure;
plot(poses(:,1), poses(:,2), '-o');
title('Square Path Trajectory');
xlabel('X Position (m)');
ylabel('Y Position (m)');
grid on;
axis equal;

%% Face Direction
initial_odometry = getTurtlebotOdometry(odometrySubscriber, 0); 
initial_theta = initial_odometry(3);
initial_theta = 0;

turtlebotFaceDirection(30, odometrySubscriber, velocityPublisher)

%% Straight Line Motion

turtlebotGoDistanceImproved(3.1, velocityPublisher, odometrySubscriber);

%% Waypoint
turtlebotFaceDirection(30, odometrySubscriber, velocityPublisher);
% turtlebotGoWaypoint(0.5, 0.5);

%% Navigation

% First launch
initial_state = getTurtlebotOdometry(odometrySubscriber, 0);
initial_theta = initial_state(3);
% fprintf('Initial Theta: %.4f', initial_theta);
turtlebotGoDistanceImproved(1.5, velocityPublisher, odometrySubscriber);
final_state = getTurtlebotOdometry(odometrySubscriber, 0);
final_theta = final_state(3);
%if (final_theta > 0)
    turtlebotTurnAngle(-(final_theta - initial_theta), velocityPublisher, odometrySubscriber);
%else
    %turtlebotTurnAngle(-(final_theta - initial_theta), velocityPublisher, odometrySubscriber);
%end
turtlebotTurnAngle(-90, velocityPublisher, odometrySubscriber);

% Long Way
initial_state = getTurtlebotOdometry(odometrySubscriber, 0);
initial_theta = initial_state(3);
% fprintf('Initial Theta: %.4f', initial_theta);
turtlebotGoDistanceImproved(7.1, velocityPublisher, odometrySubscriber);
% 9 m
final_state = getTurtlebotOdometry(odometrySubscriber, 0);
final_theta = final_state(3);
%if (final_theta > 0)
    turtlebotTurnAngle(-(final_theta - initial_theta), velocityPublisher, odometrySubscriber);
%else
    % turtlebotTurnAngle(final_theta - initial_theta, velocityPublisher, odometrySubscriber);
%end
turtlebotTurnAngle(-90, velocityPublisher, odometrySubscriber);

% Into the box
initial_state = getTurtlebotOdometry(odometrySubscriber, 0);
initial_theta = initial_state(3);
% fprintf('Initial Theta: %.4f', initial_theta);
turtlebotGoDistanceImproved(1.4, velocityPublisher, odometrySubscriber);
final_state = getTurtlebotOdometry(odometrySubscriber, 0);
final_theta = final_state(3);
%if (final_theta > 0)
    turtlebotTurnAngle(-(final_theta - initial_theta), velocityPublisher, odometrySubscriber);
%else
    % turtlebotTurnAngle(final_theta - initial_theta, velocityPublisher, odometrySubscriber);
%end
turtlebotTurnAngle(-90, velocityPublisher, odometrySubscriber);

%turtlebotFaceDirection(-90, odometrySubscriber, velocityPublisher);
%turtlebotGoDistanceImproved(7.3, velocityPublisher, odometrySubscriber);
%turtlebotFaceDirection(-180, odometrySubscriber, velocityPublisher);
%turtlebotGoDistanceImproved(1.5, velocityPublisher, odometrySubscriber);
%turtlebotTurnAngle(-270, velocityPublisher, odometrySubscriber);

turtlebotStop(velocityPublisher);


%% DON'T FORGET TO DO THIS
rosshutdown