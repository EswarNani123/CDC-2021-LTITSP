function [s_d2_time,N] = fun_s_i_s(s_i_c_sorted,n,row_uni_c,s_added)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Finding sets S_{i} %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d2 = 1;
for k=1:n
    i = 1;j=1;d1 = [];
    for l=1:row_uni_c
        if isempty(s_i_c_sorted{l})
            d1_bar(i) = l;
            i = i+1;
        else
            d1(j) = l; % Stores the set number which is non empty
            j = j+1;
        end
    end
    [row_d1,col_d1] = size(d1); % Gives the number of non empty S_i_c
    if col_d1 == 0
        break
    end
    if col_d1 == 1
        s_d2_aux{d2} = s_i_c_sorted{d1}(1,:);
    else
        g = 1;
        d3 = d1(g);
        q = d1(g);
        d4 = d1(g+1);
        z = 1;
        s_d2_aux{d2}(1,1:2) = s_i_c_sorted{d3}(1,1:2); % first point of s_i_c_sorted{d3} is conisdered in
        % s_d2_aux{d2}
        for p=q:col_d1-1
            % following if condition checks assumption (b)
            if ~(s_i_c_sorted{d4}(1,1)+0.5*s_i_c_sorted{d4}(1,2)^2 > s_i_c_sorted{d3}(1,1)+0.5*s_i_c_sorted{d3}(1,2)^2)
                if p <= col_d1-2
                    d3 = d3;
                    d4 = d1(p+2);
                else
                    continue;
                end
            else
                s_d2_aux{d2}(z,1:2) = s_i_c_sorted{d3}(1,1:2);
                if p == col_d1-1
                    s_d2_aux{d2}(z+1,1:2) = s_i_c_sorted{d4}(1,1:2);
                end
                if p <= col_d1-2
                    d3 = d4;
                    d4 = d1(p+2);
                    z = z+1;
                else
                    continue;
                end
            end
        end
    end
    [row_s_d2_aux,~] = size(s_d2_aux{d2}); % size of obatined set s_d2_aux that satify assumption (b)
    if row_s_d2_aux <= 2
        s_d2{d2} = s_d2_aux{d2};
    else
        g = 1;
        d3 = g;
        d4 = g+1;
        d5 = g+2; 
        y = 1;
        s_d2{d2}(1,:) =  s_d2_aux{d2}(d3,1:2);
        s_d2{d2}(2,:) =  s_d2_aux{d2}(d4,1:2);
        for i=1:row_s_d2_aux-2
            if d4 <= row_s_d2_aux-2
                % Following if condition check assumption (c)
            if ~(6*s_d2_aux{d2}(d4,2)+sqrt(4*(s_d2_aux{d2}(d5,1)-s_d2_aux{d2}(d3,1))+2*(s_d2_aux{d2}(d3,2)^2+s_d2_aux{d2}(d5,2)^2))...
                    >sqrt(4*(s_d2_aux{d2}(d3,1)-s_d2_aux{d2}(d4,1))+2*(s_d2_aux{d2}(d3,2)^2+s_d2_aux{d2}(d4,2)^2))...
                    +sqrt(4*(s_d2_aux{d2}(d4,1)-s_d2_aux{d2}(d5,1))+2*(s_d2_aux{d2}(d4,2)^2+s_d2_aux{d2}(d5,2)^2)))
                d3 = d3;
                d4 = i+2;
                d5 = i+3;
                imp_vec = [];
            else
                s_d2{d2}(y,:) =  s_d2_aux{d2}(d3,1:2); % Forming the s_d2 using the points 
                % that satisfy assumption (c)
                s_d2{d2}(y+1,:) =  s_d2_aux{d2}(d4,1:2);
                imp_vec = s_d2_aux{d2}(d5,1:2);
                y = y+1;
                d3 = d4;
                d4 = i+2;
                d5 = i+3;
            end
            if ~isempty(imp_vec)
            s_d2{d2}(y+1,:) =  imp_vec;
            end
            else
                break
            end
        end
    end
    % following loop removes the points in s_d2 from s_i_c_sorted{i}
    for i=1:row_uni_c 
        if ~isempty(s_i_c_sorted{i}) 
        s_i_c_sorted{i} = setdiff(s_i_c_sorted{i},s_d2{d2},'rows');
        s_i_c_sorted{i} = sortrows(s_i_c_sorted{i},2,'descend');
        else
            continue;
        end
    end
    d2 = d2+1;
end
N = d2-1; % No of S_{i}
% Next, we make points in S_{i} as pairs
for i=1:N
    [row_s_d2_i(i),col_s_d2_i(i)] = size(s_d2{i});
    d6 = row_s_d2_i(i);
    for j=1:row_s_d2_i(i)
        s_d2{i}(d6+1,1) = s_d2{i}(j,1); % Adding a point with same position and velocity of opposite sign
        s_d2{i}(d6+1,2) = -s_d2{i}(j,2);
        d6 = d6+1;
    end
end
% In the following code, we remove the points in s_{i} that have been added
for i=1:N
    s_d2{i} = setdiff(s_d2{i},s_added,'rows'); % Returns the points of s_{i} that are not in s_added 
end
% Following codes gives the time optimal tour sequences of s_{i}
for i=1:N
    s_non_neg = s_d2{i}(s_d2{i}(:,2)>=0,:);
    s_non_neg = sortrows(s_non_neg,1,'ascend');
    s_neg = s_d2{i}(s_d2{i}(:,2)<0,:);
    s_neg = sortrows(s_neg,1,'descend');
    s_d2_time{i} = cat(1,s_non_neg,s_neg); % Concatenates two sets along rows
end
for i=1:N
    [row_s_d2_time(i),col_s_d2_time(i)] = size(s_d2_time{i});
    s_d2_time{i}(row_s_d2_time(i)+1,:) = s_d2_time{i}(1,:); % Adding the first point of s_d2_time{i} 
    %at last to make it a tour sequence
end