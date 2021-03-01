function [s_i_c_sorted,n,row_uni_c,s_added] = fun_s_i_c_s(s,n)
s = unique(s,'rows'); % The set s can have repeated points. So, this command removes
% repeated points 
[row_s,~] = size(s); % Obtaining size of s
%%%%%%%%%% We form pairs of points for the given set of points in the
%%%%%%%%%% following code
m = row_s; % no of rows of s which indicates the number of points
% Following code checks for pairs of points if a point is not pair, we add
% a new point to make it pair
for i = 1:row_s
    for j = 1:row_s
        if i ~= j
        if s(i,1)==s(j,1) && s(i,2)==-s(j,2)
            dummy_1 = 0;
            break;
        else
            dummy_1 = 1;
        end
        else
            continue;
        end
    end
    if dummy_1 == 1
        s(m+1,1) = s(i,1);
        s(m+1,2) = -s(i,2);
        m = m+1;
    end
end
[row_s_after_add,~] = size(s); % Finding size of s after adding points to make pairs
s_added = s(row_s+1:row_s_after_add,:); % Extracting out added points to the set s 
% Now, set s has pairs of points. 
% In the following code, we find the set S_{+} such that all the points in
% the set has nonnegative velocity
s_plus = s(s(:,2)>=0,:);
% u = 1;
% for i=1:m
% if s(i,2) >= 0
%     s_plus(u,1) = s(i,1);
%     s_plus(u,2) = s(i,2);
%     u = u+1;
% else
%     continue;
% end
% end
% In the obatined set s_plus there may be repeated points. This is becuase
% if a point is having zero velocity then we added the same point to make it
% a pair. Hence, these two points appear in s_plus. So, we remove the
% repeated points using below code
s_plus_uni = unique(s_plus,'rows'); % Non repeeating set of points of s_{+}
[sz_r_s_plus,~] = size(s_plus_uni); % Finding size of s_{+}
% Find c^{+}_{x_{i}} for all points s_plus_uni and add as third coordinate to each point
% of s_plus_uni
 for i=1:sz_r_s_plus
    s_plus_uni(i,3) = s_plus_uni(i,1)-0.5*s_plus_uni(i,2)^2; 
 end
s_plus_uni = sortrows(s_plus_uni,3,'ascend'); % Sort points bases on value of c_{+}
uni_c = s_plus_uni(:,3); % finding unique c^{+}_{x_{i}}
[row_uni_c,~] = size(uni_c); % row_uni_c gives the unique number of c^{+}_{x_{i}}
% Following for loop groups the points with same c^{+}_{x_{i}} value.
% s_i_c{i} contains all the points with same c^{+}_{x_{i}}
for i=1:row_uni_c
    s_i_c{i}(:,1) = s_plus_uni(s_plus_uni(:,3)==uni_c(i),1);
    s_i_c{i}(:,2) = s_plus_uni(s_plus_uni(:,3)==uni_c(i),2);
   % s_i_c{i}(:,3) = s_plus_uni(s_plus_uni(:,3)==uni_c(i),3);
end
for i=1:row_uni_c
    s_i_c_sorted{i} = sortrows(s_i_c{i},2,'descend'); % Sort elements of s_i_c{i} on descending 
    %order of its velocity
end