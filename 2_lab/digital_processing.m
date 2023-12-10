%% Digital processing
clear; clc; close all;
%% Creating a signal
F = 128;  % Максимальное значение частоты
% fd = 0.1;  % Частота дискретизации
f = 1:128;

S1 = 2;  % Амплитуда первой гармоники
S2 = 3;  % Амплитуда второй гармоники
S3 = 1;  % Амплитуда третьей гармоники

w1 = 20;  % Частота первой гармоники
w2 = 40;  % Частота второй гармоники
w3 = 60;  % Частота третьей гармоники

% Генерация сигнала
Signal = zeros(1, F);
for i = 1 : F

    if i == w1
        Signal(i) = S1;

    elseif i == w2
        Signal(i) = S2;


    elseif i == w3
        Signal(i) = S3;
    end

end

% Отображение графика сигнала
sig_without_noise = plot(Signal);
xlabel('Частота');
ylabel('Амплитуда');
title('Сигнал с тремя гармониками');

saveas(sig_without_noise, 'sig_without_noise.png');
saveas(sig_without_noise, 'sig_without_noise.fig');

%% ifft
sig_ifft = ifft(Signal);
plot(abs(sig_ifft));
xlabel('время');
ylabel('Амплитуда');
title('Сигнал с тремя гармониками');
%% Noise generation
SNR = 40; %  отношение сигнал-шум (dB)
rng('default'); 
[NoisedSignal, Noise] = NoiseGenerator(Signal, SNR);

tiledlayout(2,1)
ax1 = nexttile;
plot(ax1, Noise);
title('Шум');
xlabel('Частота')
ylabel('Амплитуда')

ax2 = nexttile;
s2 = plot(ax2, NoisedSignal);
title('Зашумленный сигнал');
xlabel('Частота')
ylabel('Амплитуда')

% saveas(s2, 'Noise_sig.png');
% saveas(s2, 'Noise_sig.fig');
%% Powers of signals
P_signal = PowerSignal(Signal);
P_noise = PowerSignal(Noise);
P_noisedSignal = PowerSignal(NoisedSignal);
%% Parseval theorem
% Рассчет преобразования Фурье для исходного сигнала - signal
SignalSpec = fft(Signal); % Обратное преобразование Фурье исходного сигнала
Sig_spec = plot(abs(SignalSpec));

% вычислим спектры шума NoiseSpec и спектр результирующего сигнала NoisedSignalSpec
NoiseSpec = fft(Noise);
NoisedSignalSpec = fft(NoisedSignal);
% plot(abs(NoiseSpec));

P_signal_spec = PowerSignal(SignalSpec);
P_noise_spec = PowerSignal(NoiseSpec);
P_noised_spec = PowerSignal(NoisedSignalSpec);

if (abs((length(Signal) * P_signal - P_signal_spec)) / P_signal_spec <= 0.1)
    fprintf('%s\n', 'True');
else
    fprintf('%s\n', 'False');
end

if (abs((length(Signal) * P_noise - P_noise_spec)) / P_noise_spec <= 0.1)
    fprintf('%s\n', 'True');
else
    fprintf('%s\n', 'False');
end

if (abs((length(Signal) * P_noisedSignal - P_noised_spec)) / P_noised_spec <= 0.1)
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