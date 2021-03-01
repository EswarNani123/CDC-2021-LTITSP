%n = input('Enter number of points: ');
n_all = 900;
iter = 10;
xmax = 5; % Maximum value of x_{1}
xmin = -5; % Minimum value of x_{1}
ymax = 4; % Maximum value of x_{2}
ymin = -4; % Minimum value of x_{2}
%VarNames = table(["MeanTourTime", "MeanElapsedTime", "MeanSumOpt", "SDTourTime", "SDElapsedTime", ...
 %       "LKHMeanTourTime", "LKHMeanElapsedTime", "LKHSDTourTime", "LKHSDElapsedTime"]);
%writetable(VarNames,'DITSPfoph.xls','WriteMode','append','WriteVariableNames',true,'WriteRowNames',false)
for j = 1:length(n_all)
    n = n_all(j);
    for i = 1:iter
    s = [];
    s(:,1) = xmin+(xmax-xmin)*rand(n,1); % Generating the set s containing points that are distributed according to
    s(:,2) = ymin+(ymax-ymin)*rand(n,1); % uniform probability distribution
% Following code checks that no two points having same c+ or c- value.
% If two points are having same c+ or c- then the program will
% terminate.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     c_plus = s(:,1)-0.5*s(:,2).^2;
%     c_minus = s(:,1)+0.5*s(:,2).^2;
%     c_plus_upd = unique(c_plus); % unique number of c+
%     c_minus_upd = unique(c_minus); % unique number of c-
%     [r_c_plus_upd,~] = size(c_plus_upd);
%     [r_c_minus_upd,~] = size(c_minus_upd);
%     if (r_c_plus_upd ~= n) || (r_c_plus_upd ~= n)
%         quit;
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % End of checking no two points having same c+ or c- value
    [TourTime(i), ElapsedTime(i), SumOptTours(i)] = code_alg(s,n);
    [~,LKHTourTime(i), LKHElapsedTime(i)] = LKH(s,n);
%     [~, TourTime1(i), ElapsedTime1(i), SumOptTours1(i)] = code_alg_mod1(s,n);
%     [~, TourTime2(i), ElapsedTime2(i), SumOptTours2(i)] = code_alg_mod2(s,n);
%     [~,TourTimeLKH(i), ElapsedTimeLKH(i)] = LKH(s,n);
    end
    fop = table([mean(TourTime) mean(ElapsedTime) mean(SumOptTours) std(TourTime) std(ElapsedTime) ...
        mean(LKHTourTime) mean(LKHElapsedTime) std(LKHTourTime) std(LKHElapsedTime)]);
    writetable(fop,'DITSPfoph.xls','WriteMode','append','WriteVariableNames',false,'WriteRowNames',false)
% fopALG1 = [mean(TourTime1) mean(ElapsedTime1) mean(SumOptTours1) std(TourTime1) std(ElapsedTime1)];
% fopALG2 = [mean(TourTime2) mean(ElapsedTime2) mean(SumOptTours2) std(TourTime2) std(ElapsedTime2)];
% fopLKH = [mean(TourTimeLKH) mean(ElapsedTimeLKH) std(TourTimeLKH) std(ElapsedTimeLKH)];
end