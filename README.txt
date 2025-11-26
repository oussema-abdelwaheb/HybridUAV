# Hybrid-Electric UAV MATLAB Simulation

## System Overview
Hybrid UAV with electric motor, battery pack, and generator.  
Simulates power flow, battery SOC, fuel use, and energy management.

## Features
- Modular MATLAB code  
- Time-domain simulation (1-second resolution)  
- Multi-phase mission: climb → cruise → descent  
- High-quality, publication-ready plots  
- Battery trade-off analysis (300, 600, 900 Wh)

## Folder Structure
HybridUAV_Project/
│ components/ …
│ mission/ …
│ control/ …
│ simulation/ …
│ plots/ …


## Instructions
1. Set battery capacity in `main_runSimulation.m`  
2. Run simulation → see plots  
3. Compare battery sizes → run `main_compareBatteries.m`
