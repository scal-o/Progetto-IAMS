function plotOrbit_new(a,e,i,OM,om,th0,thf,dth,mu)

% 3D orbit
% 
% plotOrbit(a,e, i, OM, om, th0, dth, mu)
% 
% --------------------------------------------------------------------------
% Input arguments:
% a               [1x1]   semi-major axis                 [km]
% e               [1x1]   eccentricity                    [-]
% i               [1x1]   inclination                     [rad]
% OM              [1x1]   RAAN                            [rad]
% om              [1x1]   pericenter anomaly              [rad]
% th0             [1x1]   initial true anomaly            [rad]
% thf             [1x1]   final true anomaly              [rad]
% dth             [1x1]   true anomaly step size          [rad]
% mu              [1x1]   gravitational parameter         [km^3/s^2]


%% Creazione e riempimento dei vettori (matrici)

th_v = th0:dth:thf;           % vettore theta
rr = [];                    % posizione
vv = [];                    % velocità


for k = 1:length(th_v)
    th = th_v(k)            % selezione timestep

    [rr_k, vv_k] = par2car(a, e, i, OM, om, th, mu);        % calcolo posizione e velocità
    
    rr = [rr, rr_k];        % riempimento vettore posizione
    vv = [vv, vv_k];        % riempimento vettore velocità

end

%% plot3 e hgtransform

x = rr(1,:);
y = rr(2,:);
z = rr(3,:);


figure(1)
Terra_3D
plot3(x, y, z, 'LineWidth',2, 'Color','c')
axis equal

ax = gca;            % setta ax = current axes
h = hgtransform('Parent', ax);
plot3(x(1), y(1), z(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'Color', 'r', 'Parent', h)

for k = 2:length(th_v)
    m = makehgtform("translate", x(k)-x(1), y(k)-y(1), z(k)-z(1));
    h.Matrix = m;
    drawnow
end


