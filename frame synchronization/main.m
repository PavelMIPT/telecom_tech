clear, clc, close all;
%% Creating M-sequence
init_seed = [1, 0, 1, 0, 1, 0, 1];  % fixed initial registers state
seq_length = 2^7 - 1;
m_seq = M_sequence(init_seed, seq_length);

%% Properties of m-sequence
zero_count = 0;
ones_count = 0;
for i = 1 : length(m_seq)
    if m_seq(i) == 0
        zero_count = zero_count + 1;
    else 
        ones_count = ones_count + 1;
    end
end

if ones_count - zero_count == 1
    disp('Число единиц на 1 больше числа нулей');
end

m_seq_bpsk = mapping(m_seq, 'BPSK');

ac = Autocorrelation(m_seq_bpsk);  % АКФ принмает 2 значения 
fig1 = plot(ac);
xlim([0 260]);
title('Autocorrelation function');
grid on;
saveas(fig1, 'Autocorrelation.png');

%% Generating signal
data_length = 10 * seq_length;  % количество iq точек QPSK
all_len = data_length + seq_length;
frames_number = 1e4;
data = zeros(1, frames_number * all_len);
for i = 0 : frames_number - 1
    data_bit = randi([0,1], 1, 2 * data_length);
    data_iq = mapping(data_bit, 'QPSK');
    frame = [m_seq_bpsk, data_iq];  % 1 frame
    data(i * all_len + 1 : (i + 1) * all_len) = frame;
end

%% Probability of detection from SNR without frequency shift
SNR = -35 : 35;  % 

probabilities = zeros(1, length(SNR));

for j = 1 : length(SNR) 

    data_noised = NoiseGenerator(data, SNR(j));
    cor = Correlation(m_seq_bpsk, data_noised, 0);

    probabilities(j) = Probability_of_detection(cor, frames_number, all_len);
end

%% Depension probability of detection of SNR without frequency shift
fig2 = plot(SNR, probabilities);
title('Probability of detection of SNR without frequency shift');
xlabel('SNR, dB');
ylabel('Probability of symbol detection');
grid on;
saveas(fig2, 'SNR(prob).png');

%%  Depension probability of detection of SNR with frequency shift

% Частотные сдвиги
% f1 = 0.05;
% f2 = 0.1;
% f3 = 0.15;

% probabilities1 = zeros(1, length(SNR));
% probabilities2 = zeros(1, length(SNR));
% probabilities3 = zeros(1, length(SNR));

% frames_number2 = 100;
% data2 = zeros(1, frames_number2 * all_len);
% for i = 0 : frames_number2 - 1
%     data_bit = randi([0,1], 1, 2 * data_length);
%     data_iq = mapping(data_bit, 'QPSK');
%     frame = [m_seq_bpsk, data_iq];  % 1 frame
%     data2(i * all_len + 1 : (i + 1) * all_len) = frame;
% end
%%
R

%% Зависимость SNR от вероятности детектирования с частотным сдвигом
% fig3 = plot(SNR, probabilities1);
% % hold on;
% % plot(SNR, probabilities2);
% % hold on;
% % plot(SNR, probabilities3);
% % hold on;
% % plot(SNR, probabilities4);
% % hold on;
% % plot(SNR, probabilities5);
% % hold off;
% xlabel('SNR, dB');
% ylabel('Probability of symbol detection');
% grid on;
% % saveas(fig3, 'SNR(prob).png');
