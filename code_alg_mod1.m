function [TourSeq, TourTime, ElapsedTime,SumOptTours] = code_alg_mod1(s,n)
tic;
[s_i_c_sorted,n,row_uni_c,s_added] = fun_s_i_c_s(s,n); % This function takes the input as the given set of points
    % and outputs the sets S^{c,sorted}_{i}
[s_d2_time,N] = fun_s_i_s_upd(s_i_c_sorted,n,row_uni_c,s_added); % This function takes the input as the 
    % sets S^{c,sorted}_{i} and output sets s_{i}
for j=1:N
    opt(j) = func_total_time(s_d2_time{j}); % Finds optimal tour time of each set s_{i} for an iteration
end
SumOptTours = sum(opt); % Storing sum of optimal tours during each iterartion
t1 = toc;
tic;
for k=N:-1:2
    TourSeq = [];
    TourTime = [];
    NoOfComb = nchoosek(1:k,2);
    [rowNoOfComb,~] = size(NoOfComb);
    for j=1:rowNoOfComb
        TourSeq{j} = s1s2Interconnect(s_d2_time{NoOfComb(j,1)},s_d2_time{NoOfComb(j,2)});
        TourTime(j) = func_total_time(TourSeq{j});
    end
    [M,idx] = min(TourTime);
    s_d2_time{NoOfComb(idx,1)} = TourSeq{idx};
    s_d2_time(NoOfComb(idx,2)) = [];
end
t2 = toc;
ElapsedTime = t1+t2; % Total elapsed time to execute actual algorithm
TourTime = M;
end 