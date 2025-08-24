%% RRR3_go_configuration Function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% A function to move the e-e to a given point with given orientation
%
% INPUTS:
%       displ = desired position and orientation [cm;cm;deg]
%       dh = DH parameters and base parameters for the RRR3 parallel
%       elbowplus = boolean value where 1 corresponds to elbow plus reverse
%                   displacement solution, and 0 corresponds to the elbow
%                   minus solution
%
% OUTPUTS:
%       [theta] = optional output vector containing the joint angles
%                 calculated by the reverse displacement function
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       -Denavit-Hartenberg and base orientation and location parameters
%        are brought in by calling data_3RRR and data_3RRR_base.
%       -This function utilizes the RRR3_reverse and RRR_go_angles functions
%--------------------------------------------------------------------------
%% Function definition
function [theta] = RRR3_go_configuration(dh,displ,elbowplus)



end
