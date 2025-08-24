function accurary_precision()

dxl_Release()
% place pen/pen holder
% dxl_Grab()
% dxl_SerialOpen('COM3')
% RRR_go_angles(102,-68,-74)
% RRR_go_angles(30, -25, -45)
% Ideal: 14.6cm. What is the error?
ideal_distance = 14.6;
measured_distance = 13.97;
error = abs(ideal_distance - measured_distance) / ideal_distance * 100;

end

function accuracy_precision_2()

%dxl_SerialOpen('COM3')
dxl_SetVel(254,100)
RRR_go_angles([-59,-40,68])

RRR_go_angles([81,-50,-45])
pause(2)
RRR_go_angles([-59,-40,68])
pause(2)

RRR_go_angles([27,-26,-32])
pause(2)
RRR_go_angles([-59,-40,68])

pause(2)
RRR_go_angles([24,-47,-45])
pause(2)
RRR_go_angles([-59,-40,68])


RRR_go_angles([45,-67,-74])
pause(2)
RRR_go_angles([-59,-40,68])
pause(2)

RRR_go_angles([76,-66,-95])
pause(2)
RRR_go_angles([-59,-40,68])
pause(2)

dxl_SerialClose()

end