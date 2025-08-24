function smoothTrajectoryWaypoint(goal_point, zeta_G)

    initial_state = getTurtlebotOdometry(odometrySubscriber, 0);

    initialX = initial_state(1);
    initialY = initial_state(2);

    theta = initial_state(3);

    distance = sqrt((goal_point(1)-initialX)^2+(goal_point(2)-initialY)^2); % distance from P to G
    alpha = atan2(goal_point(2), goal_point(1)) - theta;
    beta = -((theta + alpha) - zeta_G); 
    
    turtlebotGoDistanceImproved(distance, velocityPublisher, odometrySubscriber);
    final_state = getTurtlebotOdometry(odometrySubscriber, 0);
    final_theta = final_state(3);

    % turtlebotTurnAngle(-(final_theta - initial_theta), velocityPublisher, odometrySubscriber);
    % turtlebotTurnAngle(alpha, velocityPublisher, odometrySubscriber);

    % Initialize parameters
    forwardSpeed = 0.4;  % Maximum speed
    tolerance = 0.05;    % Distance tolerance
    Kp = 1; % might need to increase this by a lot, but it seems to be working well

    maxIterations = 600;  % Set a reasonable maximum iteration count
    iterationCount = 0;
    i = 1; % angle iteration var

    


end