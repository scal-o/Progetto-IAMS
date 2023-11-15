function plotOrbit2D(a,e,i,OM,om,th0,thf,dth,mu)

%% Creazione e riempimento dei vettori (matrici)

th_v = th0:dth:thf;           % vettore theta
rr = [];                    % posizione
vv = [];                    % velocità


for k = 1:length(th_v)
    th = th_v(k);            % selezione timestep

    [rr_k, vv_k] = par2car(a, e, i, OM, om, th, mu);        % calcolo posizione e velocità
    
    rr = [rr, rr_k];        % riempimento vettore posizione
    vv = [vv, vv_k];        % riempimento vettore velocità

end

%% plot2 e hgtransform

x = rr(1,:);
y = rr(2,:);


plot(x, y, 'LineWidth',2)
axis equal
