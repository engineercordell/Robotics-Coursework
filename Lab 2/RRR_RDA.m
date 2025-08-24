function dh = RRR_RDA(dh)

    % newdh = RRR_FDA(dh);
    E = dh.Xe;
    % E = [xe, ye, phi_e] Manually edit the end effector vector w/o FDA

    a1 = dh.a(2);
    a2 = dh.a(3);
    a3 = dh.a(4);

    y2 = E(2) - a3*sin(E(3));
    x2 = E(1) - a3*cos(E(3));
    d = sqrt(x2^2 + y2^2);

    gamma1 = acos((a1^2 + d^2 - a2^2)/(2*a1*d));
    gamma2 = acos((a1^2 + a2^2 - d^2)/(2*a1*a2));
    alpha = atan2(y2, x2);

    % elbowplus thetas
    theta11 = alpha - gamma1;
    theta21 = pi - gamma2;
    theta31 = E(3) - theta11 - theta21;
    elbowplus = [nan, theta11, theta21, theta31, 0];

    % elbowminus thetas
    theta12 = gamma1 + alpha;
    theta22 = gamma2 - pi;
    theta32 = E(3) - theta12 - theta22;
    elbowminus = [nan, theta12, theta22, theta32, 0];

    if dh.elbowplus == true
        dh.t_RDA = elbowplus;
    else
        dh.t_RDA = elbowminus;
    end
    
end