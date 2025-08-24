%% Dynamixel SERIAL TERMINATION function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Closes serial communication with the USB2Dynamixel adapter and deletes
% all serial objects in memory
%
% INPUTS:
%       None
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -instrfind returns all serial objects in memory, and is used to 
%        close duplicate serial objects that can arise
%--------------------------------------------------------------------------

%% Function definition
function dxl_SerialClose
if isempty(instrfind)       % check if there are any current connections
    disp('No active serial connections!')
else
    fclose(instrfind);      % close serial ports
    delete(instrfind);      % delete serial objects from memory
    clear instrfind;        % clear serial object variable from workspace
    
    disp('---Disconnected from USB2Dynamixel---')
end
end