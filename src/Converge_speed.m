function cost = converge_speed(velocity,position)
    %set the threshold
    threshold = 0.5;

    
    %initialize the cost list
    cost=[];
    
    %get the number of tries
    [n,time_split] = size(velocity);

    
    for i = 1:n
  

        converge =false;
        converge_time=inf;

        for time = 1:time_split-20
            
            velocity_window = std(velocity(i,time:time+20));
            if (velocity_window < threshold) && (converge==false)
                converge = true;
                converge_time = time;

            elseif velocity_window > threshold
                converge = false;
                converge_time = inf;
              
            end
        end
        
        cost=[cost,converge_time]; % store the convergence time for each try
        


    end

end
