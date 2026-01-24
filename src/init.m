clc
close all


mdl = "Mass_Spring_Damper_System";
inner_mdl = "Mass_Spring_Damper_Subsystem";

open_system(mdl)

%Initial conditions
v0 = transpose(0:9); %velocity m/s
x0 = transpose(0:9); %position m
m = transpose(1:10);%:10; %mass kg
b = transpose(1:10);%:10; %Damping Ns/m
k = transpose(1:10);%:10; %stiffness N/m
F0 = transpose(0:9); %Input Force

%Setting runtime
tspan = 20; %duration (s)
dt = 1/100; %step size (s)



dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim



blocks = ["Mass_Spring_Damper_Subsystem/Vgral", "Mass_Spring_Damper_Subsystem/Xgral", "Mass_Spring_Damper_Subsystem/Mass", "Mass_Spring_Damper_Subsystem/Damping", "Mass_Spring_Damper_Subsystem/Stiffness", "Input Force" ];

block_parameters = ["InitialCondition", "InitialCondition", "Gain", "Gain", "Gain", "Value"];

parameters = [v0, x0, m, b, k, F0];



simout = Repeater(parameters, mdl, blocks, block_parameters);