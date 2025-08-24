%% Dynamixel SET POSITION function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sets the goal position of the desired servo in degrees
%
% INPUTS:
%       id = ID number of desired servo, use 254 to broadcast to all servos
%       GoalPos = goal position for the servo to move to, in degrees,
%                 between +/- 150 degrees
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -This function sets a DESIRED position, the ACTUAL position may
%        vary based on the deadzone specified for each servo, +/- 1 count
%        by default
%--------------------------------------------------------------------------

%% Function definition
function dxl_SetPos(id,GoalPos)
GoalPos = round((GoalPos+150)*1024/300);    % convert degrees to counts
dxl_Write(id,30,dxl_SplitBytes(GoalPos));       % write position to servo
end
