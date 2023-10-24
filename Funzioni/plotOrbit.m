function [rr,vv] = plotOrbit(a,e, i, OM, om, th0, thf, dth, mu)

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

th_v = (th0:dth:thf);
vs = [];
rr = [];
vv = [];
for k = 1:length(th_v)
    th = th_v(k); 
    [rr_k, vv_k] = par2car(a, e, i, OM, om, th, mu);
    clc;
    rr = [rr, rr_k];
    vv = [vv, vv_k];
%     vs(i) = [rr, vv];
end
fprintf("\n Considerando gli output di car2par in radianti\n");


Terra_3D
plot3(rr(1,:), rr(2,:), rr(3,:), 'LineWidth',2,'Color','c')

%% Attraverso Animated Line
x = rr(1,:);
y = rr(2,:);
z = rr(3,:);

h = animatedline('Color','r','LineWidth',3,'MarkerSize',2);
g = animatedline('Color','c','LineWidth',3);
grid on

%     comet3(rr(1,:),rr(2,:),rr(3,:))

for k = 1+2:length(x)
    addpoints(h,x(k),y(k),z(k));
    addpoints(g,x(k-2),y(k-2),z(k-2));
    drawnow
end


%% Versione Martina (la quale ringraziamo <3) 
% 
% for j = 1 : length(rr(1,:))
%     clf
%     plot3(rr(1,:),rr(2,:),rr(3,:),vv(1,:),vv(2,:),vv(3,:),'Color', [0 0 0],'LineWidth', 2);
%     grid on
%     hold on
%     axis equal
%     satellite = surf(rr(1,j),rr(2,j),rr(3,j));
%     set(satellite, 'edgecolor','none','facecolor', [0.9290 0.6940 0.1250])
%  
% end
% 
% figure(1);
% for j = 1:length(t)
%     title(['Satellite at t =',num2str(t(j)),'seconds']);
%     clf
%     plot3(rr(1,:),rr(2,:),rr(3,:),vv(1,:),vv(2,:),vv(3,:),'Color', [0 0 0],'LineWidth', 2);
%     grid on
%     % ax = gca;
%     % ax.LineWidth = 4;
%     % set(ax, 'Color', [1 1 1])
%     hold on
%     axis equal
%     earth_sphere(N);
%     satellite = surf(X_sat+rr_sat(1,j),Y_sat+rr_sat(2,j),Z_sat+rr_sat(3,j));
%     set(satellite, 'edgecolor','none','facecolor', [0.9290 0.6940 0.1250])
%     % set(gca,'Color','k')
%     % pause(norm(rr_sat(:,j))*dtheta/norm(vv_sat(:,j)));
% %     pause(1e-5)
% end
% 
% 
