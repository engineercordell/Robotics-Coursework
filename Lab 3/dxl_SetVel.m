%% Dynamixel SET VELOCITY function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sets the goal move velocity for the desired servo
%
% INPUTS:
%       id = ID number of desired servo, use 254 to broadcast to all servos
%       GoalVel = desired velocity for servo movement in degrees/sec,
%                 from .668 to 684 deg/s
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Servos will not move after this command is sent, but will attempt
%        move at this velocity for all subsequent position commands
%       -If GoalVel is <= .334 deg/s it rounds down to 0, which commands 
%        the servo to turn as fast as allowed by the current input voltage
%       -This function sets a DESIRED velocity, the ACTUAL velocity may
%        vary based on the deadzone
%--------------------------------------------------------------------------

%% Function definition
function dxl_SetVel(id,GoalVel)
GoalVel = round(GoalVel*1023/684);      % convert deg/s to rpm to counts
dxl_Write(id,32,dxl_SplitBytes(GoalVel)); % write velocity to servo
end
