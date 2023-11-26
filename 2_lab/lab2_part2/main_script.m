%% Correlation Analysis
clear all; clc; close all;

%% Создадим 2 M-последовательности
sequence_length = 128;  % длина будущего заголовка
initial_seed1 = [1, 1, 1, 1, 0];
initial_seed2 = [0, 0, 0, 0, 1];
m_sequence1 = M_sequence_1(initial_seed1, sequence_length);
m_sequence2 = M_sequence_2(initial_seed2, sequence_length);

%% Создадим 2 заголовка для 2 битовых последовательностей
header1 = xor(m_sequence1, m_sequence2);  % сгенерирован с помощью кода Голда
header2 = m_sequence1;  % сгенерирован M-последовательностью

%% Исследуем 2 битовые последовательности
load('Matlab_L3_9 (2).mat');  % загрузим наши битовые последовательности

len_bs1 = size(Bit_Stream_1, 2);
len_bs2 = size(Bit_Stream_2, 2);

subplot(2, 1, 1);
graf = plot(xcorr(header1, Bit_Stream_1));
title('Корреляция сигнала Bit_Stream_1 с 1 заголовком');
xlabel('Число отсчетов');
ylabel('Значение корреляции');

subplot(2, 1, 2);
plot(xcorr(header2, Bit_Stream_2));
title('Корреляция сигнала Bit_Stream_2 со 2 заголовком');
xlabel('Число отсчетов');
ylabel('Значение корреляции');

corr1 = xcorr(header1, Bit_Stream_1);
corr2 = xcorr(header2, Bit_Stream_2);

error = 10e-10;

% Количество кадров в 1 битовой последовательности
A1 = find(corr1 > max(corr1) - error);
Number_of_Frames1 = length(A1);

% Количество кадров во 2 битовой последовательности
A2 = find(corr2 > max(corr2) - error);
Number_of_Frames2 = length(A2);

% Длина блока данных Data
Data_Length = A1(2) - (A1(1) + sequence_length);

% Длина блока данных Frame
Frame_Length = Data_Length + sequence_length;

% Позиции начала следующих кадров
Start_Of_Frame_Position1 = A1(2);

saveas(graf, 'Frame_Corr.fig');
%% Исследуем корреляционные свойства M-последовательности и кода Голда
r1 = xcorr(header1, "unbiased");
r2 = xcorr(header2, "unbiased");

subplot(2, 1, 1);
t = linspace(-128, 128, 255);
graf = plot(t, r1);
title('Автокорреляция M-последовательности');
xlabel('Число отсчетов');
ylabel('Значение автокорреляции');

subplot(2, 1, 2);
plot(t, r2);
title('Автокорреляция кода Голда');
xlabel('Число отсчетов');
ylabel('Значение автокорреляции');

% Определим период M-последовательности
m = 5; % длина линии задержки
T = 2^m - 1;

saveas(graf, 'Autocorrelation.fig');