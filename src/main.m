
model="/Users/bochaocai/Documents/MATLAB/RoboSub/Monte_Carlo_Proof/Simulink-Monte-Carlo/src/cascaded_pid_controller.slx";

%Import the initial constant
constant="this is constant";

% The distribution for the random process.
% We have "normal" and "uniform"
dist="this is dist";

% provide the path for the cost function that we want to use
cost_function_path="cost fcn path";

% 0 -> do not graph the result
% 1 -> graph the result 
graph_flag="";

% 0 -> do not save the result
% 1 -> save the result 
save_flag="";

% whrer to save the result
save_path="";

% the number of the simulations
Nsamples="";

%{
The part we randomlize our para
It should be like:

if the dist(distribution) is uniform:
paras={velocity=[lowerBound,upperBound].
       position=[]
        }



%}
paras