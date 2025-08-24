%% Dynamixel TORQUE DISABLE function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Disables torque application from the motor, allowing free motion of the
% servo
%
% INPUTS:
%       id = ID number of desired servo, use 254 to broadcast to all servos
%
% OUTPUTS:
%       None; Error codes from returned status packets will display however
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Issuing any commands that WRITE data to the servo will ENABLE
%        torque to the servo regardless of the use of this function, even if
%        those commands do not result in servo movement
%--------------------------------------------------------------------------

%% Function definition
function dxl_TorqueDisable(id)
dxl_Write(id,24,0)
end