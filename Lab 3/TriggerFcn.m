%% RRR TRIGGER function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sends a trigger flag variable to the RRR_draw_shape script to provide
% precise time steps
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None; Global trigger variable updates
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function TriggerFcn
global trigger
trigger = 1;
end