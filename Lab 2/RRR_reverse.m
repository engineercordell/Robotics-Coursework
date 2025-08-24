function [dh] = RRR_reverse(dh, displ, elbowplus)

    % data_RRR; % may or may not need to comment out
    phi_e = displ(3) * (pi/180);
    
    ap_3 = 2.7 % offset distance (cm)
    
    xp_3 = displ(1) - ap_3 * cos(phi_e - pi/2);
    yp_3 = displ(2) - ap_3 * sin(phi_e - pi/2);
    
    new_displ = [xp_3, yp_3, phi_e];
    dh.Xe = new_displ;
    
    dh.elbowplus = elbowplus;
    
    dh = RRR_RDA(dh);

end