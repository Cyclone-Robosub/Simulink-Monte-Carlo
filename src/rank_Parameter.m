%{
y = @(x) 1./x.*sin(x);
y1 = @(x) exp(-0.1 * x) .* cos(x) + 5;
y2 = @(x) (10 ./ sqrt(x)) .* sin(x) + sin(0.1 * x);

list=[y1(1:100)*1000;y2(1:100);y(1:100)];
position=[1,1,1,1];
[cost,index] = rank_Parameter(list,position,@Converge_speed)


plot(1:100,y(1:100))
hold on;
plot(1:100,y1(1:100))
hold on;
plot(1:100,y2(1:100))

%}



function [cost,index] = rank_Parameter(velocity,position,fcn)
% This function will rank the random parameters and return the best one
% velocity will be a "n x time_split" array. n is the number of our tries
% Position has the same shape as velocity does
% Mode is a number from 1 ~ 2. Which tell us which rank rule we will apply

cost=fcn(velocity,position);
[~,index1]=sort(cost);



[~,index]=sort(index1);


end





