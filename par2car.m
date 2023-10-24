function [rr, vv] = par2car(a, e, i, OM, om, th, mu)

% ATTENZIONE, GLI INPUT SONO IN RADIANTI

% Transformation from Keplerian parameters to Cartesian coordinates
% 
% [rr,vv] = par2car(a,e,i, OM,om,th,mu)
% 
% ------------------------------------------------------------------------
% 
% Input arguments:
% a        [1x1]  semi-major axis                      [km]
% e        [1x1]  eccentricity                         [-]
% i        [1x1]  inclination                          [rad]
% OM       [1x1]  RAAN                                 [rad]
% om       [1x1]  pericenter anomaly                   [rad]
% th       [1x1]  true anomaly                         [rad]
% mu       [1x1]  gravitational parameter              [km^3/s^2]
% 
% ------------------------------------------------------------------------
% 
% Output arguments:
% rr       [3x3]  position vector                      [km]
% vv       [3x3]  velocity vector                      [km/s]

p = a * (1-e^2);                        % semilato retto
r = p / (1 + e * cos(th));              % modulo della posizione
r_pf = r .* [cos(th); sin(th); 0];      % vettore posizione in PF
v_pf = ( (mu/p)^0.5 ) .* [-sin(th); e + cos(th); 0]; % vettore velocità in PF
vs_pf = [r_pf ; v_pf];                  % vettore di stato in PeriFocale

R_om = [cos(om),  sin(om),  0;
        -sin(om), cos(om),  0;
        0,         0,       1];

R_i = [1,  0,      0;
       0, cos(i),  sin(i);
       0, -sin(i), cos(i)];

R_OM = [cos(OM),  sin(OM), 0;
        -sin(OM), cos(OM), 0;
        0,        0,       1];

T_eci_pf = R_om * R_i * R_OM;           % matrice di rotazione totale, ottengo PF partendo da ECI

r_eci = T_eci_pf' * r_pf;                % vettore posizione in ECI
v_eci = T_eci_pf' * v_pf;                % vettore velocità in ECI
vs_eci = [r_eci; v_eci];                  % vettore di stato in ECI

% output
rr = r_eci;
vv = v_eci;

fprintf("\n Considerando gli input di par2car in radianti\n");

end
