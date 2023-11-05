% Audio Processing 
clear; clc; close all;
%% Task 1
filename1 = 'file1.wav';
[y1,Fs] = audioread(filename1);
% sound(y1,Fs);
x = linspace(0, 2000, 2000);
y2 = fft(y1); 

tiledlayout(2,1)

nexttile
plot(x, y1);
title('A(t)')

nexttile
graf1 = plot(x, abs(y2));
title('A(f)')

saveas(graf1, 'A1(f).png');
%% Signal filtering

y_ = abs(y2);
s = 101;
for i = 1:2000
    if (i ~= s)
       y_(i) = 0;
    else
        s = s + 100;
    end

end

tiledlayout(2,1)

nexttile
plot(x, abs(y2));

nexttile
plot(x, y_);

% sound(y_, Fs);

%% Task 2
filename2 = 'audio.wav';
t = 0:1 / 2500:3;
F = 2500;
signal = 3 * sin(1000 * t);
audiowrite(filename2, signal, F);

[y_new,F_] = audioread(filename2);
% sound(y_new, F_);

% Задайте уровень клиппинга (от 0 до 1)
clipping_level = 0.67; % Измените этот параметр в соответствии с вашим предпочтением

% Примените клиппинг эффект
clipped_audio = audioread(filename2);
clipped_audio(clipped_audio > clipping_level) = clipping_level;
clipped_audio(clipped_audio < -clipping_level) = -clipping_level;

% Воспроизведите аудиофайл после клиппинга
% sound(clipped_audio);

%% Task 3
% Установка частоту дискретизации в 2 раза меньше исходной
Fs_new = Fs / 2;

% Использование функции resample для изменения частоты дискретизации
output = resample(y1, Fs_new, Fs);

% Сохранение результата
audiowrite('новый_файл.wav', output, Fs_new);
[y_new_,Fs_] = audioread('новый_файл.wav');
% sound(y_new, Fs_);

x_new = linspace(0, Fs_new, Fs_new);

tiledlayout(2,1)

y_new__ = fft(y_new_);

nexttile
plot(x_new, y_new_);
title('A(t)')

nexttile
graph2 = plot(x_new, abs(y_new__));
title('A(f)')

saveas(graph2, 'A2(f).png');
%% Оценим среднии мощности сигналов на разных частотах дискретизации
Average_Power1 = mean(abs(y1).^2);
Average_Power2 = mean(abs(y_new_).^2);

disp(Average_Power1);
disp(Average_Power2);


%% Установим Установка частоту дискретизации в 2 раза больше исходной
Fs_new2 = Fs * 2;
% Использование функции resample для изменения частоты дискретизации
output2 = resample(y1, Fs_new2, Fs);

% Сохранение результата
audiowrite('новый_файл.wav', output2, Fs_new2);
[y_new_2,Fs_2] = audioread('новый_файл.wav');
% sound(y_new, Fs_);

x_new2 = linspace(0, Fs_new2, Fs_new2);

% plot(x_new2, y_new_2);
plot(x_new2, abs(fft(y_new_2)));

% Средняя мощность сигнала на удвоенной частоте дискретизации:
Average_Power3 = mean(abs(y_new_2).^2);
disp(Average_Power3);
