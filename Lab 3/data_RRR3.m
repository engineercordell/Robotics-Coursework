%% Parallel RRR DH Parameters for Virtual Serial Robots
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Stores Denavit-Hartenberg parameters for the virtual serial robots making
% up the parallel robot and base location and orientation parameters.
%
% INPUTS:
%       N/A
%
% OUTPUTS:
%       N/A
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       Data for DH parameters is logically indexed from frame 0 (base) to frame n+1 (gripper)
%       Data for base parameters is indexed from virtual serial 1 to 3
%       This assumes each leg of the parallel robot has the same
%       parameters, if not a seperate dh will need to be created for each.
%--------------------------------------------------------------------------

dh.t = [nan,     0,     0,     0,     0]; %joint angles        0...n+1 (first element ignored)
dh.d = [nan,     0,     0,     0,     0]; %joint offsets       0...n+1 (first element ignored)
dh.a = [  0,  11.9,   9.5,   3.1,   nan]; %link common normals 0...n+1 (last  element ignored)
dh.f = [  0,     0,     0,     0,   nan]; %link twist angles   0...n+1 (last  element ignored)
dh.j = ['B',   'R',   'R',   'R',   'G']; %R/P/G/B/N - Revolute/Prismatic/Gripper/Base/None joint type


%Base Parameters
dh.posx = [-15.906,  7.953,  7.953]; %X location of joint 1 of 1...nth serial robot
dh.posy = [      0, 13.775,-13.775]; %Y location of joint 1 of 1...nth serial robot
dh.delta = [  ]; %e-e orientation offsets of 1...nth serial robot
% dh.beta = [ ];  %rotations necessary to align virtual serial robot with main reference frame