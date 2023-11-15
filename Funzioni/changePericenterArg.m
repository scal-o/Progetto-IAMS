function [DeltaV, thi, thf] = changePericenterArg(a, e, omi, omf, mu)

% Change of Pericenter Argument maneuver
%
% [DeltaV, thi, thf] = changePericenterArg(a, e, omi, omf, mu)
%
% ------------------------------------------------------------
% Input arguments:
%
% a             [1x1]   semi-major axis                     [km]
% e             [1x1]   eccentricity                        [-]
% omi           [1x1]   initial pericenter anomaly          [rad]
% omf           [1x1]   final pericenter anomaly            [rad]
% mu            [1x1]   gravitational parameter             [km^3/s^2]

% ------------------------------------------------------------
% Output arguments:
%
% DeltaV        [1x1]   maneuver impulse                    [km/s]
% thi           [2x1]   initial true anomalies              [rad]
% thf           [2x1]   final true anomalies                [rad]
% 

%% Calcoliamo le anomalie vere dove poter effettuare la manovra

Delta_om = omf-omi;
thi = [0,1]*pi + Delta_om/2;
thf = [2,1]*pi - Delta_om/2;


%% Calcoliamo il costo della manovra

DeltaV = 2*sqrt(mu/p)*e*sin(Delta_om/2);

end