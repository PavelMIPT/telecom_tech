% Clear workspace. Clear command window. Close all figure
clear all; clc; close all;
%% task
% 0) Create a function
% 1) Create the random matrix
% 2) Analyse the code. Insert the calculation of runtime of code
% 3) rewrite the code in more optimised form in matlab
% 4) Provide the evidence that results matrix and legacy matrix is the same
% 5) calculate the runtime of new code. Compare it with legacy code. Make
% an conclusion about code. Which one is the more optimised? Which code do
% you suggest to use in matlab? And why?
%% Config the system

% Fixed random generator
rng(101);
% TO-DO 1%
% Create function, which generate 
% create Input_Matrix matrix 420-to-480 size and
% with normal distributed numbers from -200 to 20
%    
Input_Matrix = Matrix_generator();
  
Legacy_Matrix = Input_Matrix;
Ethalon_Matrix = Input_Matrix;
%% Run legacy code
% TO-DO 2
% Measure the runtime of current function
n = 50;  % number of times we will record
Data_time = cell(n, 2);

for i = 1:n
    tic
    Legacy_output_Matrix = Legacy_Instruction(Input_Matrix);
    time_legacy = toc;
    % write time_data about Legacy_Instruction to a Matrix
    Data_time{i, 1} = time_legacy;
end
% Save the runtime in variable
% Time_legacy_code = TIME;

%% Run optimised code
% TO-DO 3
% Measure the runtime of your function
% Create function New_Instruction()
% Rewrite and optimised function Legacy_Instruction()
% Use matrix operation, logical indexing
% Try not to use the cycle
for i = 1:n
    tic
    Optimised_Output_Matrix = New_Instruction(Input_Matrix);
    time_optimise = toc;
    % write time_data about New_Instruction to a Matrix
    Data_time{i, 2} = time_optimise;
end
% Save the runtime in variable
% Time_Optimised_code = TIME;
    
%% Checking the work of student
% TO-DO 4
% Compare the matrix and elapsed time for instruction
% Matrix must be equal each other, but the runtime sill be different

% Runtime comparison
% Comparison of matrix
% Matrix size and value
s = size(Optimised_Output_Matrix);
if size(Optimised_Output_Matrix) == size(Legacy_output_Matrix)
    T = (Optimised_Output_Matrix == Legacy_output_Matrix);
    if sum(sum(T)) == 201600  % 420 * 480 (sizes of Matrix)
        disp("The matrices have the same sizes and they are equal");
    else
        disp("The matrices have the same sizes, but they are not equal"); 
    end
else
    disp("The matrices are not equal, because they have different sizes");
end

% Conclusion of my work

average_legacy_time = sum(cell2mat(Data_time(:,1))) / n;
average_optimise_time = sum(cell2mat(Data_time(:,2))) / n;

if time_optimise < time_legacy
    fprintf('%s%f%s\r', "Optimise_code works ", time_legacy / time_optimise, " times more than the Legacy_code");
end


%% Function discribing

function Output_Matrix = Legacy_Instruction(Matrix)
   
    for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_rows,8) == 0
                Matrix(itter_rows,itter_column) = 8;
            end
        end
    end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_column,7) ~= 0
                Matrix(itter_rows,itter_column) = Matrix(itter_rows,itter_column) - 25.8;
            end
        end
   end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if Matrix(itter_rows,itter_column) < 0
                Matrix(itter_rows,itter_column) = abs(Matrix(itter_rows,itter_column));
            end
        end
    end

    Output_Matrix = Matrix;
end