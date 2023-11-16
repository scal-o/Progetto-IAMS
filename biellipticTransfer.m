function [DeltaV1, DeltaV2, DeltaV3, DeltaV, Deltat1, Deltat2, Deltat] = biellipticTransfer(ai, ei, af, ef, ra_t,mu)

% Biellipitc Transfer Maneuvre 
% 
% -------------------------------------------------------------------------------------------
% Input Arguments: 
% ai            [1x1]    initial semi-major axis                  [Km]
% ei            [1x1]    initial eccentricity                     [-]
% af            [1x1]    final semi-major axis                    [Km]
% ef            [1x1]    final eccentricity                       [-]
% ra_t          [1x1]    transfer orbits apocenter distance       [Km]
% mu            [1x1]    gravitational parameter                  [-]
% 
% -------------------------------------------------------------------------------------------
% Output Arguments:
% DelatV1       [1x1]    1st maneuvre impulse             [Km/s]
% DelatV2       [1x1]    2nd maneuvre impulse             [Km/s]
% DelatV3       [1x1]    3rd maneuvre impulse             [Km/s]
% DelatV        [1x1]    total maneuvre impulse           [Km/s]
% Delatt1       [1x1]    maneuvre time 1                  [Km/s]
% Delatt2       [1x1]    maneuvre time 2                  [s]
% Delatt        [1x1]    maneuvre total time              [s]

% Caratterizzazione delle due orbite di trasferimento
rpi = ai*(1-ei); 
rpf = af*(1-ef);
at1 = (ra_t + rpi)/2;
at2 = (ra_t + rpf)/2;

% Calcolo degli impulsi 
DeltaV1 = sqrt(mu)*(sqrt((2/rpi)-(1/at1)) - sqrt(((2/rpi)-(1/ai))));
DeltaV2 = sqrt(mu)*(sqrt((2/ra_t)-(1/at2)) - sqrt(((2/ra_t)-(1/at1))));
DeltaV3 = sqrt(mu)*(sqrt((2/rpf)-(1/af)) - sqrt(((2/rpf)-(1/at2))));
DeltaV = abs(DeltaV1) + abs(DeltaV2) + abs(DeltaV3);

% Calcolo dei tempi 
Deltat1 = pi*sqrt(at1^3/mu);
Deltat2 = pi*sqrt(at2^3/mu);
Deltat = Deltat1 + Deltat2;

%vPrints 
fprintf("\n Il primo impulso vale: %f",DeltaV1);
fprintf("\n Il secondo impulso vale: %f",DeltaV2);
fprintf("\n Il terzo impulso vale: %f",DeltaV3);
fprintf("\n L'impulso totale vale: %f", DeltaV);
fprintf("\n tempo di trasferimento 1: %f", Deltat1);
fprintf("\n tempo di trasferimento 2: %f", Deltat2);
fprintf("\n tempo di trasferimento totale: %f", Deltat);



end 