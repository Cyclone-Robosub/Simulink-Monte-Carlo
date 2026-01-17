


mdl = "Mass_Spring_Damper_System";
open_system(mdl)

%Initial conditions
v0 = [0.5, 1, 1.5, 2, 2.5, 3]; %velocity m/s
x0 = [0.5, 1, 1.5, 2, 2.5, 3]; %position m
m = [0.5, 1, 1.5, 2, 2.5, 3]; %mass kg
b = [0.5, 1, 1.5, 2, 2.5, 3]; %Damping Ns/m
k = [0.5, 1, 1.5, 2, 2.5, 3]; %stiffness N/m

%Setting runtime
tspan = 20; %duration (s)
dt = 1/100; %step size (s)

dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim

simIn = Simulink.SimulationInput(mdl);
simout = sim(simIn);

%Repeater; 



v = simout.v.Data;
x = simout.x.Data;
t = simout.v.Time;

% Plot the results
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Position (m)');
title('Position vs Time');

subplot(2,1,2);
plot(t, v);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');
