function total_time = func_total_time(s_final)
% s_final gives the tour sequence to connect all pints. Time taken
% to visit all the points is calculated using the following code.
[row_s_final_upd,~] = size(s_final);
total_time = 0;
for y_i = 1:(row_s_final_upd-1)
    if (s_final(y_i+1,1) == 0) && (s_final(y_i+1,2) == 0)
        if s_final(y_i,1) < -0.5*s_final(y_i,2)*abs(s_final(y_i,2))
            t_point_to_point = -s_final(y_i,2)+sqrt(-4*s_final(y_i,1)+2*s_final(y_i,2)^2);
        end
        if s_final(y_i,1) > -0.5*s_final(y_i,2)*abs(s_final(y_i,2))
            t_point_to_point = s_final(y_i,2)+sqrt(4*s_final(y_i,1)+2*s_final(y_i,2)^2);
        end
        if s_final(y_i,1) == -0.5*s_final(y_i,2)*abs(s_final(y_i,2))
            t_point_to_point = abs(s_final(y_i,2));
        end
    else
        if s_final(y_i,1)-s_final(y_i+1,1) < -0.5*abs(s_final(y_i,2)^2-s_final(y_i+1,2)^2)
            t_point_to_point = sqrt(4*(s_final(y_i+1,1)-s_final(y_i,1))+2*(s_final(y_i,2)^2+s_final(y_i+1,2)^2))-(s_final(y_i+1,2)+s_final(y_i,2));
        end
        if s_final(y_i,1)-s_final(y_i+1,1) > -0.5*abs(s_final(y_i,2)^2-s_final(y_i+1,2)^2)
            t_point_to_point = sqrt(4*(s_final(y_i,1)-s_final(y_i+1,1))+2*(s_final(y_i,2)^2+s_final(y_i+1,2)^2))+(s_final(y_i+1,2)+s_final(y_i,2));
        end
        if s_final(y_i,1)-s_final(y_i+1,1) == -0.5*abs(s_final(y_i,2)^2-s_final(y_i+1,2)^2)
            t_point_to_point = abs(s_final(y_i+1,2)-s_final(y_i,2));
        end
    end
    total_time = total_time+t_point_to_point; % At last, total_time gives the time to visit all the points 
end