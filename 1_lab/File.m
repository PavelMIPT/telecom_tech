clear all; clc; close all;

%% Analisys of text from file
% to-do
% 1) Reading the file as a text of array of chars

fileID = fopen('Textvar5.txt','r');
formatSpec = '%c';
A = lower(fscanf(fileID,formatSpec));

% 2) Create array of cells which consist of three columns
% "char"->"amount of meetings"->"probobilities"
len_A = length(A);
len_uA = length(unique(A));

newcell = cell(len_uA, 3);  % "char"->"amount of meetings"->"probobilities"


newcell{1, 1} = 'eof';
newcell{1, 2} = 1;
newcell{1, 3} = 1 / len_A; 
newcell{2, 1} = '\n';
newcell{2, 2} = 41;
newcell{2, 3} = 41 / len_A;

counter = 1;
for ch = unique(A)
    if counter > 2
        newcell{counter, 1} = ch;
        newcell{counter, 2} = length(findstr(A,ch));
        newcell{counter, 3} = length(findstr(A,ch)) / len_A;
    end
        counter = counter + 1;
end

newMatrix = sortrows(newcell, 3);

% 3) Save the chars and probobalities to file *.mat and *.xls as the cell
% variables. Name the files shouold be:
% Data_Analisys.mat
% Data_Analisys.xls
% Data_Analisys.png

chars = cell(1, len_uA);
probobalities = cell(1, len_uA);

for i = 1 : len_uA
    chars{1, i} = newMatrix{i, 1};
    probobalities{1, i} = newMatrix{i, 3};
end

% 4) Plot the distribution of probability of symbols in text. 
% Be careful to the labels on the axis.
% Recommendation use xticks(), xticklabels().

x = 1:len_uA;
Y = cell2mat(probobalities);

% graf = plot(x, Y, 'o', Color='red');
graf = bar(x, Y, 0.5);
xlim([0 43]);
grid on;

xticks(1:1:len_uA);

xticklabels({'eof',':', '«','»','ф','щ','ё','ц','!','—',';','.','ж','ш','х','ч','к','ь','б','ю','г','п','й','ы',',','з','м','я','д','в','р','\n','л','т','у','с','и','а','о','е','н',' '});
xlabel('сhars, Xi');
ylabel('probobility, P(Xi)');

writematrix(Y, 'Data_Analisys.xls');
save 'Data_Analisys.mat';

% save("chars.mat");
% 5) Save the plot as figure and PNG image with resolution at least 400 px. The name
% of files should be: Data_Analisys.png

saveas(graf, 'Data_Analisys.png');
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
