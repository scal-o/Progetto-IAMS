function [DeltaV1, DeltaV2, Deltat] = bitangentTransfer(ai, ei, af, ef, type, mu)
% Bitangent transfer for elliptic orbits
% 
% [DeltaV1, DeltaV2, Deltat] = bitangentTransfer(ai, ei, af, ef, type, mu)
% 
% -------------------------------------------------------------------------
% Input arguments:
% ai        [1x1]   initial semi-major axis         [km]
% ei        [1x1]   initial eccentricity            [-]
% af        [1x1]   final semi-major axis           [km]
% ef        [1x1]   final eccentricity              [-]
% type      [char]  maneuver type
% mu        [1x1]   gravitational parameter         [km^3/s^2]
% 
% -------------------------------------------------------------------------
% Output arguments:
% DeltaV1   [1x1]   1st maneuver impulse            [km/s]
% DeltaV2   [1x1]   2nd maneuver impulse            [km/s]
% Deltat    [1x1]   maneuver time                   [s]
%
% -------------------------------------------------------------------------
% Intermediate values:
% rpt       [1x1]   transfer orbit perigee radius   [km]
% rat       [1x1]   transfer orbit apogee radius    [km]
% at        [1x1]   transfer orbit semimajor axis   [km]
% et        [1x1]   transfer orbit eccentricity     [km]

om = 0;

switch type
    case 'pa'
        
        % Calcolo valori orbita di trasferimento
        rpt = ai*(1-ei);
        rat = af*(1+ef);
        at = (rpt + rat)/2;

        % Calcolo deltaV
        DeltaV1 = sqrt(mu)*(sqrt(2/rpt - 1/at) - sqrt(2/rpt - 1/ai));
        DeltaV2 = sqrt(mu)*(sqrt(2/rat - 1/af) - sqrt(2/rat - 1/at));



    case 'pp'
        
        fprintf("Nota: omf = omi + pi\n")
        % Calcolo valori orbita di trasferimento
        rpt = ai*(1-ei);
        rat = af*(1-ef);
        at = (rpt + rat)/2;

        % Calcolo deltaV
        DeltaV1 = sqrt(mu)*(sqrt(2/rpt - 1/at) - sqrt(2/rpt - 1/ai));
        DeltaV2 = sqrt(mu)*(sqrt(2/rat - 1/af) - sqrt(2/rat - 1/at));


    case 'aa'

        om = pi;
        fprintf("Nota: omf = omi + pi\n")
        % Calcolo valori orbita di trasferimento
        rpt = ai*(1+ei);
        rat = af*(1+ef);
        at = (rpt + rat)/2;

        % Calcolo deltaV
        DeltaV1 = sqrt(mu)*(sqrt(2/rpt - 1/at) - sqrt(2/rpt - 1/ai));
        DeltaV2 = sqrt(mu)*(sqrt(2/rat - 1/af) - sqrt(2/rat - 1/at));


    case 'ap'

        % Calcolo valori orbita di trasferimento
        rpt = af*(1-ef);
        rat = ai*(1+ei);
        at = (rpt + rat)/2;

        % Calcolo deltaV
        DeltaV1 = sqrt(mu)*(sqrt(2/rat - 1/at) - sqrt(2/rat - 1/ai));
        DeltaV2 = sqrt(mu)*(sqrt(2/rpt - 1/af) - sqrt(2/rpt - 1/at));


    otherwise
        error("Unexpected transfer type. Check type variable and try again.\n")
        
end

% Calcolo del Deltat
Deltat = pi*sqrt(at^3/mu);

% Disegno dell'orbita di trasferimento in 2D
et = (at - rpt)/at;
plotOrbit2D(at,et,0,0,om,0,pi,1*pi/180,mu)


