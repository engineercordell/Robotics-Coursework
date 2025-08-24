function dh = RRR_FDA(dh)
    % Extract joint angles from dh structure
    t = dh.t; % t = [NaN, theta1, theta2, theta3, 0]

    % Perform forward kinematics calculations to determine end-effector position (xe, ye) and orientation phi_e
    % Here you will use the link lengths and the joint angles to compute the position and orientation of the end-effector
    a1 = 9.3;
    a2 = 9.3;
    a3 = 10.2;

    xe = a1*cos(t(2)) + a2*cos(t(2)+t(3)) + a3*cos(t(2)+t(3)+t(4));
    ye = a1*sin(t(2)) + a2*sin(t(2)+t(3)) + a3*sin(t(2)+t(3)+t(4));

    phi_e = t(2) + t(3) + t(4);

    % Update dh structure with calculated end-effector location
    dh.Xe = [xe, ye, phi_e]; % Assuming Xe = [xe, ye, phi_e]
end