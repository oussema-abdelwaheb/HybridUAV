function mission = missionProfile()
dt = 1; % s

mission.t_climb = 300;
mission.t_cruise = 1200;
mission.t_descent = 300;
mission.dt = dt;

t_total = mission.t_climb + mission.t_cruise + mission.t_descent;
mission.time = (0:dt:t_total)';

P_climb   = 1500;
P_cruise  = 800;
P_descent = 300;

mission.power = zeros(length(mission.time),1);
for k = 1:length(mission.time)
    t = mission.time(k);
    if t <= mission.t_climb
        mission.power(k) = P_climb;
    elseif t <= mission.t_climb + mission.t_cruise
        mission.power(k) = P_cruise;
    else
        mission.power(k) = P_descent;
    end
end
end
