%% RRR GO ANGLES function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Commands the RRR robot to move a desired set of angles, and imposes angle
% constraints to prevent internal collisions
%
% INPUTS:
%       theta = vector with desired joint angles in degrees
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function RRR_go_angles(theta)
% Define angle constraints here
%**************************************************************************
theta_constraint{1} = [-90, 90]; % [deg]
theta_constraint{2} = [-90, 90]; % [deg]
theta_constraint{3} = [-90, 90]; % [deg]
%**************************************************************************

thetaC = zeros(1, length(theta));
% Impose constraints
for i = 1:length(theta)
    thetaC(i) = max(min(theta(i),theta_constraint{i}(2)),theta_constraint{i}(1));
end

% Constraint Warning
Fault_flag = abs(thetaC - theta);

% Tolerance for out of bounds
B_tol = 1e-3;

for i = 1:length(Fault_flag)
    if (Fault_flag(i) >= B_tol)
        sprintf('Joint angle %0.5g calculated as %0.5g deg and clipped within bounds \n',i,theta(i))
    end
end

% Commanding the servos
%**************************************************************************
%
for i = 1:length(thetaC)
    
    dxl_SetPos(i, thetaC(i))
    
end
%
%**************************************************************************
end

