%% Dynamixel SPLIT BYTES function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Takes a decimal input value and represents it as two 8-bit bytes, a high 
% and low byte, as required for writing to servo memory
%
% INPUTS:
%       value = decimal value to convert
%
% OUTPUTS:
%       bytes = vector containing two uint8 values, [LowByte, HighByte]
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Output bytes is already in the proper form to send as the data
%        input of a write command, so this function can be used directly in
%        a write command, e.g. dxl_Write(3,8,dxl_SplitBytes(973));
%--------------------------------------------------------------------------

%% Function definition
function bytes = dxl_SplitBytes(value)

LowByte = bitand(value,255);       % bitmask to keep lower 8 bits
HighByte = bitand(value,65280);    % bitmask to keep higher 8 bits
HighByte = bitshift(HighByte,-8);  % shift bits to the right

bytes = uint8([LowByte, HighByte]); % assemble vector with two bytes
end
