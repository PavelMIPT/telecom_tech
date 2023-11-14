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

% сюда будем записывать инжексы соотв заголовков в битовой последовательности
bs1_indexes = [];  
bs2_indexes = [];

for i = 1 : len_bs1 - sequence_length
    if (all(Bit_Stream_1(i : i + 127) == header1))
        bs1_indexes = [bs1_indexes, i];  % добавляем индекс начала header в битовой последовательности
    end
end

for i = 1 : len_bs2 - sequence_length
    if (all(Bit_Stream_2(i : i + 127) == header2))
        bs2_indexes = [bs2_indexes, i];  % добавляем индекс начала header в битовой последовательности
    end
end

% Массивы расстояний между заголовками в битовых последовательностях
diff_bs1 = zeros(1, 18);
diff_bs2 = zeros(1, 17);

for i = 1 : 18
    diff_bs1(i) = bs1_indexes(i + 1) - bs1_indexes(i);
end

for i = 1 : 17
    diff_bs2(i) = bs2_indexes(i + 1) - bs2_indexes(i);
end

% Как видно из diff_bs1 и diff_bs2 массивов, битовые последовательности
% действительно имеют структу: ...Header|Data|Header|Data..., т.к
% расстояние между первыми индексами заголовков одинаковое как в случае 1
% последовательности, так и в случае 2 последовательности и равно:
% 4224

% Тогда длина блока данных Data равна:
Data_Length = bs1_indexes(2) - (bs1_indexes(1) + sequence_length);
% Длина кадра данных (Frame):
Frame_Length = Data_Length + sequence_length;

% Следующий целый кадр для битовой последовательности - Bit_Stream_1, как
% видно из bs1_indexes начинается с:
Start_Of_Frame_Position1 = bs1_indexes(2);

% Следующий целый кадр для битовой последовательности - Bit_Stream_2, как
% видно из bs2_indexes начинается с:
Start_Of_Frame_Position2 = bs2_indexes(2);

% Количество кадров (Frame) в битовой последовательности Bit_Stream_1:
% Проверим поместятся ли данные (Data) после последнего заголовка в двух
% битовых последовательностях:
len_last_data1 = len_bs1 - bs1_indexes(end) + 1 - sequence_length;
len_last_data2 = len_bs2 - bs2_indexes(end) + 1 - sequence_length;
% Как видно длины последовательстей бит после последних заголовков равны
% длине бит данных: 4096->всего имеем:
Number_of_Frames1 = size(bs1_indexes, 2);
Number_of_Frames2 = size(bs2_indexes, 2);

%% Построим график корреляции 2-ух битовых последовательностей
r = xcorr(Bit_Stream_1, Bit_Stream_2);
corr = plot(r);
title('График корреляции 2-ух битовых последовательностей');
xlabel('Число отсчетов');
ylabel('Значение корреляции');

saveas(corr, 'Frame_Corr.fig');

%% Исследуем корреляционные свойства M-последовательности и кода Голда
r1 = xcorr(header1);
r2 = xcorr(header2);

subplot(2, 1, 1);
graf = plot(r1);
title('Автокорреляция M-последовательности');
xlabel('Число отсчетов');
ylabel('Значение автокорреляции');

subplot(2, 1, 2);
plot(r2);
title('Автокорреляция кода Голда');
xlabel('Число отсчетов');
ylabel('Значение автокорреляции');

% Определим период M-последовательности
m = 5; % длина линии задержки
T = 2^m - 1;

saveas(graf, 'Autocorrelation.fig');