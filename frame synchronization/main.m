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
frames_number = 100;
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
f1 = 0.1;
f2 = 0.2;
f3 = -0.1;
f4 = -0.2;
data1 = data;
data2 = data1;
data3 = data1;
data4 = data1;

for i = 1 : length(data)
    data1(i) = data(i) * exp(2*pi*1i*f1*i);
    data2(i) = data(i) * exp(2*pi*1i*f2*i);
    data3(i) = data(i) * exp(2*pi*1i*f3*i);
    data4(i) = data(i) * exp(2*pi*1i*f4*i);
end

%% Probability of detection from SNR with frequency shift

probabilities1 = zeros(1, length(SNR));
probabilities2 = zeros(1, length(SNR));
probabilities3 = zeros(1, length(SNR));
probabilities4 = zeros(1, length(SNR));

for j = 1 : length(SNR) 
    data_noised1 = NoiseGenerator(data1, SNR(j));
    cor1 = Correlation(m_seq_bpsk, data_noised1, f1);
    probabilities1(j) = Probability_of_detection(cor1, frames_number, all_len);

    data_noised2 = NoiseGenerator(data2, SNR(j));
    cor2 = Correlation(m_seq_bpsk, data_noised2, f2);
    probabilities2(j) = Probability_of_detection(cor2, frames_number, all_len);

    data_noised3 = NoiseGenerator(data3, SNR(j));
    cor3 = Correlation(m_seq_bpsk, data_noised3, f3);
    probabilities3(j) = Probability_of_detection(cor3, frames_number, all_len);

    data_noised4 = NoiseGenerator(data4, SNR(j));
    cor4 = Correlation(m_seq_bpsk, data_noised4, f4);
    probabilities4(j) = Probability_of_detection(cor4, frames_number, all_len);
end

%% Зависимость SNR от вероятности детектирования с частотным сдвигом
fig3 = plot(SNR, probabilities, 'o');
hold on;
plot(SNR, probabilities1, 'o');
hold on;
plot(SNR, probabilities2, 'o');
hold on;
plot(SNR, probabilities3, 'o');
hold on;
plot(SNR, probabilities4, 'o');
hold off;
xlabel('SNR, dB');
ylabel('Probability of symbol detection with frequency shift');
legend('f = 0', 'f = 0.1', 'f = 0.2', 'f = -0.1', 'f = -0.2');
grid on;
% saveas(fig3, 'SNR(prob).png');
