%% Dynamixel GET POSITION function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Returns the present position of the desired servo in degrees
%
% INPUTS:
%       id = ID number of desired servo (cannot use broadcast ID)
%
% OUTPUTS:
%       PresentPos = present position of the servo in degrees
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function PresentPos = dxl_GetPos(id)
data = dxl_Read(id,36,2);     % read data from servo
PresentPos = dxl_MergeBytes(data(1:2));     % merge high and low bytes
PresentPos = round((PresentPos/(1024/300))-150);    % convert to degrees
end