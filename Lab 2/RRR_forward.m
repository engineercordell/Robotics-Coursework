function dh = RRR_forward(dh)
    
    dh = RRR_FDA(dh);
    Xe = dh.Xe;

    a3 = 2.7;

    xe = Xe(1) + a3*cos(Xe(3)-(pi/2));
    ye = Xe(2) + a3*sin(Xe(3)-(pi/2));

    dh.Xe = [xe, ye, Xe(3)];
end