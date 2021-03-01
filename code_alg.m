function [TourTime, ElapsedTime, SumOptTime] = code_alg(s,n)   
SumOptTime = 0;
tic;
    [s_i_c_sorted,n,row_uni_c,s_added] = fun_s_i_c_s(s,n); % This function takes the input as the given set of points
    % and outputs the sets S^{c,sorted}_{i}
    [s_d2_time,N] = fun_s_i_s(s_i_c_sorted,n,row_uni_c,s_added); % This function takes the input as the 
    % sets S^{c,sorted}_{i} and output sets s_{i}
    s_final = func_s_fin(s_d2_time,N); % This function takes the input as the sets s_{i} and output a tour 
    % sequence that connects all the given set of points
    TourTime = func_total_time(s_final); % This function takes the input as a tour 
    % sequence that connects all the given set of points and output the time
    % taken for visting the given set of points
    ElapsedTime = toc;
    for i=1:length(s_d2_time)
        SumOptTime = SumOptTime+func_total_time(s_d2_time{i});
    end