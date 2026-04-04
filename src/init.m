



disp("-----------------------------")


velocity=[];
position=[];
parameters=[];

dt = 0.001';
tspan = 1;
Nsamples = 10;
options = {"massRange",[1,1],"dampingRange",[0,1],"stiffnessRange",[1,1],"positionRange",[5,5],"velocityRange",[0,0]};
%{
p.addParameter('massRange',[1,100],  @(x) isnumeric(x) && isvector(x) );
p.addParameter('dampingRange',[1,100],  @(x) isnumeric(x) && isvector(x) );
p.addParameter('stiffnessRange', [1,100], @(x) isnumeric(x) && isvector(x) );
p.addParameter('positionRange',[1,100], @(x) isnumeric(x) && isvector(x) )
p.addParameter('velocityRange',[1,100], @(x) isnumeric(x) && isvector(x) )
%}
for i=1:Nsamples
[pos,velo,paras]=ProcessData(tspan, dt, "massRange",[1,1],"dampingRange",[0,1],"stiffnessRange",[1,1],"positionRange",[5,5],"velocityRange",[0,0]);

velocity=[velocity;velo(:)'];
position=[position;pos(:)'];
parameters=[parameters;paras(:)'];

end



[cost,index] = rank_Parameter(velocity,position,@Converge_speed);

disp(cost)
disp(index)
disp(parameters)


[value,place]=min(cost);
disp("The best model:")
disp("Initial velocity:")
disp(parameters(place,1));
disp("Initial position:")
disp(parameters(place,2));
disp("mass:")
disp(parameters(place,3));
disp("damping:")
disp(parameters(place,4));
disp("stiffness:")
disp(parameters(place,5));


function [position,velocity,para]=ProcessData(tspan,dt,varargin)


p=inputParser();

% Required input
p.addRequired('tspan',@(x) isnumeric(x))
p.addRequired('dt', @(x) isnumeric(x));


%optional input
p.addParameter('massRange',[1,100],  @(x) isnumeric(x) && isvector(x) );
p.addParameter('dampingRange',[1,100],  @(x) isnumeric(x) && isvector(x) );
p.addParameter('stiffnessRange', [1,100], @(x) isnumeric(x) && isvector(x) );
p.addParameter('positionRange',[1,100], @(x) isnumeric(x) && isvector(x) )
p.addParameter('velocityRange',[1,100], @(x) isnumeric(x) && isvector(x) )

p.parse(tspan,dt,varargin{:});

massRange=p.Results.massRange;
dampingRange=p.Results.dampingRange;
stiffnessRange=p.Results.stiffnessRange;
positionRange=p.Results.positionRange;
velocityRange=p.Results.velocityRange;

% the position of the model
%open model
myfile="/Users/ajosh/Documents/GitHub/Simulink-Monte-Carlo/src/Mass_Spring_Damper_System2.slx";


load_system(myfile);
[~, mdl, ~] = fileparts(myfile);   


%open_system(mdl)


%initialize conditions
v0 = rand()*(velocityRange(2)-velocityRange(1))+velocityRange(1); %velocity m/s
x0 = rand()*(positionRange(2)-positionRange(1))+positionRange(1) %position m
m = rand()*(massRange(2)-massRange(1))+massRange(1); %mass kg
b = rand()*(dampingRange(2)-dampingRange(1))+dampingRange(1); %Damping Ns/m
k = rand()*(stiffnessRange(2)-stiffnessRange(1))+stiffnessRange(1); %stiffness N/m

%Setting runtime(just show explicitly)
tspan = tspan; %duration (s)
dt = dt; %step size (s)

dt_data_target = 1/30;
dt_data = round((dt_data_target/dt))*dt; %make sure dt_data is a multiple of dt_sim



%load the model
simIn = Simulink.SimulationInput(mdl);
simIn = simIn.setModelParameter("StopTime",num2str(tspan));
simIn = simIn.setModelParameter("FixedStep",num2str(dt));


simIn = setVariable(simIn,"x0",x0);
simIn = setVariable(simIn,"v0",v0);
simIn = setVariable(simIn,"m",m);
simIn = setVariable(simIn,"b",b);
simIn = setVariable(simIn,"k", k);
simIn = setVariable(simIn,"dt_data",dt_data);

%output the model
simout = sim(simIn);


v = simout.v.Data;
x = simout.x.Data;
t = simout.v.Time;


position=x;
velocity=v;


% Plot the results
%hold on;
figure
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Position (m)');
title('Position vs Time');

%hold on;

subplot(2,1,2);
plot(t, v);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');

para=[v0,x0,m,b,k];

%hold on;

end