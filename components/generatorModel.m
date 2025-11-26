function [P_gen_out, fuel_used] = generatorModel(P_required, gen)
P_out = min(P_required, gen.P_rated);
P_gen_out = P_out;

fuel_used = (P_gen_out / gen.efficiency) * gen.fuel_rate; % kg/s
end
