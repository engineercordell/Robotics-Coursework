%% Dynamixel GRAB function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Commands the end-effector gripper to close to a predetermined position 
% intended for the robot pen holder
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -If this is used command with objects other than the pen holder, 
%        you may overload the servo
%       -This function assumes the gripper is controlled by servo 4
%--------------------------------------------------------------------------

%% Function definition
function dxl_Grab
dxl_SetPos(4,8)    % set servo 4 to grip angle
end