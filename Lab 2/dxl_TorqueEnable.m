%% Dynamixel TORQUE ENABLE function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Enables torque application from the motor to hold current position
%
% INPUTS:
%       id = ID number of desired servo, use 254 to broadcast to all servos
%
% OUTPUTS:
%       None; Error codes from returned status packets will display however
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Issuing any commands that WRITE data to the servo will also
%        automatically ENABLE torque to the servo, even if the command does
%        not result in servo movement, e.g. setting the speed
%--------------------------------------------------------------------------

%% Function definition
function dxl_TorqueEnable(id)
dxl_Write(id,24,1)
end