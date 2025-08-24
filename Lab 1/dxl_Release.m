%% Dynamixel RELEASE function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Commands the end-effector gripper to open to a predetermined position 
% to release the pen holder
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function dxl_Release
dxl_SetPos(4,55)
end