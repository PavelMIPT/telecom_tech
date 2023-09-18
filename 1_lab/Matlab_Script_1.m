%% start main script

clc; % clear screen / clear command window
clear all; % clear ALL workspace / 


%% Slide Numerical. Integer

var_numerical = 5; % variable assignment
clear var_numerical; % clear var "var_numerical_default"
var_numerical = -256; % variable assignment and display it in command window
var_int8 = int8(var_numerical);
var_int16 = int16(var_numerical);
var_int32 = int32(var_numerical);
var_int64 = int64(var_numerical);

%% Slide  Numerical Unsigned Integer

var_unsigned_int8 = uint8(var_numerical);
clear var_unsigned_int8;

var_unsigned_int8 = uint8(512);
var_unsigned_int16 = uint16(512);
var_unsigned_int32 = uint32(512);
var_unsigned_int64 = uint64(512);

%% Slide  Double
clear all;

var_double = 5; % default type of data - double
clear var_double; 
var_double = -256; % double has a sign
clear var_double;
var_double = 1.3e-3;
clear var_double;
var_double = 0.5;
clear var_double;
var_double = 1/3; % Irrational type of data

%% Slide  char and string
clear all;

char_1 = 'a';
char_2 = 'b';
char_3 = 'cd';
char_1_2 = char_1+char_2;

%error

string_1 = "cd";
string_2 = char_1 + string_1 + char_2;


%% Slide  cell 
newcell = cell(2, 2); %% можно написать просто cell(2), если число столбцов и строк одинаково
newcell{1, 1} = 1;
newcell{1, 2} = char_1;
newcell{2, 1} = cell(2,1);
newcell{2, 2} = [1, 2; 3, 4];
newcell{1, 2}
nc = zeros(10);
for i = 1 : 10
    for j = 1 : 10
        nc{i, j} = 4;
    end
end
%% Slide  struct  
clear all;
new_struct = struct('a', [1, 2, 3], 'b', {'x', 'y'});




%% Slide 12 table  
clear all;
new_table = table(5,6,7,7,9);
new_table.Var1 = 7;


%% Slide  Logical + logical operation
clc;
clear all;
Logical_true = true;
Logical_false = false;

Logical_states = [true false];

% Logical = true;
Logical = false;

if Logical == true
    disp('Yes');
else
    disp('No');
end

clear Logical;

% Logical = true;
% Logical = false;
% Logical = 255;
Logical = false;

switch Logical
    case true
        disp ("Switch - Logical YES");
    case false
        disp ("Switch - Logical NO");
    case 255
        disp ("Switch - Numerical 255");
    otherwise
        disp("Not corrected data");
end
%% slide - round, ceil, floor
clc;
clear all;
new_decimal = 12345.6789;
a = round(new_decimal);
b = ceil(new_decimal);
c = floor(new_decimal);
d = fix(new_decimal);
clear new_decimal a b c d
new_decimal = 12345.1;
a = round(new_decimal);
b = ceil(new_decimal);
c = floor(new_decimal);
d = fix(new_decimal);

%% slides 19-20 logical operators
clc;
clear all;
first_items = [ 0, 0, 1, 1];
second_items = [ 0, 1, 0, 1];
summary_items = and(first_items, second_items);
summary_items
clear summary_items
summary_items = or(first_items, second_items);
summary_items
clear summary_items
summary_items = xor(first_items, second_items);
summary_items
clear summary_items
summary_items = not(first_items);
summary_items

%% Slide complex numbers
clc;
clear all;
% k = 'abc'; 
k = 3 + 4j;
% i = 1;
% complex_number = 1+1i;

l = abs(k);
l = angle(k);
l = conj(k);
l = real(k);
l = imag(k);

%% slide Cycles "for"
clc;
clear all;
counter_1 = 0;

start_itter = 1;
step = 2;
end_itter = 10;

for itter_1 = start_itter : end_itter

    counter_1 = counter_1 + 1;
end

%% slide cycles "while"
clear all;
counter_2 = 0;
itter_2 = 2;

