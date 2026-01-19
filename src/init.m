clc
close all


mdl = "Mass_Spring_Damper_System";
inner_mdl = "Mass_Spring_Damper_Subsystem";

open_system(mdl)

%Initial conditions
v0 = 0; %velocity m/s
x0 = 0; %position m
m = 1;%:10; %mass kg
b = 1;%:10; %Damping Ns/m
k = 1;%:10; %stiffness N/m
F0 = 0:10; %Input Force

%Setting runtime
tspan = 20; %duration (s)
dt = 1/100; %step size (s)

dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim


simoutF = Repeater(F0, mdl, "/Input Force", "Value");


