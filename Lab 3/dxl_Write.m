%% Dynamixel WRITE DATA function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Builds and transmits a WRITE DATA packet to the desired servos
%
% INPUTS:
%       id = ID number of desired servo, use 254 to broadcast to all servos
%       memaddr = starting memory address to write to on servo
%       data = vector containing parameters to be written, [p1,p2,p3,...]
%
% OUTPUTS:
%       None; Error codes from returned status packets will display however
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -If the parameters to be written to occupy two bytes in memory, use
%        the funtion dxl_SplitBytes to generate the high and low byte
%       -Packet structure is:
%        [255, 255, id, packetlength, instruction, memoryaddress,...
%            params0...N checksum]
%       -WRITE DATA instruction value is 3 (0x03)
%       -Checksum is defined as:
%            ~(id + packetlength + instruction + param1 +...+ paramN)
%            The ~ represents the logical NOT operation
%            If the sum in parens is > 255, only the lower byte is used
%--------------------------------------------------------------------------

%% Function definition
function dxl_Write(id, memaddr, data)
global usb2dxl      % pull in global serial object

% Argument check
if nargin ~= 3
    error('dxlWrite:argChk','Requires 3 arguments');
end

% Define packet length, set instruction code
plength = length(data)+3;
instrc = 3;

% Calculate checksum
datasum = id + plength + instrc + memaddr + sum(data);
datasum = bitand(datasum,255);
checksum = bitcmp(datasum,'uint8');

% Build instruction packet
packet = uint8([255, 255, id, plength, instrc, memaddr, data, checksum]);

% Write packet to serial object
fwrite(usb2dxl, packet);

% Error check for status packet (no packet returns if broadcast id used)
if id ~=254
    statpacket = fread(usb2dxl, 6);
    dxl_ErrCheck(statpacket,packet);
end

end