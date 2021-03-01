function [TourSeq,TourTime, ElapsedTime] = LKH(s,n)
% Following code creates .atsp file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str1 = ['NAME: ' 'n' num2str(n)];
str2 = 'TYPE: ATSP'; % Change ATSP to any other thing depending on requirement. For more details, look at
% http://akira.ruc.dk/~keld/research/LKH/
str3 = ['DIMENSION: ' num2str(n)];
str4 = 'EDGE_WEIGHT_TYPE: EXPLICIT';
str5 = 'EDGE_WEIGHT_FORMAT: FULL_MATRIX' ;
str6 = 'EDGE_WEIGHT_SECTION';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
for z_i = 1:n
    for z_j = 1:n
        if z_i ~= z_j
            cost(z_i,z_j) = cost_point_point(s(z_i,:),s(z_j,:))*10000; % Calling the function cost_point_point
            % to find out the point to point time. Multiplying the
            % point to point time with 10000 to round the obtained time
            % to four decimal places
        end
    end
end
cost = round(cost); % Round the number to nearest integer
aux_1 = max(cost,[],'all'); % Finding the maximum entry of cost matrix
for z_k = 1:n
    cost(z_k,z_k) = aux_1+10000; % Makes the digonal elements of cost matrix too large
end
t1 = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of creating cost matrix
aux_2 = {str1;str2;str3;str4;str5;str6;cost}; % Create cell array using previouly defined strings and cost matrix
filename1 = ['n' num2str(n) '.txt']; % Creating a file name that changes every iteration
filename1_tour = ['n' num2str(n) '_tour' '.txt'];
fileID_1 = fopen(filename1,'w'); % Creates a text file that can be accessed using file ID fileID_1
fprintf(fileID_1,'%s\n',aux_2{1:6}); % Writes the data in cells 1 to 6 to a text file
% Following for loop writes the cost matrix to the end of text file
% with file ID fileID_1
for k = 1:n 
    fprintf(fileID_1,'%.0f\t',aux_2{7}(k,1:n));
    fprintf(fileID_1,'\n');
end
fclose(fileID_1); % Closes the text file created
% Following code creates .atsp file out of .txt file
filename2=strrep(filename1,'.txt','.atsp');
copyfile(filename1,filename2) % Copy the contents of filename1 to filename2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of creating .atsp file
% Following code creates .par file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str7 = ['PROBLEM_FILE = ' filename2];
str8 = 'RUNS = 10';
str9 = ['TOUR_FILE = ' filename1_tour]; % Tour sequence is written to a text file named filename1_tour
fileID_2 = fopen(filename1,'w'); % Creates a text file that can be accessed using file ID fileID_2
fprintf(fileID_2,'%s\n',str7,str8,str9); % Writes the str7 and str8 to a text file
fclose(fileID_2); % Closes the text file created
% Following code creates .par file out of .txt file
filename3=strrep(filename1,'.txt','.par');
copyfile(filename1,filename3) % Copy the contents of filename1 to filename3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of creating .par file
delete(filename1) % Deletes created text files which are not required
fileID_3 = fopen(filename1_tour,'w+');
[~,cmdout] = system(['LKH-2' ' ' filename3]); % LKH-2 takes .par file as input and outputs 
% tour cost and related information on command window 
TourTime = cellfun(@str2double,regexp(cmdout,'Cost\.avg = (\d+\.\d+)','tokens'))/10000;
t2 = cellfun(@str2double,regexp(cmdout,'Time\.avg = (\d+\.\d+)','tokens'));
ElapsedTime = t1+t2;
tour_seq_cell = textscan(fileID_3, '%d', 'MultipleDelimsAsOne',true, 'Delimiter','\n', 'HeaderLines',6);
% Tour sequence is extracted to tour_seq_cell from a text file with
% name filename1_tour
fclose(fileID_3);
tour_seq_mat = cell2mat(tour_seq_cell); % Converts from cell to matrix
[row_tour_seq_mat,~] = size(tour_seq_mat);
TourSeq = [tour_seq_mat(1:row_tour_seq_mat-1);1]; % Desired tour sequence
delete(filename1_tour) % Deletes text file containg tour sequence
delete(filename2) % Deletes .atsp file
delete(filename3) % Deletes .par file