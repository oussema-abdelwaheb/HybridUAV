clear; clc; close all;

capacities = [300 600 900];
mission = missionProfile();

results_all = cell(length(capacities),1);

for i=1:length(capacities)
    results_all{i} = simulateHybridUAV(mission, capacities(i));
end

figure;
for i = 1:length(capacities)
    plot(results_all{i}.time, results_all{i}.SOC, 'LineWidth', 1.3);
    hold on;
end
legend('300 Wh', '600 Wh', '900 Wh');
xlabel('Time (s)');
ylabel('SOC');
title('SOC Comparison for Battery Capacities');
grid on;
