function [P_elec] = motorModel(P_mech, motor)
P_elec = P_mech / motor.efficiency;
end
