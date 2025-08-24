%% Dynamixel ERROR CHECK function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Translates the status packet error code into human-readable messages
%
% INPUTS:
%       statpacket = received status packet to translate for errors
%       packet = instruction packet which generated the above status packet
%
% OUTPUTS:
%       None; Error messages will be displayed in command window
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       -Error codes are contained in a single byte of the status packet,
%        where each bit represents one type of error; a 1 indicates an
%        error, 0 indicates no error
%--------------------------------------------------------------------------

%% Function definition
function dxl_ErrCheck(statpacket,packet)
% check each bit for error status
errcode = uint8(statpacket(5));
if errcode ~= 0
    id = statpacket(3); % identify the servo that threw the error
    
    warning backtrace off;  % show less information about the error
    if bitget(errcode,1)
        warning('dxlWrite:statusvolt','Input Voltage error on servo %', id)
    end
    if bitget(errcode,2)
        warning('dxlWrite:statusangle','Angle Limit error on servo %u', id)
    end
    if bitget(errcode,3)
        warning('dxlWrite:statusheat','Overheating error on servo %u', id)
    end
    if bitget(errcode,4)
        warning('dxlWrite:statusrange','Data Range error on servo %u', id)
    end
    if bitget(errcode,5)
        warning('dxlWrite:statuschksum','Checksum error on servo %u', id)
    end
    if bitget(errcode,6)
        warning('dxlWrite:statusload','Overload error on servo %u', id)
    end
    if bitget(errcode,7)
        warning('dxlWrite:statusinstrc','Instruction error on servo %u', id)
    end
    
    fprintf('Instrc Packet: [%s]\n',num2str(packet))    % show instruction
    fprintf('Status Packet: [%s]\n',num2str(statpacket'))   % show status
end

end