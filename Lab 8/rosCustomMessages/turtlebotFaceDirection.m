% face direction based on starting value of the odometruy sensor
function turtlebotFaceDirection(direction, odometrySubscriber, velocityPublisher)
    initial_odometry = getTurtlebotOdometry(odometrySubscriber, 0); 
    initial_theta = initial_odometry(3);
    

    %calculate the direction needed to turn based on starting which is 0. 
    
    turtlebotTurnAngle(direction - initial_theta, velocityPublisher, odometrySubscriber);
end


