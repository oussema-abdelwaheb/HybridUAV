function plotResults(results, mission)
%% Extract data
time = results.time(:);
P_demand = results.P_demand(:);
P_batt   = results.P_batt(:);
P_gen    = results.P_gen(:);
SOC      = results.SOC(:);
missionP = mission.power(:);

%% Colors (modern aerospace palette)
blue   = [0.00 0.45 0.90];
orange = [0.95 0.55 0.10];
red    = [0.85 0.25 0.25];
grey   = [0.4 0.4 0.4];
green  = [0.20 0.70 0.30];
teal   = [0.20 0.70 0.75];
phaseColor = [0.85 0.85 0.85];   % shaded background

%% Determine mission-phase boundaries
t1 = mission.t_climb;
t2 = mission.t_climb + mission.t_cruise;
t3 = mission.t_climb + mission.t_cruise + mission.t_descent;

%% Create figure
figure('Color','white','Position',[80 80 1000 750]);
set(groot,'defaultAxesFontSize',12,'defaultLineLineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) POWER FLOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,1); hold on; box on; grid on;

yl = [min([P_batt;P_gen;P_demand])-100 , max([P_batt;P_gen;P_demand])+200];

% Mission phase shading
phaseColors = [1 0.9 0.9; 0.9 1 0.9; 0.9 0.9 1]; % light red, green, blue
phaseAlpha = 0.15;
p1 = patch([0 t1 t1 0], [yl(1) yl(1) yl(2) yl(2)], phaseColors(1,:), 'FaceAlpha', phaseAlpha, 'EdgeColor','none');
p2 = patch([t1 t2 t2 t1], [yl(1) yl(1) yl(2) yl(2)], phaseColors(2,:), 'FaceAlpha', phaseAlpha, 'EdgeColor','none');
p3 = patch([t2 t3 t3 t2], [yl(1) yl(1) yl(2) yl(2)], phaseColors(3,:), 'FaceAlpha', phaseAlpha, 'EdgeColor','none');
uistack([p1 p2 p3],'bottom');

% ---- FIXED: Store plot handles for legend color matching ----
hDemand   = plot(time, P_demand, 'Color', grey,  'LineWidth', 2.5);
hBattery  = plot(time, P_batt,   'Color', blue,  'LineWidth', 2.2);
hGenerator= plot(time, P_gen,    'Color', red,   'LineWidth', 2.2);

ylabel('Power (W)');
title('Hybrid UAV Power Distribution');

legend([hDemand hBattery hGenerator], ...
       {'Demand','Battery','Generator'}, ...
       'Location','northoutside','Orientation','horizontal');

% Annotate phases
text(t1/2,      yl(2)*0.92, 'CLIMB',  'FontWeight','bold','HorizontalAlignment','center');
text((t1+t2)/2, yl(2)*0.92, 'CRUISE', 'FontWeight','bold','HorizontalAlignment','center');
text((t2+t3)/2, yl(2)*0.92, 'DESCENT','FontWeight','bold','HorizontalAlignment','center');

ylim(yl);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2) BATTERY SOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,2); hold on; box on; grid on;

plot(time, SOC*100, 'Color', orange, 'LineWidth', 2.8);
scatter(time(1), SOC(1)*100,  60, green,  'filled', 'MarkerEdgeColor','k');
scatter(time(end), SOC(end)*100, 60, red, 'filled', 'MarkerEdgeColor','k');

midSOC = mean(SOC)*100;
plot([time(1) time(end)], [midSOC midSOC], '--', 'Color',[0.5 0.5 0.5 0.6]);

ylabel('State of Charge (%)');
title('Battery SOC Evolution');
ylim([min(SOC*100)-5, max(SOC*100)+5]);

text(time(1)+50, SOC(1)*100+2,  'Start', 'FontWeight','bold');
text(time(end)-150, SOC(end)*100+2, 'End', 'FontWeight','bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3) MISSION PROFILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,3); hold on; box on; grid on;

% Mission shaded plot compatible with all MATLAB versions
hA = area(time, missionP);
if isprop(hA,'FaceColor'), hA.FaceColor = teal; end
if isprop(hA,'EdgeColor'), hA.EdgeColor = 'none'; end
if isprop(hA,'FaceAlpha'), hA.FaceAlpha = 0.35; end

plot(time, missionP, 'Color', teal*0.6, 'LineWidth', 1.5);

xlabel('Time (s)');
ylabel('Power (W)');
title('Mission Power Requirement');

% Annotate phases
yl2 = ylim;
text(t1/2,      yl2(2)*0.85, 'CLIMB',  'FontWeight','bold', 'HorizontalAlignment','center');
text((t1+t2)/2, yl2(2)*0.85, 'CRUISE', 'FontWeight','bold', 'HorizontalAlignment','center');
text((t2+t3)/2, yl2(2)*0.85, 'DESCENT','FontWeight','bold', 'HorizontalAlignment','center');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tightfig; % If missing, MATLAB ignores it without error.

end
