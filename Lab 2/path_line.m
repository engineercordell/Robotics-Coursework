%% LINE PATH Function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Generate a set of end-effector positions defining a linear path
%
% INPUTS:
%       displ1 = starting position and orientation [x,y,phi] in [cm,cm,deg]
%       displ2 = ending position and orientation [x,y,phi] in [cm,cm,deg]
%       N = desired number of steps to complete the move
%
% OUTPUTS:
%       eepoints = (N+1)x3 matrix of points that compose the desired path
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Denavit-Hartenberg and base orientation and location parameters 
%        are brought in by calling data_3RRR and data_3RRR_base.
%       -This function utilizes the RRR3_reverse and Parallel_set functions
%--------------------------------------------------------------------------

%% Function definition
function eepoints = path_line(displ1,displ2,N)
% Initialize output path array
eepoints = zeros(N+1,3); 

% Calculate change in position or orientation for each step
step = [(displ2(1)-displ1(1))/N, (displ2(2)-displ1(2))/N, (displ2(3)-displ1(3))/N];

% Generate output point matrix
for i = 1:N+1 
    eepoints(i,:) = displ1 + (i-1)*step;
end
