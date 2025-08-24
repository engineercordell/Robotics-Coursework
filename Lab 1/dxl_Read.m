%% Dynamixel READ DATA function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Builds and transmits a READ DATA packet to the desired servos
%
% INPUTS:
%       id = ID number of desired servo (cannot use broadcast id of 254)
%       memaddr = starting memory address to read from on servo
%       datalength = number of bytes to read from memory
%
% OUTPUTS:
%       out = vector containing raw data read from servo memory
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Packet structure is:
%        [255, 255, id, packetlength, instruction, memoryaddress,...
%            params0...N checksum]
%       -READ DATA instruction value is 2 (0x02)
%       -Checksum is defined as:
%            ~(id + packetlength + instruction + param1 +...+ paramN)
%            The ~ represents the logical NOT operation
%            If the sum in parens is > 255, only the lower byte is used
%--------------------------------------------------------------------------

%% Function definition
function out = dxl_Read(id, memaddr, datalength)
global usb2dxl      % pull in global serial object

% Argument check
if nargin ~= 3
    error('dxlWrite:argChk','Requires 3 parameters');
end

% Define packet length, set instruction code
plength = 4;
instrc = 2;

% Calculate checksum
datasum = id + plength + instrc + memaddr + datalength;
datasum = bitand(datasum,255);
checksum = bitcmp(datasum,'uint8');

% Build instruction packet
packet = uint8([255, 255, id, plength, instrc, memaddr, datalength, checksum]);

% Write packet to serial object
fwrite(usb2dxl, packet);

% Read requested data from status packet
statpacket = fread(usb2dxl, 6+datalength);
out = statpacket(6:end-1);

% Error check for status packet
dxl_ErrCheck(statpacket,packet);

end