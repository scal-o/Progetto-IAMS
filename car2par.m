function [a,e,i,OM,om,th] = car2par(rr,vv,mu)

% ATTENZIONE, I RISULTATI SONO IN RADIANTI

% Transformation from cartesian coordinates to keplerian Parameters
%
%
% -------------------------------------------------------------------------
% Input Arguments
% rr              [ 3 x 1 ]  position vector                [km]
% vv              [ 3 x 1 ]  velocity vector                [km/s]
% mu              [ 1 x 1 ]  gravitational parameter        [km^3/s^2]
%
% -------------------------------------------------------------------------
% Output Arguments
% a                [ 1 x 1 ] semimajor axis                 [km]
% e                [ 1 x 1 ] eccentricity                   [-]
% i                [ 1 x 1 ] inclination                    [rad]
% OM               [ 1 x 1 ] RAAN                           [rad]
% om               [ 1 x 1 ] pericenter anomaly             [rad]
% th               [ 1 x 1 ] true anomaly                   [rad]
%
% -------------------------------------------------------------------------

%% Definiamo la Terna Inerziale
I = [1; 0; 0];                      % Asse x           
J = [0; 1; 0];                      % Asse y
K = [0; 0; 1];                      % Asse z 

%% Semiasse Maggiore
r = norm(rr);                       % norma vettore posizione
v = norm(vv);                       % norma vettore velocità
a = ((2/r)-(v^2/mu))^(-1);          % semiasse maggiore 

%% Eccentricità
hh = cross(rr,vv);                  % vettore momento angolare specifico
h = norm(hh);                       % norma del vettore momento angolare specifico 
ee = cross(vv,hh)./mu - rr./r;                  % vettore eccentricità
e = norm(ee);                       % eccentricità

%% Inclinazione
i = acos(hh(3)/h);                  % inlcinazione

%% RAAN
N = cross(K,hh)./norm(cross(K,hh)); % Linea dei nodi
if N(2) >= 0                        % Componente J della linea dei nodi
    OM = acos(N(1));                % RAAN (caso 1)
else
    OM = 2*pi - acos(N(1));         % RAAN (caso 2)
end

%% Anomalia del pericentro 
if ee(3) >= 0                       % Componente K del vettore eccentricità
    om = acos(dot(N,ee)./e);             % Anomalia al Pericentro (caso 1)
else
    om = 2*pi - acos(dot(N,ee)./e);      % Anomalia al Pericentro (caso 2)
end

%% Anomalia Vera 
v_r = (dot(vv,rr))/r;                   % velocità radiale 
if v_r >= 0
    th = acos(dot(rr,ee)/(r*e));
else
    th = 2*pi - acos(dot(rr,ee)/(r*e));
end

%% OUTPUT

fprintf("\n Semiasse maggiore : %f",a);
fprintf("\n Eccentricità : %f",e);
fprintf("\n Inclinazione : %f",i);
fprintf("\n RAAN : %f",OM);
fprintf("\n Anomalia del pericentro : %f",om);
fprintf("\n Anomalia vera : %d",th);

fprintf("\n Considerando gli output di car2par in radianti\n");

end


 




