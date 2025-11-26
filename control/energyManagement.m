function [P_batt_req, P_gen_req] = energyManagement(P_demand, batt, gen)
SOC = batt.SOC;

if SOC < 0.2
    P_gen_req = gen.P_rated;
    P_batt_req = P_demand - P_gen_req;
elseif SOC > 0.95
    P_gen_req = 0;
    P_batt_req = P_demand;
else
    if P_demand > gen.P_rated
        P_gen_req = gen.P_rated;
        P_batt_req = P_demand - P_gen_req;
    else
        P_gen_req = P_demand + 100;
        P_batt_req = -100;
    end
end
end
