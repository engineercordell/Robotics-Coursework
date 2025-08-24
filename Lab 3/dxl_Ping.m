%% Dynamixel PING function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Builds and transmits a PING packet to the desired servos to check servo
% status/error state, can also check the existence of a servo with given ID
%
% INPUTS:
%       id = ID number of desired servo
%
% OUTPUTS:
%       None; Errors and returned status packets will be displayed
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -PING instruction value is 1 (0x01)
%       -Using the broadcast ID is not recommended, as the status packet
%        received will only be for the first servo. Ping instructions for
%        the remaining servos will be queued up however, so subsequent Ping
%        instructions may not return packets from the expected servos
%--------------------------------------------------------------------------

%% Function definition
function dxl_Ping(id)
global usb2dxl      % pull in global serial object

% Define packet length, set instruction code
length = 2;
instrc = 1;

% Calculate checksum
datasum = id + length + instrc;
datasum = bitand(datasum,255);
checksum = bitcmp(datasum,8);

% Build instruction packet
packet = [255, 255, id, length, instrc, checksum];

% Write packet to serial object
fwrite(usb2dxl, packet);

% Read requested data from status packet
warning off all
try
    statpacket = fread(usb2dxl,6);
    disp(statpacket');
    dxl_ErrCheck(statpacket,packet);    % Error check for status packet
catch
    disp('No servo with this ID exists!')   % display if no servo found
end

end
