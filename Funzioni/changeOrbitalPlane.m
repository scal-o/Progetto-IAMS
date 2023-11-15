function [DeltaV, omf, theta] = changeOrbitalPlane(a, e, inci, OMi, omi, incf, OMf, mu)
% Change of plane maneuver
% 
% [DeltaV, omf, theta] = changeOrbitalPlane(a, e, ii, OMi, omi, if, OMf, mu)  
% 
% -------------------------------------------------------------------------
% Input arguments:
% a         [1x1]   semi-major axis                 [km]
% e         [1x1]   eccentricity                    [-]
% inci       [1x1]   initial inclination             [rad]
% incf       [1x1]   final inclination               [rad]
% OMi       [1x1]   initial RAAN                    [rad]
% OMf       [1x1]   final RAAN                      [rad]
% omi       [1x1]   initial pericenter anomaly      [rad]
% mu        [1x1]   gravitational parameter         [km^3/s^2]
% 
% -------------------------------------------------------------------------
% Output arguments:
% DeltaV    [1x1]   1st maneuver impulse            [km/s]
% omf       [1x1]   final pericenter anomaly        [rad]
% theta     [1x1]   true anomaly at maneuver        [rad]
%
% -------------------------------------------------------------------------

% Calcolo differenze di RAAN e inclinazione
DeltaOM = OMf - OMi;
Deltai = incf - inci;

if DeltaOM < 0
    DOM = -DeltaOM;
else 
    DOM = DeltaOM;
end

alpha = acos(cos(inci)*cos(incf) + sin(inci)*sin(incf)*cos(DOM));

sinui = sin(DOM)/sin(alpha)*sin(incf);
sinuf = sin(DOM)/sin(alpha)*sin(inci);

% Check per il segno di DeltaOM e Deltai negli if
if (DeltaOM > 0 && Deltai > 0)
    
    cosui = (-cos(incf) + cos(alpha)*cos(inci))/(sin(alpha)*sin(inci));
    cosuf = (cos(inci) - cos(alpha)*cos(incf))/(sin(alpha)*sin(incf));

    ui = atan2(sinui, cosui);
    uf = atan2(sinuf, cosuf);

    theta = ui - omi;
    omf = uf - theta;

elseif (DeltaOM > 0 && Deltai < 0)

    cosui = (cos(incf) - cos(alpha)*cos(inci))/(sin(alpha)*sin(inci));
    cosuf = (-cos(inci) + cos(alpha)*cos(incf))/(sin(alpha)*sin(incf));

    ui = atan2(sinui, cosui);
    uf = atan2(sinuf, cosuf);

    theta = 2*pi - ui - omi;
    omf = 2*pi - uf - theta;

elseif (DeltaOM < 0 && Deltai > 0)
        
    cosui = (-cos(incf) + cos(alpha)*cos(inci))/(sin(alpha)*sin(inci));
    cosuf = (+cos(inci) - cos(alpha)*cos(incf))/(sin(alpha)*sin(incf));

    ui = atan2(sinui, cosui);
    uf = atan2(sinuf, cosuf);

    theta = 2*pi - ui - omi;
    omf = 2*pi - uf - theta;

elseif (DeltaOM < 0 && Deltai < 0)
    
    cosui = (-cos(incf) + cos(alpha)*cos(inci))/(sin(alpha)*sin(inci));
    cosuf = (cos(inci) - cos(alpha)*cos(incf))/(sin(alpha)*sin(incf));

    ui = atan2(sinui, cosui);
    uf = atan2(sinuf, cosuf);

    theta = ui - omi;
    omf = uf - theta;
end

% Scelta di theta

if cos(theta) > 0
    theta = theta + pi;
end


% Calcolo DeltaV

p = a * (1-e^2);
V_theta = sqrt(mu/p)*(1 + e*cos(theta));
DeltaV = 2*V_theta*sin(alpha/2);
    
end

