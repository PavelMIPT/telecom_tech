%% Digital processing
clear; clc; close all;
%% Creating a signal
Fs = 1000;  % Частота дискретизации
T = 1/Fs;  % Временной интервал
L = 1000;  % Длина сигнала

t = (0:L-1) * T;  % Временная ось
f = (0:L-1) * (Fs / L);  % Частотная ось

% Временной сигнал с тремя гармониками
S1 = 2; % Амплитуда первой гармоники
S2 = 3; % Амплитуда второй гармоники
S3 = 1; % Амплитуда третьей гармоники

f1 = 20; % Частота первой гармоники
f2 = 20; % Частота второй гармоники
f3 = 60; % Частота третьей гармоники

% Генерация сигнала на основе гармоник
signal = S1 * sin(2*pi*f1*t) + S2 * sin(2*pi*f2*t) + S3 * sin(2*pi*f3*t);

% Отображение графика сигнала
sig_without_noise = plot(t, signal);
xlabel('Время')
ylabel('Амплитуда')
title('Сигнал с тремя гармониками')

saveas(sig_without_noise, 'sig_without_noise.png');
saveas(sig_without_noise, 'sig_without_noise.fig');
%% Noise generation
SNR = 40; %  отношение сигнал-шум (dB)
noise = OnlyNoiseGenerator(SNR);
rng('default');
noised_signal = NoiseGenerator(signal, SNR);

tiledlayout(2,1)
ax1 = nexttile;
plot(ax1, t, noise);
title('Шум');

ax2 = nexttile;
s2 = plot(ax2, t, noised_signal);
title('Зашумленный сигнал');

saveas(s2, 'Noise_sig.png');
saveas(s2, 'Noise_sig.fig');
%% Powers of signals
P_signal = PowerSignal(signal);
P_noise = PowerSignal(noise);
P_noisedSignal = PowerSignal(noised_signal);
%% Parseval theorem
% Рассчет преобразования Фурье для исходного сигнала - signal
SignalSpec = fft(signal); % Преобразование Фурье исходного сигнала
Sig_spec = plot(f, abs(SignalSpec));

% вычислим спектры шума NoiseSpec и спектр результирующего сигнала NoisedSignalSpec
SignalSpec = fft(signal);
NoiseSpec = fft(noise);
NoisedSignalSpec = fft(noised_signal);

P_signal_spec = PowerSignal(SignalSpec);
P_noise_spec = PowerSignal(NoiseSpec);
P_noised_spec = PowerSignal(NoisedSignalSpec);

fprintf('%f\n', abs((length(signal) * P_signal - P_signal_spec)) / P_signal_spec);
fprintf('%f\n', abs((length(signal) * P_noise - P_noise_spec)) / P_noise_spec);
fprintf('%f\n', abs((length(signal) * P_noisedSignal - P_noised_spec)) / P_noised_spec);

if (abs((length(signal) * P_signal - P_signal_spec)) / P_signal_spec <= 0.1)
    fprintf('%s\n', 'True');
else
    fprintf('%s\n', 'False');
end

if (abs((length(signal) * P_noise - P_noise_spec)) / P_noise_spec <= 0.1)
    fprintf('%s\n', 'True');
else
    fprintf('%s\n', 'False');
end

if (abs((length(signal) * P_noisedSignal - P_noised_spec)) / P_noised_spec <= 0.1)
    fprintf('%s\n', 'True');
else
    fprintf('%s\n', 'False');
end
%% Signal filtering
% BandPass filter
FilteredNoisedSignal = FilterSignal(NoisedSignalSpec, f);

tiledlayout(2,1)
ax1 = nexttile;
plot(ax1, f, real(NoisedSignalSpec));
title('Зашумлённый сигнал');

ax2 = nexttile;
s3 = plot(ax2, f, real(FilteredNoisedSignal));
title('Зашумленный сигнал после BandPass фильтра');

saveas(s3, 'Filtering_signal.png');
saveas(s3, 'Filtering_signal.fig');
%% SNR comparison
% NoisedSignal SNR
SNR_NS = 10 * log10(P_signal / P_noise);
fprintf('%s%f%s\n', "Отношение сигнал-шум у зашумленного сигнала: ", SNR_NS, ' dB');
% FilteredNoisedSignal SNR
P_filter_signal = PowerSignal(FilterSignal(SignalSpec, f));
P_filter_noise = PowerSignal(FilterSignal(NoiseSpec, f));
SNR_FNS = 10 * log10(P_filter_signal / P_filter_noise);
fprintf('%s%f%s\n', "Отношение сигнал-шум у зашумленного сигнала после полосовой фильтрации: ", SNR_FNS, ' dB');
%% Conclusion
% Можно увидеть, что отношение сигнал-шум(SNR) у зашумленного сигнала после
% BandPass фильтра выше, следовательно качество
% зашумленного сигнала после полосовой фильтрации увеличивается
