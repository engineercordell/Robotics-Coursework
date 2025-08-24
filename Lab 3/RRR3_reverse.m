%% RRR3_reverse Function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2020
%--------------------------------------------------------------------------
% A function to calculate the joint angles for a 3RRR robot from the end
% effector location.
%
% INPUTS:
%       dh = DH parameters and base parameters for the RRR3 parallel
%       displ = desired position and orientation [cm;cm;deg]
%       elbowplus = boolean value where 1 corresponds to elbow plus reverse
%                   displacement solution, and 0 corresponds to the elbow
%                   minus solution
%
% OUTPUTS:
%       dh = The input DH structure with a new field "t_3RRR" containing
%            joint angles for the 3RRR robot necessary to reach the desired
%            end effector position.
%--------------------------------------------------------------------------
%% Function Definition
function dh = RRR3_reverse(dh,displ,elbowplus)

% Define end effector coordinates.
x_e = displ(1);
y_e = displ(2);
phi_e = displ(3) * pi/180; % Convert phi_e to radians.

% Define elbowplus field of dh.
dh.elbowplus = elbowplus;

%% Virtual Robot j (General Case)

% Calculate end-effector coordinates relative to virtual robot j origin.
% x_ej = x_e - dh.posx(j);
% y_ej = y_e - dh.posy(j);
% phi_ej = phi_e - dh.delta(j);
% 
% % Load the end-effector location into dh.Xe for RRR_RDA.
% dh.Xe = [x_ej, y_ej, phi_ej];
% 
% % Do inverse kinematics using above coordinates.
% dh = RRR_RDA(dh);
% 
% % Extract the necessary joint angles for the 3RRR robot.
% dh.t_3RRR(j) = dh.t_RDA(2);

%% Virtual Robot 1

% Calculate end-effector coordinates relative to virtual robot 1 origin.
x_e1 = x_e - dh.posx(1);
y_e1 = y_e - dh.posy(1);
phi_e1 = phi_e - dh.delta(1);

% Load the end-effector location into dh.Xe for RRR_RDA.
dh.Xe = [x_e1, y_e1, phi_e1];

% Do inverse kinematics using above coordinates.
dh = RRR_RDA(dh);

% Extract the necessary joint angle for the 3RRR robot.
dh.t_3RRR(1) = dh.t_RDA(2);

%% Virtual Robot 2
x_e2 = x_e - dh.posx(2);
y_e2 = y_e - dh.posy(2);
phi_e2 = phi_e - dh.delta(2);

dh.Xe = [x_e2, y_e2, phi_e2];

dh = RRR_RDA(dh);

dh.t_3RRR(2) = dh.t_RDA(2);

%% Virtual Robot 3



end