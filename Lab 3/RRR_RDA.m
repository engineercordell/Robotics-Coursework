function [dh] = RRR_RDA(dh)
%RRR_RDA performs the reverse displacement analysis for the robot
%parameters in dh.
%   Takes in dh, a structure containing robot parameters, calculates the
%   joint angles necessary to achieve the end effector location in dh.Xe,
%   and sets the field dh.t_RDA to the calculated joint angles.

% Inputs
%   dh = A structure containing parameters for the robot.

% Outputs
%   dh = The same structure with an additional field, dh.t_RDA, a vector
%   containing the joint angles [nan, theta1, theta2, theta3, 0].

% Figures
%   None

% Author:   Hogan Welch
% Date:     09/20/2020

%% Define Intermediate Variables

x2 = dh.Xe(1) - dh.a(4)*cos(dh.Xe(3));
y2 = dh.Xe(2) - dh.a(4)*sin(dh.Xe(3));
d = sqrt(x2^2 +y2^2);
alpha = atan2(y2, x2);
gamma1 = acos( (dh.a(2)^2 + d^2 - dh.a(3)^2) / ...
               (2 * dh.a(2) * d) );
gamma2 = acos( (dh.a(2)^2 + dh.a(3)^2 - d^2) / ...
               (2 * dh.a(2) * dh.a(3)) );
           
%% Define Joint Angles

if dh.elbowplus
    
    theta1 = alpha - gamma1;
    theta2 = pi - gamma2;
    
else
    
    theta1 = gamma1 + alpha;
    theta2 = gamma2 - pi;
    
end
    
theta3 = dh.Xe(3) - theta1 - theta2;

%% Set Joint Angles in dh

dh.t_RDA = [nan, theta1, theta2, theta3, 0];

end