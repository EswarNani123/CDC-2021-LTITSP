function s = s1s2Interconnect(s1,s2)
d1 = Inf;
d2 = Inf;
[row_s2,~] = size(s2); % Finding size of s2
[row_s1,~] = size(s1); % This changes for every loop
if (row_s1 == 2) && (row_s2 == 2)
    s11 = s1(1,:);
    s12 = s1(2,:);
    s13  = cat(1,s11,s2(1,:));
    s = cat(1,s13,s12); % At last, s1 gives a tour sequence that 
        %connects all the points
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (row_s1 > 2) && (row_s2 == 2)
        for i = 1:(row_s1-1)
            % t1 = Time to move from j the point of s1 to k+1 th
            % point of s_d2_time{i+1}
            % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
            % point of s1
            if s1(i,1)-s2(1,1) < -0.5*abs(s1(i,2)-s2(1,2))*(s2(1,2)+s1(i,2))
                t1 = sqrt(4*(s2(1,1)-s1(i,1))+2*(s1(i,2)^2+s2(1,2)^2))-(s1(i,2)+s2(1,2));
            end
            if s1(i,1)-s2(1,1) > -0.5*abs(s1(i,2)-s2(1,2))*(s2(1,2)+s1(i,2))
                t1 = sqrt(4*(s1(i,1)-s2(1,1))+2*(s1(i,2)^2+s2(1,2)^2))+(s1(i,2)+s2(1,2));
            end
            if s1(i,1)-s2(1,1) == -0.5*abs(s1(i,2)-s2(1,2))*(s2(1,2)+s1(i,2))
                t1 = abs(s2(1,2)-s1(i,2));
            end
            if s2(1,1)-s1(i+1,1) < -0.5*abs(s2(1,2)-s1(i+1,2))*(s1(i+1,2)+s2(1,2))
                t2 = sqrt(4*(s1(i+1,1)-s2(1,1))+2*(s2(1,2)^2+s1(i+1,2)^2))-(s1(i+1,2)+s2(1,2));
            end
            if s2(1,1)-s1(i+1,1) > -0.5*abs(s2(1,2)-s1(i+1,2))*(s1(i+1,2)+s2(1,2))
                t2 = sqrt(4*(s2(1,1)-s1(i+1,1))+2*(s2(1,2)^2+s1(i+1,2)^2))+(s1(i+1,2)+s2(1,2));
            end
            if s2(1,1)-s1(i+1,1) == -0.5*abs(s2(1,2)-s1(i+1,2))*(s1(i+1,2)+s2(1,2))
                t2 = abs(s1(i+1,2)-s2(1,2));
            end
            if t1+t2 <= d1
                loc_s1_upd = [i i+1];
                d1 = t1+t2; 
            end
        end
        s11 = s1(1:loc_s1_upd(1),:);
        s12 = s1(loc_s1_upd(2):row_s1,:);
        s13 = cat(1,s11,s2(1,:));
        s = cat(1,s13,s12);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (row_s1 == 2) && (row_s2 > 2)
    for i = 1:(row_s2-1)
        % t1 = Time to move from j the point of s1 to k+1 th
        % point of s_d2_time{i+1}
        % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
        % point of s1
        if s1(1,1)-s2(i+1,1) < -0.5*abs(s1(1,2)-s2(i+1,2))*(s2(i+1,2)+s1(1,2))
            t1 = sqrt(4*(s2(i+1,1)-s1(1,1))+2*(s1(1,2)^2+s2(i+1,2)^2))-(s1(1,2)+s2(i+1,2));
        end
        if s1(1,1)-s2(i+1,1) > -0.5*abs(s1(1,2)-s2(i+1,2))*(s2(i+1,2)+s1(1,2))
            t1 = sqrt(4*(s1(1,1)-s2(i+1,1))+2*(s1(1,2)^2+s2(i+1,2)^2))+(s1(1,2)+s2(i+1,2));
        end
        if s1(1,1)-s2(i+1,1) == -0.5*abs(s1(1,2)-s2(i+1,2))*(s2(i+1,2)+s1(1,2))
            t1 = abs(s2(i+1,2)-s1(1,2));
        end
        if s2(i,1)-s1(1,1) < -0.5*abs(s2(i,2)-s1(1,2))*(s1(1,2)+s2(i,2))
            t2 = sqrt(4*(s1(1,1)-s2(i,1))+2*(s2(i,2)^2+s1(1,2)^2))-(s1(1,2)+s2(i,2));
        end
        if s2(i,1)-s1(1,1) > -0.5*abs(s2(i,2)-s1(1,2))*(s1(1,2)+s2(i,2))
            t2 = sqrt(4*(s2(i,1)-s1(1,1))+2*(s2(i,2)^2+s1(1,2)^2))+(s1(1,2)+s2(i,2));
        end
        if s2(i,1)-s1(1,1) == -0.5*abs(s2(i,2)-s1(1,2))*(s1(1,2)+s2(i,2))
            t2 = abs(s1(1,2)-s2(i,2));
        end
        if t1+t2 <= d1
            loc_s2 = [i i+1];
            d1 = t1+t2; 
        end
    end
    s11 = s2(1:loc_s2(1),:);
    s12 = s2(loc_s2(2):row_s2,:);
    s13 = cat(1,s11,s1(1,:));
    s = cat(1,s13,s12);