while (itter_2<10)
    counter_2 = counter_2+1;
    itter_2 = itter_2 + 1;
end 

%% Matrix
clc;
clear all;

vector_row = [1, 2, 3];
clear vector_row;
vector_row = [1 2 3];
clear vector_row;

vector_row = [1, -2, 3];
vector_row2 = [1 -2 3];
clear vector_row vector_row2;

vector_colomns = [1; 2; 3];

vector_col_1 = [1; 5; 10];
vector_col_2 = [2; 6; 11];

Matrix = [vector_col_1, vector_col_2];

Matrix_2 = [vector_col_1; vector_col_2];

%% Slide examples of function for matrices
clc;
clear all;

zeros_func_1 = zeros(5);
zeros_func_1_alt(1:5, 1:5) = 0;

test_row = 1:3:11;

zeros_func_2 = zeros(3,4); % matrix 3x4 with zeros

ones_func_1 = ones (5);
ones_func_2 = ones (3,4);
unity_of_matrices = [zeros_func_1, ones_func_1];
unity_of_matrices_new = circshift(unity_of_matrices, [0, 3]);
%% unity_of_matrices_2 = [ones_func_1, ones_func_2]; %% вызовет ошибку, потому что матрицы несоразмерны

%% Slide linspace
clear all;

start_vector = 1;
quantity = 100;
end_vector = 10;

vector_row = linspace(start_vector, end_vector, quantity);
vector_row_alt = start_vector:(end_vector-start_vector)/(quantity-1):end_vector;

test_row = 1:-5:-35;

error_counter = 0;

if length(vector_row) == length(vector_row_alt)
    disp("same length of vectors");
    for itter = 1:length(vector_row)
        if vector_row(itter) ~= vector_row_alt(itter)
            error_counter = error_counter + 1;
        else 
            break;
        end
    end
    error_counter
end
%% Slide Randomly generated matrix

clear all;

Random_matrix_1 = rand(3);
Random_matrix_2 = rand(3,4);

Random_int_matrix_1 = randi(10, 3, 4);
Random_int_matrix_2 = randi([0,1], 1,10);

[Length_matrix, Height_matrix] = size(Random_int_matrix_1)
Maximum_value = max(Random_int_matrix_1(:));
[val, idx] = max(Random_int_matrix_1(:));
clear Length_matrix Height_matrix;
[~, Length_matrix] = size(Random_int_matrix_2);


%% Slide matrix vs for
clear all;

rows = 32*50000;
cols = 32;

a = rand(rows, cols);

% in a loop

d = zeros(size(a));
test_allocation = [];
tic
for i=1:cols
%     test_allocation = [test_allocation, exp(a(:,i))];
   d(:,i) = exp(a(:,i));
end
Time1 = toc

% big matrix
e = zeros(size(a));
tic
e = exp(a);
toc

%% Slide operation with matrix

clear all;

constant = 5.3;
sum = ones(3,3) + zeros(3,3) + constant;
Subtract = sum - ones(3,3);

vectr_row = [1, 2, 3];
vectr_col = vectr_row.';
multiply_vextor_1 = vectr_row*vectr_col;


multiply_1 = ones(3,3).*zeros(3, 3);%constant;

vectr_row(3) = [];
vectr_col(2) = [];
multiply_vextor_2 = vectr_row*vectr_col;

%% slide with saving data

clc;
clear all;
A = randi (10, 3, 4);
B = 5 + 4j;
C = 'cd';
save 'random_array.mat' 
clear all;
load 'random_array.mat' A B
M = magic(5);
writematrix(M, 'Magic.xls');


%% slide with files
clc;
clear all;
fid = fopen('poetry.txt', 'r+');
% [A, count] = fread(fid, inf, 'int8=>char');
[Char_from_File, Size_from_file] = fscanf(fid, '%c');
    
B = ' Завершено, это было легко';
fwrite(fid, B, 'char');
fprintf(fid, '\nЛекция займёт %4.2f часа\n', 1.5);
fclose(fid);


    