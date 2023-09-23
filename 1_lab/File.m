clear all; clc; close all;

%% Analisys of text from file
% to-do
% 1) Reading the file as a text of array of chars

fileID = fopen('Textvar5.txt','r');
formatSpec = '%c';
A = lower(fscanf(fileID,formatSpec));

% 2) Create array of cells which consist of three columns
% "char"->"amount of meetings"->"probobilities"

len_A = length(A);  % number of all characters in the file
len_uA = length(unique(A));  % number of unique characters in the file

Data_Analisys = cell(len_uA, 3);  % "char"->"amount of meetings"->"probobilities"

counter = 1;
for ch = unique(A)
    Data_Analisys{counter, 1} = ch;
    Data_Analisys{counter, 2} = length(findstr(A,ch));
    Data_Analisys{counter, 3} = length(findstr(A,ch)) / len_A;

    counter = counter + 1;
end

% 3) Save the chars and probobalities to file *.mat and *.xls as the cell
% variables. Name the files should be:
% Data_Analisys.mat
% Data_Analisys.xls
% Data_Analisys.png

writecell(Data_Analisys, 'Data_Analisys.xls');
save ('Data_Analisys.mat');

% 4) Plot the distribution of probability of symbols in text. 
% Be careful to the labels on the axis.
% Recommendation use xticks(), xticklabels().

probability = cell2mat(Data_Analisys(:,3));

tmp = {'\n'; 'bs'; 'sp'};
Data_chars = Data_Analisys(:,1);

Data_chars(1) = tmp(1);
Data_chars(2) = tmp(2);
Data_chars(3) = tmp(3);

% x = cell2mat(Data_chars);
 
graf = bar(probability);
grid on;
xticks(1:len_uA);
xticklabels(Data_chars); 
xlabel('сhars, Xi');
ylabel('probobility, P(Xi)');

% 5) Save the plot as figure and PNG image with resolution at least 400 px. The name
% of files should be: Data_Analisys.png

saveas(graf, 'Data_Analisys.png');
saveas(graf, 'Data_Analisys.fig');
%% Reading the file
% TO-DO 1
% Read the file from *.txt as a char stream



%% Analysis
% TO-DO 2 
% Use ony char from file
% Use  lowercase string
% Try to use the "Cell" as a data containers;
% Name the varible Data_Analisys
% The cell should consist of 3 columns:
% "Symbol" | "Amount of meeting" | "Probolitie"

% You can use only 1 cycle for this task
% Avoid the memmory allocation in cycle



%% Plot Data
% TO-DO 3
% Illustrate the results from Analysis block
% There should be lable of axis, title, grid



%% Save the file
% TO-DO 4
% Save the figure as Data_Analisys.fig

% Save the figure as image Data_Analisys.png

% Save the data as MAT-file Data_Analisys.mat

% Save the data as Excel table Data_Analisys.xls
