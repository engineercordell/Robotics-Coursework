%% Dynamixel MERGE BYTES function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Recombines a high and low byte read from servo memory into a single
% decimal value
%
% INPUTS:
%       bytes = vector containing input bytes of form [LowByte, HighByte]
%
% OUTPUTS:
%       out = equivalent decimal value output
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Two-byte values read from servo memory are stored low byte first
%        by default, so no rearranging should be required to use this
%        function
%--------------------------------------------------------------------------

%% Function definition
function out = dxl_MergeBytes(bytes)
low = bytes(1);                 % low byte is unchanged
high = bitshift(bytes(2),8);    % shift high byte left by 8 bits
out = bitor(high,low);          % combine into single 16 bit number
end