% imput coordinates and have robot move there based on odometry
function turtlebotGoWaypoint(target_x, target_y)
    
    % velocityPublisher = rospublisher('/cmd_vel');
    % create a subscriber to receive odometry information from robot
    odometrySubscriber = rossubscriber('/odom');

    % Get initial position from odometry data
    initial_odometry = getTurtlebotOdometry(odometrySubscriber, 0); 
    initial_x = initial_odometry(1);
    initial_y = initial_odometry(2);
    
    % Calculate heading angle towards the target point
    delta_x = target_x - initial_x;
    delta_y = target_y - initial_y;
    target_heading = atan2(delta_y, delta_x);
    
    % Calculate distance to the target point
    distance_to_target = sqrt(delta_x^2 + delta_y^2);
    
    % Get current orientation from odometry data
    initial_theta = initial_odometry(3);
    
    % Calculate angle difference between current orientation and target heading
    delta_theta = target_heading - initial_theta;
    
    % Turn the turtlebot to the desired heading
    turtlebotTurnAngle(delta_theta);
    
    % Move the turtlebot forward to travel to the target point
    turtlebotGoDistanceImproved(distance_to_target);
end

