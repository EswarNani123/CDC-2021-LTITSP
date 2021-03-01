function s_final = func_s_fin(s_d2_time,N)
% In the following code, we connect all the sets s_d2_time{i}
s_final = s_d2_time{1}; % Initilaization of set s_final
for z_i=1:N-1 % N is the number of sets s_{i}
    d7 = Inf;
    d8 = Inf;
    [row_s_d2_time_up,~] = size(s_d2_time{z_i+1}); % Finding size of s_d2_time{z_i+1}
    [row_s_final,~] = size(s_final); % This changes for every loop
    if (row_s_final == 2) && (row_s_d2_time_up == 2)
        s_final_1 = s_final(1,:);
        s_final_2 = s_final(2,:);
        s_final_3  = cat(1,s_final_1,s_d2_time{z_i+1}(1,:));
        s_final = [];
        s_final = cat(1,s_final_3,s_final_2); % At last, s_final gives a tour sequence that 
        %connects all the points
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (row_s_final > 2) && (row_s_d2_time_up == 2)
        for z_j = 1:(row_s_final-1)
            % t1 = Time to move from j the point of s_final to k+1 th
            % point of s_d2_time{i+1}
            % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
            % point of s_final
            if s_final(z_j,1)-s_d2_time{z_i+1}(1,1) < -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(1,2))*(s_d2_time{z_i+1}(1,2)+s_final(z_j,2))
                t1 = sqrt(4*(s_d2_time{z_i+1}(1,1)-s_final(z_j,1))+2*(s_final(z_j,2)^2+s_d2_time{z_i+1}(1,2)^2))-(s_final(z_j,2)+s_d2_time{z_i+1}(1,2));
            end
            if s_final(z_j,1)-s_d2_time{z_i+1}(1,1) > -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(1,2))*(s_d2_time{z_i+1}(1,2)+s_final(z_j,2))
                t1 = sqrt(4*(s_final(z_j,1)-s_d2_time{z_i+1}(1,1))+2*(s_final(z_j,2)^2+s_d2_time{z_i+1}(1,2)^2))+(s_final(z_j,2)+s_d2_time{z_i+1}(1,2));
            end
            if s_final(z_j,1)-s_d2_time{z_i+1}(1,1) == -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(1,2))*(s_d2_time{z_i+1}(1,2)+s_final(z_j,2))
                t1 = abs(s_d2_time{z_i+1}(1,2)-s_final(z_j,2));
            end
            if s_d2_time{z_i+1}(1,1)-s_final(z_j+1,1) < -0.5*abs(s_d2_time{z_i+1}(1,2)-s_final(z_j+1,2))*(s_final(z_j+1,2)+s_d2_time{z_i+1}(1,2))
                t2 = sqrt(4*(s_final(z_j+1,1)-s_d2_time{z_i+1}(1,1))+2*(s_d2_time{z_i+1}(1,2)^2+s_final(z_j+1,2)^2))-(s_final(z_j+1,2)+s_d2_time{z_i+1}(1,2));
            end
            if s_d2_time{z_i+1}(1,1)-s_final(z_j+1,1) > -0.5*abs(s_d2_time{z_i+1}(1,2)-s_final(z_j+1,2))*(s_final(z_j+1,2)+s_d2_time{z_i+1}(1,2))
                t2 = sqrt(4*(s_d2_time{z_i+1}(1,1)-s_final(z_j+1,1))+2*(s_d2_time{z_i+1}(1,2)^2+s_final(z_j+1,2)^2))+(s_final(z_j+1,2)+s_d2_time{z_i+1}(1,2));
            end
            if s_d2_time{z_i+1}(1,1)-s_final(z_j+1,1) == -0.5*abs(s_d2_time{z_i+1}(1,2)-s_final(z_j+1,2))*(s_final(z_j+1,2)+s_d2_time{z_i+1}(1,2))
                t2 = abs(s_final(z_j+1,2)-s_d2_time{z_i+1}(1,2));
            end
            if t1+t2 <= d7
                loc_s_final_upd = [z_j z_j+1];
                d7 = t1+t2; 
            end
        end
        s_final_1 = s_final(1:loc_s_final_upd(1),:);
        s_final_2 = s_final(loc_s_final_upd(2):row_s_final,:);
        s_final_3 = cat(1,s_final_1,s_d2_time{z_i+1}(1,:));
        s_final = [];
        s_final = cat(1,s_final_3,s_final_2);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (row_s_final == 2) && (row_s_d2_time_up > 2)
        for z_k = 1:(row_s_d2_time_up-1)
                    % t1 = Time to move from j the point of s_final to k+1 th
                    % point of s_d2_time{i+1}
                    % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
                    % point of s_final
                    if s_final(1,1)-s_d2_time{z_i+1}(z_k+1,1) < -0.5*abs(s_final(1,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_d2_time{z_i+1}(z_k+1,2)+s_final(1,2))
                        t1 = sqrt(4*(s_d2_time{z_i+1}(z_k+1,1)-s_final(1,1))+2*(s_final(1,2)^2+s_d2_time{z_i+1}(z_k+1,2)^2))-(s_final(1,2)+s_d2_time{z_i+1}(z_k+1,2));
                    end
                    if s_final(1,1)-s_d2_time{z_i+1}(z_k+1,1) > -0.5*abs(s_final(1,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_d2_time{z_i+1}(z_k+1,2)+s_final(1,2))
                        t1 = sqrt(4*(s_final(1,1)-s_d2_time{z_i+1}(z_k+1,1))+2*(s_final(1,2)^2+s_d2_time{z_i+1}(z_k+1,2)^2))+(s_final(1,2)+s_d2_time{z_i+1}(z_k+1,2));
                    end
                    if s_final(1,1)-s_d2_time{z_i+1}(z_k+1,1) == -0.5*abs(s_final(1,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_d2_time{z_i+1}(z_k+1,2)+s_final(1,2))
                        t1 = abs(s_d2_time{z_i+1}(z_k+1,2)-s_final(1,2));
                    end
                    if s_d2_time{z_i+1}(z_k,1)-s_final(1,1) < -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(1,2))*(s_final(1,2)+s_d2_time{z_i+1}(z_k,2))
                        t2 = sqrt(4*(s_final(1,1)-s_d2_time{z_i+1}(z_k,1))+2*(s_d2_time{z_i+1}(z_k,2)^2+s_final(1,2)^2))-(s_final(1,2)+s_d2_time{z_i+1}(z_k,2));
                    end
                    if s_d2_time{z_i+1}(z_k,1)-s_final(1,1) > -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(1,2))*(s_final(1,2)+s_d2_time{z_i+1}(z_k,2))
                        t2 = sqrt(4*(s_d2_time{z_i+1}(z_k,1)-s_final(1,1))+2*(s_d2_time{z_i+1}(z_k,2)^2+s_final(1,2)^2))+(s_final(1,2)+s_d2_time{z_i+1}(z_k,2));
                    end
                    if s_d2_time{z_i+1}(z_k,1)-s_final(1,1) == -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(1,2))*(s_final(1,2)+s_d2_time{z_i+1}(z_k,2))
                        t2 = abs(s_final(1,2)-s_d2_time{z_i+1}(z_k,2));
                    end
                if t1+t2 <= d7
                    loc_s_d2_time_upd = [z_k z_k+1];
                    d7 = t1+t2; 
                end
        end
        s_final_1 = s_d2_time{z_i+1}(1:loc_s_d2_time_upd(1),:);
        s_final_2 = s_d2_time{z_i+1}(loc_s_d2_time_upd(2):row_s_d2_time_up,:);
        s_final_3 = cat(1,s_final_1,s_final(1,:));
        s_final = [];
        s_final = cat(1,s_final_3,s_final_2);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (row_s_final > 2) && (row_s_d2_time_up > 2)
        for z_j = 1:(row_s_final-1)
            for z_k = 1:(row_s_d2_time_up-1)
                % t1 = Time to move from j the point of s_final to k+1 th
                % point of s_d2_time{i+1}
                % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
                % point of s_final
                if s_final(z_j,1)-s_d2_time{z_i+1}(z_k+1,1) < -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_final(z_j,2)+s_d2_time{z_i+1}(z_k+1,2))
                        t1 = sqrt(4*(s_d2_time{z_i+1}(z_k+1,1)-s_final(z_j,1))+2*(s_final(z_j,2)^2+s_d2_time{z_i+1}(z_k+1,2)^2))-(s_final(z_j,2)+s_d2_time{z_i+1}(z_k+1,2));
                end
                if s_final(z_j,1)-s_d2_time{z_i+1}(z_k+1,1) > -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_final(z_j,2)+s_d2_time{z_i+1}(z_k+1,2))
                        t1 = sqrt(4*(s_final(z_j,1)-s_d2_time{z_i+1}(z_k+1,1))+2*(s_final(z_j,2)^2+s_d2_time{z_i+1}(z_k+1,2)^2))+(s_final(z_j,2)+s_d2_time{z_i+1}(z_k+1,2));
                end
                if s_final(z_j,1)-s_d2_time{z_i+1}(z_k+1,1) == -0.5*abs(s_final(z_j,2)-s_d2_time{z_i+1}(z_k+1,2))*(s_final(z_j,2)+s_d2_time{z_i+1}(z_k+1,2))
                        t1 = abs(s_d2_time{z_i+1}(z_k+1,2)-s_final(z_j,2));
                end
                if s_d2_time{z_i+1}(z_k,1)-s_final(z_j+1,1) < -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))*(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))
                        t2 = sqrt(4*(s_final(z_j+1,1)-s_d2_time{z_i+1}(z_k,1))+2*(s_d2_time{z_i+1}(z_k,2)^2+s_final(z_j+1,2)^2))-(s_final(z_j+1,2)+s_d2_time{z_i+1}(z_k,2));
                end
                if s_d2_time{z_i+1}(z_k,1)-s_final(z_j+1,1) > -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))*(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))
                        t2 = sqrt(4*(s_d2_time{z_i+1}(z_k,1)-s_final(z_j+1,1))+2*(s_d2_time{z_i+1}(z_k,2)^2+s_final(z_j+1,2)^2))+(s_final(z_j+1,2)+s_d2_time{z_i+1}(z_k,2));
                end
                if s_d2_time{z_i+1}(z_k,1)-s_final(z_j+1,1) == -0.5*abs(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))*(s_d2_time{z_i+1}(z_k,2)-s_final(z_j+1,2))
                        t2 = abs(s_final(z_j+1,2)-s_d2_time{z_i+1}(z_k,2));
                end
                if t1+t2 <= d7
                    loc_s_final = [z_j z_j+1];
                    loc_s_d2_time = [z_k z_k+1];
                    d7 = t1+t2; 
                end
            end
            if d7 <= d8
                loc_s_final_upd = loc_s_final;
                loc_s_d2_time_upd = loc_s_d2_time;
                d8 = d7; 
            end
        end
        s_final_1 = s_final(1:loc_s_final_upd(1),:);
        s_final_2 = s_final(loc_s_final_upd(2):row_s_final,:);
        s_final_3 = s_d2_time{z_i+1}(1:loc_s_d2_time_upd(1),:);
        s_final_4 = s_d2_time{z_i+1}(loc_s_d2_time_upd(2):row_s_d2_time_up-1,:);
        s_final_5 = cat(1,s_final_1,s_final_4);
        s_final_6 = cat(1,s_final_5,s_final_3);
        s_final = [];
        s_final = cat(1,s_final_6,s_final_2);
    end
end