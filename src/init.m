clc
close all


mdl = "Mass_Spring_Damper_System";
open_system(mdl)

%clear v;
%clear x;
%clear t;

%Initial conditions
v0 = 0; %velocity m/s
x0 = 0; %position m
m = 1; %mass kg
b = 1; %Damping Ns/m
k = 1; %stiffness N/m
F0 = [0.5,1,1.5,2,2.5,3]; %Input Force

%Setting runtime
tspan = 20; %duration (s)
dt = 1/100; %step size (s)

dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim


simout = Repeater(F0, mdl, "/Input Force", "Value");





% Plot the results

