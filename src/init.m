function [position,velocity]=placeHolder111(tspan,dt,varargin)


p=inputParser();

% Required input
p.addRequired('tspan',@(x) isnumeric(x))
p.addRequired('dt', @(x) isnumeric(x));

%optional input
p.addParameter('massRange',[1,100], mRange, @(x) isnumeric(x) && isvector(x) );
p.addParameter('dampingRange',[1,100], bRange, @(x) isnumeric(x) && isvector(x) );
p.addParameter('stiffnessRange', [1,100],kRange, @(x) isnumeric(x) && isvector(x) );
p.addParameter('positionRange',[1,100],positionRange, @(x) isnumeric(x) && isvector(x) )
p.addParameter('velocityRange',[1,100],velocityRange, @(x) isnumeric(x) && isvector(x) )

p.parse(tspan,dt,varargin{:});


%open model
mdl = "Mass_Spring_Damper_System";
open_system(mdl)


%initialize conditions
v0 = rand()*(velocityRange(1)-velocityRange(0))+velocityRange(0); %velocity m/s
x0 = rand()*(positionRange(1)-positionRange(0))+potitionRange(0); %position m
m = rand()*(mRange(1)-mRange(0))+mRange(0); %mass kg
b = rand()*(bRange(1)-bRange(0))+bRange(0); %Damping Ns/m
k = rand()*(kRange(1)-kRange(0))+kRange(0); %stiffness N/m

%Setting runtime(just show explicitly)
tspan = tspan; %duration (s)
dt = dt; %step size (s)

dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim

%load the model
simIn = Simulink.SimulationInput(mdl);
simIn = simIn.setModelParameter("StopTime",tspan);
simIn = simIn.setModelParameter("FixedStep",dt);


simIn = simIn.setModelVariable("position",x0);
simIn = simIn.setModelVariable("velocity",v0);
simIn = simIn.setModelVariable("mass",m);
simIn = simIn.setModelVariable("Damping",b);
simIn = simIn.setModelVariable("stiffness", k);

%output the model
simout = sim(simIn);

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



end