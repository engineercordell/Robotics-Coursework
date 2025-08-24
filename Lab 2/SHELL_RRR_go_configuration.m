%% RRR GO CONFIGURATION function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Commands the RRR robot to move a desired end-effector position and
% orientation
%
% INPUTS:
%       dh = structure containing the Denavit-Hartenberg parameters, see
%            data_RRR.m for structure format
%       displ = vector containing the desired configuration in the form
%               [xe,ye,phie] in [cm] and [deg]
%       elbowplus = boolean value where 1 corresponds to elbow plus reverse
%                   displacement solution, and 0 corresponds to the elbow 
%                   minus solution
%
% OUTPUTS:
%       [theta] = optional output vector containing the joint angles
%                 calculated by the reverse displacement function
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function [theta] = RRR_go_configuration(dh, displ, elbowplus)

    newdh = RRR_reverse(dh, displ, elbowplus);
    theta = newdh.t_RDA(2:4) * (180/pi)
    % RRR_go_angles(theta);

end

