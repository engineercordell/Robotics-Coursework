function turtlebotSendSpeed(forwardSpeed, turnSpeed, velocityPublisher)

velocityMessage = rosmessage(velocityPublisher);
velocityMessage.Linear.X = forwardSpeed;
fprintf("velocityMessage.Linear.X: %.2f\n", velocityMessage.Linear.X);
velocityMessage.Linear.Y = 0;
velocityMessage.Linear.Z = 0;
velocityMessage.Angular.Z = turnSpeed;
fprintf("velocityMessage.Angular.Z: %.2f\n", velocityMessage.Angular.Z);

send(velocityPublisher,velocityMessage);
