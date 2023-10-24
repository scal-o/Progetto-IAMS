mu = 398600; 
a = 15000;
e = 0.1;
i = 30*pi/180;
OM = 45*pi/180;
om = 30*pi/180;
th0 = 0;
thf = 360*pi/180;
dth = 1*pi/180;

rr = [-4350.9803; -6668.1393; 1517.6565]
vv = [4.9690; -4.2630; -2.4370]

[a , e, i, OM, om, th] = car2par(rr, vv, mu)

figure(1)
plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)


a = 12950.0 
e = 0.2682 
i = 0.7222 
OM = 1.0360
om = 0.7604 
th = 1.6230

figure(2)
plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)