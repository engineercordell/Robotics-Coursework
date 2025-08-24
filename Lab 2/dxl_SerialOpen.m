%% Dynamixel SERIAL INITIALIZATION function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Initializes serial communication with the USB2Dynamixel adapter and sets
% angle and torque limits as well as optional control parameters for each
% servo
%
% INPUTS:
%       port = COM port the USB2Dynamixel is connected to as a string, e.g. 
%              'COM1' or 'COM4'
% OUTPUTS:
%       None; Global serial object remains for further use
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -The default baud rate for servo communication is 1000000bps
%       -See the Dynamixel AX-12 Manual for control parameter information
%--------------------------------------------------------------------------

%% Function Definition
function dxl_SerialOpen(port)
% Create serial object
global usb2dxl
usb2dxl = serial(port, 'BaudRate', 1000000, 'Parity', 'none',...
    'DataBits', 8, 'StopBits', 1, 'Tag','usb2dxl');

% Open the port
fopen(usb2dxl);
disp(usb2dxl);
disp('---Connected to USB2Dynamixel---')

% Set angle/torque limits
dxl_Write(254,6,dxl_SplitBytes(24));   %set CW angle limit to -143 deg
dxl_Write(254,8,dxl_SplitBytes(986));  %set CCW angle limit to 139 deg
dxl_Write(4,6,dxl_SplitBytes(480));    %set E-E CW angle limit to -9 deg
dxl_Write(4,8,dxl_SplitBytes(730));    %set E-E CCW angle limit to 64 deg
dxl_Write(4,34,dxl_SplitBytes(200));   %set E-E torque limit

% Set optional control parameters
% slope = 32;
punch = 8;

for i = 1:3
%     dxl_Write(i,28,slope);      %set compliance slope
%     dxl_Write(i,29,slope);      %set compliance slope
    dxl_Write(i,48,dxl_SplitBytes(punch));     %set punch
end

end