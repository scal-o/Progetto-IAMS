function deltat = TOF(a, e, th1, th2, mu)

% TIME OF FLIGHT
% deltat = TOF(a, e, th1, th2, mu) 

% INPUT ARGUMENTS
% a           [1x1]      semi-major axis           [km]
% e           [1x1]      eccentricity              [-]
% th1         [1x1]      initial true anomaly      [rad]
% th2         [1x1]      final true anomaly        [rad]
% mu          [1x1]      gravitational parameter   [km^3/s^2]

% OUTPUT ARGUMENTS
% deltat      [1x1]      time of flight            [s]

T = 2*pi*sqrt(a^3/mu);

if th1 > 2*pi
    th1 = th1 - 2*pi;
end

if th2 > 2*pi
   th2 = th2 - 2*pi;
end

if th1 > pi
    th1_sign = 2*pi - th1;
    E1 = 2*atan(sqrt((1-e)/(1+e))*tan(th1_sign/2));
    t1 = T - sqrt(a^3/mu)*(E1-e*sin(E1));
else
    E1 = 2*atan(sqrt((1-e)/(1+e))*tan(th1/2));
    t1 = sqrt(a^3/mu)*(E1-e*sin(E1));
end

if th2 > pi
    th2_sign = 2*pi - th2;
    E2 = 2*atan(sqrt((1-e)/(1+e))*tan(th2_sign/2));
    t2 = T - sqrt(a^3/mu)*(E2-e*sin(E2));
else
    E2 = 2*atan(sqrt((1-e)/(1+e))*tan(th2/2));
    t2 = sqrt(a^3/mu)*(E2-e*sin(E2));
end


if th2 > th1
    deltat = t2 - t1;
else
    deltat = t2 - t1 + T;
end