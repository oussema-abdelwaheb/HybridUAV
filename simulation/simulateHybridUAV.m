function results = simulateHybridUAV(mission, batteryCapacity)
dt = mission.dt;
time = mission.time;
N = length(time);

% Battery
batt.E_capacity = batteryCapacity; 
batt.V_nom = 50; 
batt.R_internal = 0.05;
batt.P_max = 2000;
batt.P_charge_max = 800;
batt.SOC = 0.9;
batt.dt = dt;

% Motor
motor.efficiency = 0.88;

% Generator
gen.P_rated = 1000;
gen.efficiency = 0.30;
gen.fuel_rate = 0.00007;

% Initialize arrays
P_demand = mission.power;
P_motor_elec = zeros(N,1);
P_batt = zeros(N,1);
P_gen = zeros(N,1);
SOC = zeros(N,1);
fuel = zeros(N,1);

% Simulation loop
for k = 1:N
    P_req = P_demand(k);
    P_motor_elec(k) = motorModel(P_req, motor);
    [P_batt_req, P_gen_req] = energyManagement(P_motor_elec(k), batt, gen);
    [P_gen(k), fuel(k)] = generatorModel(P_gen_req, gen);
    [P_batt(k), batt] = batteryModel(P_batt_req, batt);
    SOC(k) = batt.SOC;
end

results.time = time;
results.P_demand = P_demand;
results.P_batt = P_batt;
results.P_gen = P_gen;
results.SOC = SOC;
results.fuel_total = sum(fuel)*dt;

end
