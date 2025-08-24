function basicInterface6_1_1()

% dxl_SerialOpen('COM3')
dxl_SetVel(254,50) % vel to 50 deg/s
dxl_SetPos(3,15) % Joint 3, 15 deg
dxl_SetPos(2,-20) % Joint 2, -20 deg

end

function basicInterface6_1_2()

dxl_SetVel(2,40) % changing move speed
dxl_SetPos(254,0) % all joints to 0 deg

end

function basicInterface6_1_3()

dxl_SetPos(3, 160) % out of bounds code
dxl_SetPos(3, 140) % soft limit angle (137, -142); should still move servo

end

function basicInterface6_1_4()

% Find safe limits
dxl_SetPos(254,0)
dxl_TorqueDisable(254) % Disable motor torque, all servos
% rotate link 3 
% dxl_GetPos(3) % Return servo 3

end