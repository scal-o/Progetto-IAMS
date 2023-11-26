% Script per tracciare un grafico con l'andamento del DeltaV e del Deltat per ogni biellittica

clear
close
clc

% Definizione costanti 
mu = 398600; 
dth = 1*pi/180;

% Dati orbita iniziale
rr = [-4350.9803; -6668.1393; 1517.6565];
vv = [4.9690; -4.2630; -2.4370];
[ai , ei, inci, OMi, omi, thi] = car2par(rr, vv, mu);

% Dati orbita finale
af = 12950.0; 
ef = 0.2682; 
incf = 0.7222; 
OMf = 1.0360;
omf = 0.7604; 
thf = 1.6230;

% Dati delle orbite di trasferimento
ra_t_v = 1*af:100:5*af;           % vari raggi di apogeo da testare 
optimal_V = zeros(length(ra_t_v),1);
optimal_t = zeros(length(ra_t_v),1);

for i = 1:length(ra_t_v)
    ra_t = ra_t_v(i);               % scelta del raggio di apogeo per l'iterazione

    % Calcolo dati per la prima orbita di trasferimento
    rpi = ai*(1-ei); 
    at1 = (ra_t + rpi)/2;
    et1 = (at1-rpi)/at1;
    
    % Calcolo deltaV per il primo impulso della biellittica
    DeltaV1 = sqrt(mu)*(sqrt((2/rpi)-(1/at1)) - sqrt(((2/rpi)-(1/ai))));

    % Calcolo deltaV e theta per il cambio di piano
    [DeltaV_plane, omf_in, possible_theta] = changeOrbitalPlane(at1, et1, inci, OMi, omi, incf, OMf, mu);

    % Calcolo dati seconda orbita di trasferimento
    rpf = af*(1-ef);
    at2 = (ra_t + rpf)/2;
    et2 = (at2-rpf)/at2;

    % Calcolo deltaV per il secondo e terzo impulso della biellittica
    DeltaV2 = sqrt(mu)*(sqrt((2/ra_t)-(1/at2)) - sqrt(((2/ra_t)-(1/at1))));
    DeltaV3 = sqrt(mu)*(sqrt((2/rpf)-(1/af)) - sqrt(((2/rpf)-(1/at2))));

    % Calcolo deltaV e theta per il cambio di anomalia del perigeo
    [DeltaV_perigee, thi, thf] = changePericenterArg(af, ef, omf_in, omf, mu);

    % Calcolo deltaV totale della manovra per i due casi (ottimizzando
    % deltaV o deltat)
    optimal_V(i)= sum(abs([DeltaV1, DeltaV2, DeltaV3, DeltaV_perigee, DeltaV_plane(2)]));
    optimal_t(i) = sum(abs([DeltaV1, DeltaV2, DeltaV3, DeltaV_perigee, DeltaV_plane(1)]));
end

% Plot dei deltaV
plot(ra_t_v, optimal_V)
hold on
grid on
plot(ra_t_v, optimal_t)
legend('Optimal V', 'Optimal t')

% Calcolo del deltaV minimo e del corrispondente raggio di apogeo
min_optV = min(optimal_V);
min_optt = min(optimal_t);

i = find(optimal_V == min_optV);
j = find(optimal_t == min_optt);

fprintf('Il DeltaV minimo ottimizzando il DeltaV è %f km/s, ottenuto per un raggio di apogeo pari a %f km.\n', min_optV, ra_t_v(i))
fprintf('Il DeltaV minimo ottimizzando il tempo è %f km/s, ottenuto per un raggio di apogeo pari a %f km.\n', min_optt, ra_t_v(j))








