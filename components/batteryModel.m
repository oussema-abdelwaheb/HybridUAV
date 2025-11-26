function [P_batt_out, batt] = batteryModel(P_request, batt)
% Battery with internal resistance and SOC tracking

R = batt.R_internal;
P_request = max(min(P_request, batt.P_max), -batt.P_charge_max);

V = batt.V_nom;
I = P_request / V;
P_loss = I^2 * R;

P_batt_out = P_request - P_loss;

E_wh = batt.SOC * batt.E_capacity - P_batt_out * batt.dt / 3600;
E_wh = min(max(E_wh, 0), batt.E_capacity);

batt.SOC = E_wh / batt.E_capacity;

end