end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (row_s1 > 2) && (row_s2 > 2)
    for i = 1:(row_s1-1)
        for j = 1:(row_s2-1)
            % t1 = Time to move from j the point of s1 to k+1 th
            % point of s_d2_time{i+1}
            % t2 = Time to move from k the point of s_d2_time{i+1} to j+1 th
            % point of s1
            if s1(i,1)-s2(j+1,1) < -0.5*abs(s1(i,2)-s2(j+1,2))*(s1(i,2)+s2(j+1,2))
                t1 = sqrt(4*(s2(j+1,1)-s1(i,1))+2*(s1(i,2)^2+s2(j+1,2)^2))-(s1(i,2)+s2(j+1,2));
            end
            if s1(i,1)-s2(j+1,1) > -0.5*abs(s1(i,2)-s2(j+1,2))*(s1(i,2)+s2(j+1,2))
                t1 = sqrt(4*(s1(i,1)-s2(j+1,1))+2*(s1(i,2)^2+s2(j+1,2)^2))+(s1(i,2)+s2(j+1,2));
            end
            if s1(i,1)-s2(j+1,1) == -0.5*abs(s1(i,2)-s2(j+1,2))*(s1(i,2)+s2(j+1,2))
                t1 = abs(s2(j+1,2)-s1(i,2));
            end
            if s2(j,1)-s1(i+1,1) < -0.5*abs(s2(j,2)-s1(i+1,2))*(s2(j,2)-s1(i+1,2))
                t2 = sqrt(4*(s1(i+1,1)-s2(j,1))+2*(s2(j,2)^2+s1(i+1,2)^2))-(s1(i+1,2)+s2(j,2));
            end
            if s2(j,1)-s1(i+1,1) > -0.5*abs(s2(j,2)-s1(i+1,2))*(s2(j,2)-s1(i+1,2))
                t2 = sqrt(4*(s2(j,1)-s1(i+1,1))+2*(s2(j,2)^2+s1(i+1,2)^2))+(s1(i+1,2)+s2(j,2));
            end
            if s2(j,1)-s1(i+1,1) == -0.5*abs(s2(j,2)-s1(i+1,2))*(s2(j,2)-s1(i+1,2))
                t2 = abs(s1(i+1,2)-s2(j,2));
            end
            if t1+t2 <= d1
                loc_s1 = [i i+1];
                loc_s2 = [j j+1];
                d1 = t1+t2; 
            end
        end
        if d1 <= d2
            loc_s1_upd = loc_s1;
            loc_s2_upd = loc_s2;
            d2 = d1; 
        end
    end
    s11 = s1(1:loc_s1_upd(1),:);
    s12 = s1(loc_s1_upd(2):row_s1,:);
    s13 = s2(1:loc_s2_upd(1),:);
    s14 = s2(loc_s2_upd(2):row_s2-1,:);
    s15 = cat(1,s11,s14);
    s16 = cat(1,s15,s13);
    s = cat(1,s16,s12);
end