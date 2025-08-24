
L1=sqrt(10);
L2=sqrt(5);
L3=sqrt(2);

T1=71.56;
T2=-98.09;
T3=-18.55;

a = -L1*sind(T1)-L2*sind(T1+T2)-L3*sind(T1+T2+T3);
b = -L2*sind(T1+T2)-L3*sind(T1+T2+T3);
c = -L3*sind(T1+T2+T3);

d = L1*cosd(T1)+L2*cosd(T1+T2)+L3*cosd(T1+T2+T3);
e = L2*cosd(T1+T2)+L3*cosd(T1+T2+T3);
f = L3*cosd(-45)

g = 1;
h = 1;
i = 1;

J_tp = [a b c;
     d e f;
     g h i]'


% F = [ 7 ; -30 ; 0];

% Torq = J_tp* F


Torq = [-127.0568;-76.0495;-23.0226]

F = inv(J_tp)*Torq

