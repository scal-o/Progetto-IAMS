mu = 398600 

%% prova plotorbit
clear
close
clc

% rr = [-4350.9803; -6668.1393; 1517.6565]
% vv = [4.9690; -4.2630; -2.4370]
% 
% [a , e, i, OM, om, th] = car2par(rr, vv, mu)
% 
% th0 = 0
% thf = 2*pi
% dth = 1*pi/180
% 
% plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)


% a = 12950.0 
% e = 0.2682 
% i = 0.7222 
% OM = 1.0360
% om = 0.7604 
% th = 1.6230
% 
% figure(2)
% plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)


%% prova changePericenterArg
clear
close
clc

a = 36000
e = 0.75
i = 0
OM = pi
om1 = pi/4
om2 = -pi/4
th0 = 0
thf = 2*pi
dth = 1*pi/180

plotOrbit2D(a, e, i, OM, om1, th0, thf, dth, mu)
% plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)

hold on

plotOrbit2D(a, e, i, OM, om2, th0, thf, dth, mu)
% plotOrbit(a, e, i, OM, om, th0, thf, dth, mu)

[DeltaV, thi, thf] = changePericenterArg(a,e,om1,om2,mu)

rr = []
vv = []

for i = 1:2
    [rrn, vvn] = par2car(a,e,i,OM,om1,thi(i),mu)
    rr = [rr, rrn]
    vv = [vv, vvn]
end
plot(rr(1,:), rr(2,:), 'o', 'MarkerSize', 15)

rr = []
vv = []

for i = 1:2
    [rrn, vvn] = par2car(a,e,i,OM,om2,thf(i),mu)
    rr = [rr, rrn]
    vv = [vv, vvn]
end
plot(rr(1,:), rr(2,:), 'o', 'MarkerFaceColor', 'y')


%% prova bitangentTransfer
clear
close
clc

mu = 398600; 
ai = 36000;
af = 90000;
ei = 0.9;
ef = 0.7;
i = 0;
OM = 0;
om1 = 0;
om2 = 0;
th0 = 0;
thf = 2*pi;
dth = 1*pi/180;

type = 'pa';
if strcmp(type,'pp')
    om2 = pi;
end


[DeltaV1, DeltaV2, Deltat] = bitangentTransfer(ai, ei, af, ef, type, mu)

hold on
plotOrbit2D(ai,ei,i,OM,om1,th0,thf,dth,mu)
plotOrbit2D(af,ef,i,OM,om2,th0,thf,dth,mu)


