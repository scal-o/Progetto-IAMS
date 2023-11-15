function [rr, vv] = par2car(a, e, i, OM, om, th, mu)

% ATTENZIONE, GLI INPUT SONO IN RADIANTI

% Transformation from Keplerian parameters to Cartesian coordinates
% 
% [rr,vv] = par2car(a,e,i,OM,om,th,mu)
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


%% Definiamo le matrici di rotazione

% Rotazione intorno a k
R_OM = [cos(OM),  sin(OM), 0;
        -sin(OM), cos(OM), 0;
        0,        0,       1];

% Rotazione intorno a i'
R_i = [1,  0,      0;
       0, cos(i),  sin(i);
       0, -sin(i), cos(i)];

% Rotazione intorno a k''
R_om = [cos(om),  sin(om),  0;              
        -sin(om), cos(om),  0;
        0,         0,       1];

% Matrici di trasformazione

T_ECI_to_PF = R_om * R_i * R_OM;         % Trasformazione dal sistema ECI al sistema PF
T_PF_to_ECI = T_ECI_to_PF';              % Trasformazione dal sistema PF al sistema ECI


%% Calcoliamo i vettori velocità e raggio nel sistema PF

p = a * (1-e^2);                                        % semilato retto

r = p / (1 + e * cos(th));                              % modulo della posizione
rr_pf = r * [cos(th); sin(th); 0];                      % vettore posizione in PF
vv_pf = sqrt(mu/p) * [-sin(th); e + cos(th); 0];        % vettore velocità in PF


%% Trasformiamo i vettori dal sistema PF al sistema ECI

rr = T_PF_to_ECI * rr_pf;                % vettore posizione in ECI
vv = T_PF_to_ECI * vv_pf;                % vettore velocità in ECI


end
