function smoothTrajectoryWaypoint(goal_point, zeta_G, velocityPublisher, odometrySubscriber)

    zeta_G = deg2rad(zeta_G);
    % Initialize parameters
    forwardSpeed = 0.4;  % Maximum speed
    tolerance = 0.05;    % Distance tolerance
    Ke = .3; % .3
    Kbeta = -.1; % -.1
    Kalpha = 2; % .1

    K = [Ke, 0, 0; 0, Kalpha, Kbeta]; % might need to increase this by a lot, but it seems to be working well

    maxIterations = 300;  % Set a reasonable maximum iteration count
    iterationCount = 0;
    i = 1; % angle iteration var

    initial_state = getTurtlebotOdometry(odometrySubscriber, 0);
    initialX = initial_state(1);
    initialY = initial_state(2);
    theta = deg2rad(initial_state(3)); % relative robot angle

    distance = sqrt((goal_point(1)-initialX)^2+(goal_point(2)-initialY)^2); % distance from P to G

    % Calculate target position based on initial position and distance
    targetX = distance * cos(theta);
    targetY = distance * sin(theta);
    
    velocityMessage = rosmessage(velocityPublisher);

    % Loop until the robot reaches the target position within the tolerance
    while iterationCount < maxIterations
        fprintf('ITERATION: [%d]\n', iterationCount);

        % Get current position
        currentState = getTurtlebotOdometry(odometrySubscriber, 0);
        currentX = currentState(1);
        fprintf('Current X: %.2f\n', currentState(1));
        currentY = currentState(2);
        fprintf('Current Y: %.2f\n', currentState(2));
        currentTheta = deg2rad(currentState(3));
        fprintf('Current Theta: %.2f\n', currentTheta);

        % error
        errorX = targetX - currentX;
        fprintf('errorX: %.2f\n', errorX);
        errorY = targetY - currentY;
        fprintf('errorY: %.2f\n', errorY);
        e = sqrt(errorX^2 + errorY^2);
        fprintf('e: %.2f\n', e);
   
        % alpha
        alpha = atan2(errorY, errorX) - currentTheta;
        fprintf('%.2f', atan2(errorY, errorX));
        fprintf('alpha: %.2f\n', alpha);

        % beta
        beta = -((currentTheta + alpha) - zeta_G);
        fprintf('beta: %.2f\n', beta);

        angles = [e; alpha; beta];

        velocities = K * angles;

        V = velocities(1);
        fprintf('Linear Velocity: %.2f', V);
        omega_z = velocities(2);
        fprintf('Omega_z: %.2f', omega_z);

        % tolerancing
        if e < tolerance
            break; 
        end

        turtlebotSendSpeed(V, omega_z, velocityPublisher);

        iterationCount = iterationCount + 1;
        i = i + 1;

        if iterationCount >= maxIterations
            disp('Maximum iterations reached, stopping TurtleBot.');
            break;
        end

        pause(0.01);
    end

    %beta = -((currentTheta + angularCorrection) - zeta_G);
    %turtlebotTurnAngle(beta, velocityPublisher, odometrySubscriber);

    % Stop the robot
    turtlebotStop(velocityPublisher);
end