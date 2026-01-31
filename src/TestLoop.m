%Initial conditions
v0 = transpose(1:10); %velocity m/s
x0 = transpose(1:10); %position m
m = transpose(1:10); %mass kg
b = transpose(1:10); %Damping Ns/m
k = transpose(1:10); %stiffness N/m
F0 = transpose(2:11); %input force


open_system(mdl)

mdl = "Mass_Spring_Damper_System";
